//
//  SearchViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/6/9.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "SearchViewController.h"
#import "UIColor+ZXLazy.h"
#import "AFNetworking.h"
#import "ValueUtil.h"
#import "FoodUITableViewCell.h"

#define SCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen]bounds].size.height

@interface SearchViewController()<UITableViewDataSource,UITableViewDelegate>{
    UIView *searchView;
    UITextField *searchField;
    UIButton *searchButton;
    NSArray *foodArray;
    NSInteger numberOfRowsInFoods;
    UITableView *foodsTableView;
    NSInteger cellHeight;
}
@end

@implementation SearchViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [self initView];
}
- (void)initView{
    //隐藏导航栏
    

    searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 75, SCREENWIDTH, 40)];
    //searchView.backgroundColor = [UIColor whiteColor];
    
    searchField = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, SCREENWIDTH-70, 40)];
    [searchField setBorderStyle:UITextBorderStyleRoundedRect];
    searchField.placeholder = @"输入搜索内容";
    searchField.layer.cornerRadius = 5;
    searchField.clearsOnBeginEditing = YES;
    searchField.backgroundColor = [UIColor whiteColor];
    
    searchButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH-60, 0, 50, 40)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.backgroundColor = [UIColor redColor];
    searchButton.layer.cornerRadius = 5;
    [searchButton addTarget:self action:@selector(getFood) forControlEvents:UIControlEventTouchUpInside];
    
    foodsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, SCREENWIDTH, SCREENHEIGHT-120)];
    
    [searchView addSubview:searchField];
    [searchView addSubview:searchButton];
    [self.view addSubview:searchView];
    [self.view addSubview:foodsTableView];
    
    cellHeight = 0;
    
}
- (void)toBack{
    //返回上一页
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getFood{
    NSString *searchKey = searchField.text;
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:searchKey forKey:@"key"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[ValueUtil getSearchFood] parameters:params constructingBodyWithBlock:^(id _Nonnull formData){
    }progress:^(NSProgress * _Nonnull uploadProgress){
        
    }success:^(NSURLSessionDataTask * _Nonnull task,id _Nonnull responseObject){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSString *code = (NSString *)[dic objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            foodArray = (NSArray *)[dic objectForKey:@"list"];
            numberOfRowsInFoods = [foodArray count];
            foodsTableView.dataSource = self;//设置食物列表的数据源
            foodsTableView.delegate = self;//设置食物列表的代理对象
            [foodsTableView reloadData];
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        //NSLog(@"请求失败");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"搜索菜谱失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
}
//数据源方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180 + cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return numberOfRowsInFoods;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodUITableViewCell *cell = [[FoodUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (0 == indexPath.section) {
        NSInteger row = indexPath.row;
        NSString *foodName = (NSString *)[foodArray[row] objectForKey:@"foodname"];
        NSString *foodImg = (NSString *)[foodArray[row] objectForKey:@"foodimg"];
        NSString *foodId = (NSString*)[foodArray[row] objectForKey:@"id"];
        NSString *content = (NSString *)[foodArray[row] objectForKey:@"content"];
        //NSLog(@"foodId1 = %@",foodId);
        cellHeight = [cell setFoodImgImageView:foodImg foodNameLabel:foodName contentLabel:content foodId:[foodId intValue]];
        [self tableView:tableView heightForRowAtIndexPath:indexPath];
        return cell;
    }
    return nil;
}
@end
