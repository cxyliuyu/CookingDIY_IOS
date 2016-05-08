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

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property UIImageView *searchImg;
@property UITableView *foodsTable;
@property NSInteger numberOfRowsInFoods;
@property NSArray *foodArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    super.view.backgroundColor = [UIColor redColor];
    if (self) {
        self.navigationItem.title = @"首页";
    }
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView{
    //初始化页面
    _searchImg = [UIImageView new];
    _searchImg.frame = CGRectMake(0, 65, SCREENWIDTH, 50);
    [_searchImg setImage:[UIImage imageNamed:@"searchimg"]];
    _foodsTable =[[UITableView alloc] initWithFrame:CGRectMake(5, 115, SCREENWIDTH-10, SCREENHEIGHT-115-60) style:UITableViewStylePlain];
    
    
    //_foodsTable.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_searchImg];
    [self.view addSubview:_foodsTable];
    [self getFoodsAction];
    
    
}

- (void)getFoodsAction{
   
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:@"1" forKey:@"pageNum"];
    [params setValue:@"15" forKey:@"pageSize"];
    if ([HttpUtil NetWorkIsOK]) {
        [HttpUtil post:[ValueUtil getFoodsURL] RequestParams:params FinishBlock:^(NSURLResponse *response,NSData *data,NSError *connectionError){
            if(data){
                [self performSelectorOnMainThread:@selector(getFoodsCallBack:) withObject:data waitUntilDone: YES];
            }else{
                NSLog(@"无效的数据");
            }
        }];
    }
    
                          
}

-(void)getFoodsCallBack:(id)value{
    NSData *data = (NSData *)value;
    NSError *error;
    NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSString *code = (NSString *)[resultDictionary objectForKey:@"code"];
    if ([code isEqualToString:@"200"]) {
        //访问成功
        NSLog(@"获取菜谱列表成功");
        //解析菜谱数据
        NSArray *foodArray = (NSArray *)[resultDictionary  objectForKey:@"list"];
        _foodArray = foodArray;
        _numberOfRowsInFoods = foodArray.count;
        _foodsTable.dataSource = self;
        _foodsTable.delegate = self;

        
    }
}


//数据源方法
#pragma mark - UITableViewDataSource

//1告诉tableview一共多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
};

//2第section组有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(0 == section){
        //NSLog(@"%d",_numberOfRowsInFoods);
        return _numberOfRowsInFoods;
    }
    return 0;
}
//3告知系统每一行显示什么内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"显示每一行的数据");
    FoodUITableViewCell *cell = [[FoodUITableViewCell alloc]initWithStyle:UITableViewStylePlain reuseIdentifier:nil];
    if (0 == indexPath.section) {
        NSInteger row = indexPath.row;
        NSString *foodName = (NSString *)[_foodArray[row] objectForKey:@"foodname"];
        NSString *foodImg = (NSString *)[_foodArray[row] objectForKey:@"foodimg"];
        NSString *foodId = (NSString *)[_foodArray[row] objectForKey:@"id"];
        NSString *content = (NSString *)[_foodArray[row] objectForKey:@"content"];
        [cell setFoodImgImageView:foodImg foodNameLabel:foodName contentLabel:content];
        [self tableView:_foodsTable heightForRowAtIndexPath:indexPath];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
