//
//  FoodDetailViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "UIColor+ZXLazy.h"
#import "AFNetworking.h"
#import "ValueUtil.h"
#import "FoodUITableViewCell.h"
#import "FoodListUITableViewCell.h"
#import "FoodStepUITableViewCell.h"

#define SCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen]bounds].size.height

@interface FoodDetailViewController()<UITableViewDataSource,UITableViewDelegate>{
    UINavigationBar *foodDetailNavBar;
    UITableView *foodDetailTableView;
    NSDictionary *foodDic;
    NSArray *foodListArray;
    NSArray *foodStepsArray;
    NSInteger numberOfFoodList;//材料的种类数
    NSInteger numberOfFoodStep;//做菜步骤数
}
@end
@implementation FoodDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    NSLog(@"显示菜谱详情页面");
    [self initView];
    
    [self getFoodById];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView{
    foodDetailNavBar = [UINavigationBar new];
    foodDetailNavBar.frame = CGRectMake(0, 0, SCREENWIDTH, 68);
    foodDetailNavBar.backgroundColor = [UIColor whiteColor];
    UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:@"菜谱详情"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem new]initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    [navigationItem setLeftBarButtonItem:leftButton];
    [foodDetailNavBar pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:foodDetailNavBar];
    //NSLog(@"foodId3 = %ld",_foodId);
    foodDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, SCREENHEIGHT, SCREENHEIGHT-70) style:UITableViewStyleGrouped];
    foodDetailTableView.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    [self.view addSubview:foodDetailNavBar];
    [self.view addSubview:foodDetailTableView];
}

- (void)toBack{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)getFoodById{
    //根据菜谱id获取菜谱详情
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:[[NSString alloc]initWithFormat:@"%ld",_foodId] forKey:@"id"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[ValueUtil getGetFoodByIdURL] parameters:params constructingBodyWithBlock:^(id _NonnullformData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        
    }  progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@", dic);
        NSString *code = (NSString *)[dic objectForKey:@"code"];
        
        if ([code isEqualToString:@"200"]) {
            foodDic = (NSDictionary *)[dic objectForKey:@"food"];
            foodListArray = (NSArray *)[dic objectForKey:@"foodlist"];
            foodStepsArray = (NSArray *)[dic objectForKey:@"foodsteps"];
//           NSLog(@"%@", foodDic);
//           NSLog(@"%@", foodListArray);
//           NSLog(@"%@",foodStepsArray);
            numberOfFoodList = [foodListArray count];
            numberOfFoodStep = [foodStepsArray count];
            foodDetailTableView.dataSource = self;
            foodDetailTableView.delegate = self;
            [foodDetailTableView reloadData];
        }
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"请求失败");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"加载菜谱失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
}

//UItableView的数据源以及代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回节的个数
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"numberOfRowsInSection");
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return  numberOfFoodList;
    }
    if (section == 2) {
        return numberOfFoodStep;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }
    if (indexPath.section == 1) {
        return 30;
    }
    if (indexPath.section == 2) {
        return 200;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (indexPath.section == 0) {
        FoodUITableViewCell *cell1 = [[FoodUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        NSString *foodName = (NSString *)[foodDic objectForKey:@"foodname"];
        NSString *foodImg = (NSString *)[foodDic objectForKey:@"foodimg"];
        NSString *foodId =  (NSString *)[foodDic objectForKey:@"id"];
        NSString *content = (NSString *)[foodDic objectForKey:@"content"];
        [cell1 setFoodImgImageView:foodImg foodNameLabel:foodName contentLabel:content foodId:[foodId intValue]];
        [self tableView:tableView heightForRowAtIndexPath:indexPath];
        cell1.userInteractionEnabled = NO;//设置不能被点击
        return cell1;
    }
    if (indexPath.section == 1) {
        FoodListUITableViewCell *cell2 = [[FoodListUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        NSString *foodListName = [foodListArray[row] objectForKey:@"foodlistname"];
        NSString *foodListCount = [foodListArray[row] objectForKey:@"foodlistcount"];
        [cell2 setFoodlistName:foodListName foodlistcount:foodListCount];
        [self tableView:tableView heightForRowAtIndexPath:indexPath];
        cell2.userInteractionEnabled = NO;//设置不能被点击
        return cell2;
    }
    if (indexPath.section == 2) {
        FoodStepUITableViewCell *cell3 = [[FoodStepUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        NSString *foodImg = (NSString *)[foodStepsArray[row] objectForKey:@"stepimg"];
        NSString *foodContent = (NSString *)[foodStepsArray[row] objectForKey:@"steptxt"];
        //NSLog(@"foodimg = %@",foodImg);
        [cell3 setFoodImgImageView:foodImg foodContentTextView:foodContent];
        cell3.userInteractionEnabled = NO;//设置不能被点击
        return cell3;
    }
    return nil;
}
@end
