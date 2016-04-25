//
//  PersonalViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/3/19.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "PersonalViewController.h"
#import "UIColor+ZXLazy.h"
#import "NSUserDefaultsUtil.h"
#import "LoginViewController.h"
//手机屏幕宽度与高度
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
@interface PersonalViewController ()
@property UIButton *userBtn;
@property UIImageView *userImg;
@property UILabel *userName;
@property UILabel *userInfo;
@property UIImageView *userRightImg;
@property UIButton *mysaveBtn;
@property UIButton *uploadBtn;
@property UIButton *myfood;
@property UIButton *quit;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //super.view.backgroundColor = [UIColor greenColor];
    if (self) {
        self.navigationItem.title = @"个人中心";
    }

    //NSLog(@"SCREENWIDTH = %g,SCREENHEIGHT = %g",SCREENWIDTH,SCREENHEIGHT);
    [self initView];
    [self refreshView];

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView{
    //初始化页面
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    //个人信息拦
    _userBtn = [UIButton new];
    _userBtn.frame = CGRectMake(0, 61, SCREENWIDTH, 90);
    _userBtn.backgroundColor = [UIColor whiteColor];
    
    _userImg = [UIImageView new];
    _userImg.frame = CGRectMake(10, 10, 70, 70);
    _userImg.layer.cornerRadius = 35;
    _userImg.layer.borderWidth = 2;
    _userImg.layer.borderColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
    [_userImg setImage:[UIImage imageNamed:@"userdefaultimg.png"]];
    
    _userName = [UILabel new];
    _userName.frame = CGRectMake(90, 10, 200, 25);
    //_userName.backgroundColor = [UIColor redColor];
    _userName.text = @"请点击登录";
    
    _userInfo = [UILabel new];
    _userInfo.frame = CGRectMake(90, 40, SCREENWIDTH-90-30, 20);
    _userInfo.text = @"自己动手丰衣足食，让我们爱上做饭";
    _userInfo.font = [UIFont fontWithName:@"Helvetica" size:14];
    
    _userRightImg = [UIImageView new];
    _userRightImg.frame = CGRectMake(SCREENWIDTH - 20, 25, 20, 40);
    [_userRightImg setImage:[UIImage imageNamed:@"right_jiantou.png"]];
    
    [_userBtn addSubview:_userImg];
    [_userBtn addSubview:_userName];
    [_userBtn addSubview:_userInfo];
    [_userBtn addSubview:_userRightImg];
    
    
    //绘制我的收藏按钮
    _mysaveBtn = [UIButton new];
    _mysaveBtn.frame = CGRectMake(0, 154, SCREENWIDTH/2 -2, 60);
    _mysaveBtn.backgroundColor = [UIColor whiteColor];
    UIImageView *mysaveBtnImg = [UIImageView new];
    UILabel *mysaveBtnLabel = [UILabel new];
    mysaveBtnImg.frame = CGRectMake(12, 12, 36, 36);
    mysaveBtnImg.image = [UIImage imageNamed:@"shoucang.png"];
    mysaveBtnLabel.frame = CGRectMake(60, 12, (SCREENWIDTH/2)-67, 36);
    mysaveBtnLabel.text = @"我的收藏";
    [_mysaveBtn addSubview:mysaveBtnImg];
    [_mysaveBtn addSubview:mysaveBtnLabel];

    //绘制上传菜谱按钮
    _uploadBtn = [UIButton new];
    _uploadBtn.frame = CGRectMake(SCREENWIDTH/2+2, 154, SCREENWIDTH/2 -2, 60);
    _uploadBtn.backgroundColor = [UIColor whiteColor];
    UIImageView *uploadBtnImg = [UIImageView new];
    UILabel *uploadBtnLabel = [UILabel new];
    uploadBtnImg.frame = CGRectMake(12, 12, 36, 36);
    uploadBtnImg.image = [UIImage imageNamed:@"carema.png"];
    uploadBtnLabel.frame = CGRectMake(60, 12, (SCREENWIDTH/2)-67, 36);
    uploadBtnLabel.text = @"上传菜谱";
    [_uploadBtn addSubview:uploadBtnImg];
    [_uploadBtn addSubview:uploadBtnLabel];
    
    //绘制我的菜谱按钮
    _myfood = [UIButton new];
    _myfood.frame = CGRectMake(0, 217, SCREENWIDTH, 60);
    _myfood.backgroundColor = [UIColor whiteColor];
    UIImageView *myfoodImg = [UIImageView new];
    myfoodImg.frame = CGRectMake(12, 12, 36, 36);
    myfoodImg.image = [UIImage imageNamed:@"food.png"];
    UILabel *myfoodLabel = [UILabel new];
    myfoodLabel.frame = CGRectMake(60, 12, 150, 36);
    myfoodLabel.text = @"我的菜谱";
    UIImageView *myfoodRightImg = [UIImageView new];
    myfoodRightImg.frame = CGRectMake(SCREENWIDTH - 20, 15, 20, 30);
    myfoodRightImg.image = [UIImage imageNamed:@"right_jiantou.png"];
    [_myfood addSubview:myfoodImg];
    [_myfood addSubview:myfoodLabel];
    [_myfood addSubview:myfoodRightImg];
    
    
    //绘制退出登录按钮
    _quit = [UIButton new];
    _quit.frame = CGRectMake(10, SCREENHEIGHT - 110, SCREENWIDTH-20, 45);
    _quit.backgroundColor = [UIColor redColor];
    [_quit setTitle:@"退出登陆" forState:UIControlStateNormal];
    _quit.layer.cornerRadius = 10;

    
    [self.view addSubview:_userBtn];
    [self.view addSubview:_mysaveBtn];
    [self.view addSubview:_uploadBtn];
    [self.view addSubview:_myfood];
    [self.view addSubview:_quit];
    
}
- (void)refreshView{
    //刷新页面
    
    //判断用户是否已经登录
    if ([NSUserDefaultsUtil getBoolean:@"ISLOGIN"]) {
        NSLog(@"用户还未登录");
        
    }else{
        NSLog(@"用户还未登录");
        _quit.hidden = YES;
        [_userBtn addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    //[NSUserDefaultsUtil getBoolean:@"xu"];
    //if([NSUserDefaultsUtil getBoolean:"ISLOGIN"]==false)
//    [NSUserDefaultsUtil saveNSString:@"test" :@"123"];
//    [NSUserDefaultsUtil saveNSString:@"test" :@"456"];
//    NSLog([NSUserDefaultsUtil getNSString:@"test"]);
    
}

-(void)toLogin{
    //前往登录页面
    //NSLog(@"前往登录页面");
    LoginViewController * login = [LoginViewController new];
    [self presentViewController:login animated:YES completion:nil];
    
}

@end
