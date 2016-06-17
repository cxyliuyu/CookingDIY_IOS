//
//  MessageViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/3/19.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "MessageViewController.h"
#import "AFNetworking.h"
#import "ValueUtil.h"
#import "CommentUITableViewCell.h"
#import "NSUserDefaultsUtil.h"
#import "UIColor+ZXLazy.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *commentTableView;
    NSArray *commentArray;
    NSInteger numberOfRowsInComments;
    NSInteger cellHeight;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //super.view.backgroundColor = [UIColor blueColor];
    if (self) {
        self.navigationItem.title = @"消息";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView{
    commentTableView = [UITableView new];
    commentTableView.frame = CGRectMake(5, 70, SCREENWIDTH-10, SCREENHEIGHT-70);
    
}

- (void)refreshView{
    if ([NSUserDefaultsUtil getBoolean:@"ISLOGIN"] == YES ) {
        NSMutableDictionary *params = [NSMutableDictionary new];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [params setValue:[NSUserDefaultsUtil getNSString:@"userId"] forKey:@"userId"];
        [manager POST:[ValueUtil getCommentByFoodId] parameters:params constructingBodyWithBlock:^(id  _Nonnull formData) {
            // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            // 这里可以获取到目前的数据请求的进度
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 请求成功，解析数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSString *code = (NSString *)[dic objectForKey:@"code"];
            //NSLog(@"code = %@",dic);
            if ([code isEqualToString:@"200"]) {
                commentArray = (NSArray *)[dic objectForKey:@"list"];
                numberOfRowsInComments =  [commentArray count];
                commentTableView.dataSource = self;//设置食物列表的数据源
                commentTableView.delegate = self;//设置食物列表的代理对象
                [commentTableView reloadData];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            // 请求失败
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"加载菜谱失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }];
        
    }
    
}

//数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection = %ld",numberOfRowsInComments);
    if (section == 0) {
        return numberOfRowsInComments;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55 + cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //显示一行数据
    CommentUITableViewCell *cell = [[CommentUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (0 == indexPath.section) {
        NSInteger row = indexPath.row;
        NSString *userImg = (NSString *)[commentArray[row] objectForKey:@"userimg"];
        NSString *trueName = (NSString *)[commentArray[row] objectForKey:@"truename"];
        NSString *content = (NSString*)[commentArray[row] objectForKey:@"content"];
        NSString *time = (NSString *)[commentArray[row] objectForKey:@"time"];
        //NSLog(@"foodId1 = %@",foodId);
        cellHeight = [cell setUserImgView:userImg userNameView:trueName ContentView:content timeView:time];
        [self tableView:tableView heightForRowAtIndexPath:indexPath];
        return cell;
    }
    return nil;
    
}

@end
