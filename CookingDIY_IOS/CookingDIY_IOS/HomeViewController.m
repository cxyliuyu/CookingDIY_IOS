//
//  HomeViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/3/19.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "HomeViewController.h"
#import "ValueUtil.h"
#import "HttpUtil.h"
#import "FoodUITableViewCell.h"
#import "AFNetworking.h"
#import "UIColor+ZXLazy.h"
#import "MJRefresh.h"
#import "SearchViewController.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIButton *searchButton;
    UIImageView *searchImageView;
    UITableView *foodsTableView;
    NSInteger numberOfRowsInFoods;
    NSArray *foodArray;
    NSInteger cellHeight;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self) {
        self.navigationItem.title = @"首页";
    }
    [self initView];
    numberOfRowsInFoods = 0;
    [self getFoodsAction];
    foodsTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        NSLog(@"下拉刷新回掉");
        [foodsTableView.header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView{
    //初始化页面
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    searchButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 65, SCREENWIDTH, 50)];
    searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    [searchImageView setImage:[UIImage imageNamed:@"searchimg"]];
    [searchButton addSubview:searchImageView];
    foodsTableView =[[UITableView alloc] initWithFrame:CGRectMake(5, 115, SCREENWIDTH-10, SCREENHEIGHT-115-60)
                                                 style:UITableViewStylePlain];
    foodsTableView.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    [self.view addSubview:searchButton];
    [self.view addSubview:foodsTableView];
    
    [searchButton addTarget:self action:@selector(toSearch) forControlEvents:UIControlEventTouchUpInside];
    cellHeight = 0;
    
}

- (void)toSearch{
    //前往搜索页面
    SearchViewController *searchViewController = [[SearchViewController alloc]init];
    //[self presentViewController:searchViewController animated:YES completion:nil];
    [self.navigationController pushViewController:searchViewController animated:YES];
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

-(void) getFoodsAction{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:@"1" forKey:@"pageNum"];
    [params setValue:@"15" forKey:@"pageSize"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //post请求
    [manager POST:[ValueUtil getFoodsURL] parameters:params constructingBodyWithBlock:^(id  _Nonnull formData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功，解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        //NSLog(@"%@", dic);
        NSString *code = (NSString *)[dic objectForKey:@"code"];
        //NSLog(@"code = %@",code);
        if ([code isEqualToString:@"200"]) {
            foodArray = (NSArray *)[dic objectForKey:@"list"];
            numberOfRowsInFoods =  [foodArray count];
            //NSLog(@"foodsArray count = %ld",numberOfRowsInFoods);
            foodsTableView.dataSource = self;//设置食物列表的数据源
            foodsTableView.delegate = self;//设置食物列表的代理对象
        }
        [foodsTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 请求失败
        NSLog(@"请求失败");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"加载菜谱失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
}





@end
