//
//  FoodListViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/6/10.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "FoodListViewController.h"
#import "UIColor+ZXLazy.h"
#import "NSUserDefaultsUtil.h"
#import "AFNetworking.h"
#import "ValueUtil.h"
#import "MJRefresh.h"
#import "FoodUITableViewCell.h"

#define SCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen]bounds].size.height
@interface FoodListViewController()<UITableViewDataSource,UITableViewDelegate>{
    UINavigationBar *foodListNavBar;
    NSString *userId;
    NSArray *foodArray;
    NSInteger numberOfRowsInFoods;
    UITableView *foodsTableView;
    NSInteger cellHeight;
}
@end
@implementation FoodListViewController
-(void)viewDidLoad{
    userId = [NSUserDefaultsUtil getNSString:@"userId"];
    [self initView];
    numberOfRowsInFoods = 0;
    [self getData];
    foodsTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        NSLog(@"下拉刷新回掉");
        [foodsTableView.header endRefreshing];
    }];
}

-(void)initView{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    foodListNavBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 68)];
    foodListNavBar.backgroundColor = [UIColor whiteColor];
    UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:_myTitle];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"<返回" style:UIBarButtonItemStyleDone target:self action:@selector(toBack)];
    [navigationItem setLeftBarButtonItem:leftButton];
    [foodListNavBar pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:foodListNavBar];
    foodsTableView =[[UITableView alloc] initWithFrame:CGRectMake(5, 115, SCREENWIDTH-10, SCREENHEIGHT-115-60)style:UITableViewStylePlain];
    foodsTableView.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    [self.view addSubview:foodsTableView];
    cellHeight = 0;
    
}

-(void)getData{
    //获取数据
    NSMutableDictionary *params = [NSMutableDictionary new];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if ([_action isEqualToString:@"MYSAVE"]) {
        [params setValue:@"1" forKey:@"pageNum"];
        [params setValue:@"15" forKey:@"pageSize"];
        [params setValue:userId forKey:@"userId"];
        [manager POST:[ValueUtil getSaveByPage] parameters:params constructingBodyWithBlock:^(id  _Nonnull formData) {
            // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            // 这里可以获取到目前的数据请求的进度
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 请求成功，解析数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSString *code = (NSString *)[dic objectForKey:@"code"];
            //NSLog(@"code = %@",code);
            if ([code isEqualToString:@"200"]) {
                foodArray = (NSArray *)[dic objectForKey:@"list"];
                numberOfRowsInFoods =  [foodArray count];
                foodsTableView.dataSource = self;//设置食物列表的数据源
                foodsTableView.delegate = self;//设置食物列表的代理对象
                [foodsTableView reloadData];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            // 请求失败
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"加载菜谱失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
    if ([_action isEqualToString:@"MYFOOD"]) {
        [params setValue:@"1" forKey:@"pageNum"];
        [params setValue:@"15" forKey:@"pageSize"];
        [params setValue:userId forKey:@"userId"];
        [manager POST:[ValueUtil getFoodsByUserId] parameters:params constructingBodyWithBlock:^(id  _Nonnull formData) {
            // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
                
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            // 这里可以获取到目前的数据请求的进度
                
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 请求成功，解析数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSString *code = (NSString *)[dic objectForKey:@"code"];
            if ([code isEqualToString:@"200"]) {
                foodArray = (NSArray *)[dic objectForKey:@"list"];
                numberOfRowsInFoods =  [foodArray count];
                foodsTableView.dataSource = self;//设置食物列表的数据源
                foodsTableView.delegate = self;//设置食物列表的代理对象
                [foodsTableView reloadData];
            }
                
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            // 请求失败
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"加载菜谱失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }];
        
    }
}

-(void)toBack{
    [self dismissViewControllerAnimated:NO completion:nil];
}

//数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection");
    if (section == 0) {
        return numberOfRowsInFoods;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180+cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{	
    //显示一行数据
    FoodUITableViewCell *cell = [[FoodUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.foodListViewController = self;
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
