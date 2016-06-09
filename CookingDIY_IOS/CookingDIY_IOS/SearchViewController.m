//
//  SearchViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/6/9.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "SearchViewController.h"
#import "UIColor+ZXLazy.h"

#define SCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen]bounds].size.height

@interface SearchViewController()<UITableViewDataSource,UITableViewDelegate>{
    UINavigationBar *commentNavBar;
    UIView *searchView;
    UITextField *searchField;
    UIButton *searchButton;
}
@end

@implementation SearchViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [self initView];
}
- (void)initView{
    commentNavBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREENHEIGHT, 68)];
    commentNavBar.backgroundColor = [UIColor whiteColor];
    UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:@"搜索"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    [navigationItem setLeftBarButtonItem:leftButton];
    [commentNavBar pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:commentNavBar];
    searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 75, SCREENWIDTH, 40)];
    //searchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchView];
    searchField = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, SCREENWIDTH-70, 40)];
    [searchField setBorderStyle:UITextBorderStyleRoundedRect];
    searchField.placeholder = @"输入搜索内容";
    searchField.layer.cornerRadius = 5;
    searchField.clearsOnBeginEditing = YES;
    
    [searchView addSubview:searchField];
    searchField.backgroundColor = [UIColor whiteColor];
    searchButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH-60, 0, 50, 40)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.backgroundColor = [UIColor redColor];
    searchButton.layer.cornerRadius = 5;
    [searchView addSubview:searchButton];
    
    
}
- (void)toBack{
    //返回上一页
    [self dismissViewControllerAnimated:NO completion:nil];
}
//数据源方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
@end
