//
//  CommentViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/6/9.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "CommentViewController.h"
#import "UIColor+ZXLazy.h"

#define SCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen]bounds].size.height

@interface CommentViewController(){
    UINavigationBar *commentNavBar;
    
}

@end
@implementation CommentViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [self initView];
}

- (void)initView{
    commentNavBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREENHEIGHT, 68)];
    commentNavBar.backgroundColor = [UIColor whiteColor];
    UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:@"评论"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    [navigationItem setLeftBarButtonItem:leftButton];
    [commentNavBar pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:commentNavBar];
    //NSLog(@"foodId = %ld",_foodId);
    
}
- (void)toBack{
    //返回上一页
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
