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

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIButton *searchButton;
    UIImageView *searchImageView;
    UITableView *foodsTableView;
    NSInteger numberOfRowsInFoods;
    NSArray *foodArray;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView{
    //初始化页面
    searchButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 65, SCREENWIDTH, 50)];
    searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    [searchImageView setImage:[UIImage imageNamed:@"searchimg"]];
    [searchButton addSubview:searchImageView];
    foodsTableView =[[UITableView alloc] initWithFrame:CGRectMake(5, 115, SCREENWIDTH-10, SCREENHEIGHT-115-60)
                                                 style:UITableViewStylePlain];
    [self.view addSubview:searchButton];
    [self.view addSubview:foodsTableView];
    
    
}

//数据源方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //被点击的事件
    NSLog(@"列表被点击了");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection");
    if (section == 0) {
        return numberOfRowsInFoods;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //显示一行数据
    FoodUITableViewCell *cell = [[FoodUITableViewCell alloc]initWithStyle:UITableViewStylePlain reuseIdentifier:nil];
    if (0 == indexPath.section) {
        NSInteger row = indexPath.row;
        NSString *foodName = (NSString *)[foodArray[row] objectForKey:@"foodname"];
        NSString *foodImg = (NSString *)[foodArray[row] objectForKey:@"foodimg"];
        NSString *foodId = (NSString *)[foodArray[row] objectForKey:@"id"];
        NSString *content = (NSString *)[foodArray[row] objectForKey:@"content"];
        [cell setFoodImgImageView:foodImg foodNameLabel:foodName contentLabel:content];
        [self tableView:foodsTableView heightForRowAtIndexPath:indexPath];
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
        //NSLog(@"%@", responseObject);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        //NSLog(@"%@", dic);
        NSString *code = (NSString *)[dic objectForKey:@"code"];
        //NSLog(@"code = %@",code);
        if ([code isEqualToString:@"200"]) {
            foodArray = (NSArray *)[dic objectForKey:@"list"];
            numberOfRowsInFoods =  [foodArray count];
            NSLog(@"foodsArray count = %ld",numberOfRowsInFoods);
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



//- (void)getFoodsAction{
//   
//    NSMutableDictionary *params = [NSMutableDictionary new];
//    [params setValue:@"1" forKey:@"pageNum"];
//    [params setValue:@"15" forKey:@"pageSize"];
//    if ([HttpUtil NetWorkIsOK]) {
//        [HttpUtil post:[ValueUtil getFoodsURL] RequestParams:params FinishBlock:^(NSURLResponse *response,NSData *data,NSError *connectionError){
//            if(data){
//                [self performSelectorOnMainThread:@selector(getFoodsCallBack:) withObject:data waitUntilDone: YES];
//            }else{
//                NSLog(@"无效的数据");
//            }
//        }];
//    }
//}

//-(void)getFoodsCallBack:(id)value{
//    //设置UITableView的代理对象
//    _foodsTable.dataSource = self;
//    //设置UITableView的数据源
//    _foodsTable.delegate = self;
//    NSData *data = (NSData *)value;
//    NSError *error;
//    NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//    NSString *code = (NSString *)[resultDictionary objectForKey:@"code"];
//    if ([code isEqualToString:@"200"]) {
//        //访问成功
//        NSLog(@"获取菜谱列表成功");
//        //解析菜谱数据
//        NSArray *foodArray = (NSArray *)[resultDictionary  objectForKey:@"list"];
//        _foodArray = foodArray;
//        _numberOfRowsInFoods = foodArray.count;
//        
//
//        
//    }
//}


//数据源方法
#pragma mark - UITableViewDataSource

////1告诉tableview一共多少组
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//};
//
////2第section组有多少行
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if(0 == section){
//        //NSLog(@"%d",_numberOfRowsInFoods);
//        return _numberOfRowsInFoods;
//    }
//    return 0;
//}
////3告知系统每一行显示什么内容
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"显示每一行的数据");
//    FoodUITableViewCell *cell = [[FoodUITableViewCell alloc]initWithStyle:UITableViewStylePlain reuseIdentifier:nil];
//    if (0 == indexPath.section) {
//        NSInteger row = indexPath.row;
//        NSString *foodName = (NSString *)[_foodArray[row] objectForKey:@"foodname"];
//        NSString *foodImg = (NSString *)[_foodArray[row] objectForKey:@"foodimg"];
//        NSString *foodId = (NSString *)[_foodArray[row] objectForKey:@"id"];
//        NSString *content = (NSString *)[_foodArray[row] objectForKey:@"content"];
//        [cell setFoodImgImageView:foodImg foodNameLabel:foodName contentLabel:content];
//        [self tableView:_foodsTable heightForRowAtIndexPath:indexPath];
//    }
//    return cell;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 200;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
