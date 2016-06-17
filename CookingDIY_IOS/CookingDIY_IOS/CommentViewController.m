//
//  CommentViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/6/9.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "CommentViewController.h"
#import "UIColor+ZXLazy.h"
#import "AFNetworking.h"
#import "ValueUtil.h"
#import "CommentUITableViewCell.h"
#import "NSUserDefaultsUtil.h"

#define SCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen]bounds].size.height

@interface CommentViewController()<UITableViewDataSource,UITableViewDelegate>{
    UINavigationBar *commentNavBar;
    UITableView *commentTableView;
    UIView *formView;
    UITextField *commentField;
    UIButton *commentButton;
    NSArray *commentArray;
    NSInteger numberOfRowsInComments;
    NSInteger cellHeight;
}

@end
@implementation CommentViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self initView];
    
    [self refreshView];
    
    [self addNotification];
}

- (void)initView{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    commentNavBar = [UINavigationBar new];
    commentNavBar.frame = CGRectMake(0, 0, SCREENHEIGHT, 68);
    commentNavBar.backgroundColor = [UIColor whiteColor];
    UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:@"评论"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem new]initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    [navigationItem setLeftBarButtonItem:leftButton];
    [commentNavBar pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:commentNavBar];
    
    formView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-50, SCREENWIDTH, 50)];
    formView.backgroundColor = [UIColor whiteColor];
    
    commentField = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, SCREENWIDTH-80, 40)];
    commentField.placeholder = @"请输入用户名";
    commentField.borderStyle = UITextBorderStyleRoundedRect;
    commentField.layer.cornerRadius = 5;
    commentField.clearsOnBeginEditing = YES;
    [formView addSubview:commentField];
    
    commentButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH-75, 5, 70, 40)];
    [commentButton setTitle:@"提交" forState:UIControlStateNormal];
    commentButton.layer.cornerRadius = 10;
    commentButton.backgroundColor = [UIColor colorWithHexString:@"#339933"];
    [formView addSubview:commentButton];
    
    commentTableView = [UITableView new];
    commentTableView.backgroundColor = [UIColor colorWithHexString:@"EFEFF4"];
    commentTableView.frame = CGRectMake(0, 70, SCREENWIDTH, SCREENHEIGHT-70-50);
    [self.view addSubview:commentTableView];
    [self.view addSubview:formView];
    cellHeight = 0;
    
    [commentButton addTarget:self action:@selector(addComment) forControlEvents:UIControlEventTouchUpInside];
}

- (void)refreshView{
    NSMutableDictionary *params = [NSMutableDictionary new];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [params setValue:@"1" forKey:@"pageNum"];
    [params setValue:@"15" forKey:@"pageSize"];
    //NSLog(@"foodId = %ld",_foodId);
    [params setValue:[[NSString alloc]initWithFormat:@"%ld",_foodId] forKey:@"foodId"];
    
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

- (void)addNotification{
    //添加通知的监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWillShow:(NSNotification *)aNotification{
    //键盘打开
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    formView.frame = CGRectMake(0, SCREENHEIGHT-50-height, SCREENWIDTH, 50);
    
}

- (void)keyboardWillHide:(NSNotification *)aNotification{
    formView.frame = CGRectMake(0, SCREENHEIGHT-50, SCREENWIDTH, 50);
}

- (void)addComment{
    NSString *commentContent = commentField.text;
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:[[NSString alloc]initWithFormat:@"%ld",_foodId] forKey:@"foodId"];
    [params setValue:commentContent forKey:@"content"];
    [params setValue:[NSUserDefaultsUtil getNSString:@"userId"] forKey:@"userId"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"commentContent = %@",commentContent);
    [manager POST:[ValueUtil addFood]parameters:params constructingBodyWithBlock: ^(id _NonnullformData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
    }  progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"请求数据成功");
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSString *code = (NSString *)[dic objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            //已被收藏
            [self refreshView];
        }else{
            //未被收藏
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"加载菜谱失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"请求失败");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"加载菜谱失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
}
- (void)toBack{
    //返回上一页
    [self dismissViewControllerAnimated:NO completion:nil];
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
