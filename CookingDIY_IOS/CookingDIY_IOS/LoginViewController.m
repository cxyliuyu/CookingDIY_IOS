//
//  LoginViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+ZXLazy.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface LoginViewController()

@property UINavigationBar *loginNavBar;
@property UIButton *login;
@property UIButton *toRegister;
@property UITextField *userNameTF;
@property UITextField *passwordTF;

@end


@implementation LoginViewController

- (void) viewDidLoad{
    [self initView];
}

- (void) initView{
    //NSLog(@"initView被调用了");
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    //绘制导航栏
    _loginNavBar = [UINavigationBar new];
    _loginNavBar.frame = CGRectMake(0, 0, SCREENWIDTH, 68);
    _loginNavBar.backgroundColor = [UIColor whiteColor];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"登录"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem new] initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    [navigationItem setLeftBarButtonItem:leftButton];
    [_loginNavBar pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:_loginNavBar];
    
    
    //绘制登陆页面
    UIImageView *appImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH/3, 120, SCREENWIDTH/3, SCREENWIDTH/3)];
    appImage.image = [UIImage imageNamed:@"zuofanme.png"];
    [self.view addSubview:appImage];
    
    //绘制输入框
    _userNameTF = [UITextField new];
    _userNameTF.frame = CGRectMake(20, SCREENWIDTH/3 + 140, SCREENWIDTH - 40, 40);
    _userNameTF.placeholder = @"请输入用户名";
    _userNameTF.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTF.layer.cornerRadius = 5;
    _userNameTF.clearsOnBeginEditing = YES;
    [self.view addSubview:_userNameTF];

    _passwordTF = [UITextField new];
    _passwordTF.frame = CGRectMake(20, SCREENWIDTH/3 + 190, SCREENWIDTH - 40, 40);
    _passwordTF.placeholder = @"请输入密码";
    _passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTF.layer.cornerRadius = 5;
    _passwordTF.clearsOnBeginEditing = YES;
    [self.view addSubview:_passwordTF];
    
    //绘制登录和注册按钮
    _login = [UIButton new];
    _login.frame = CGRectMake(20, SCREENWIDTH/3 +250, SCREENWIDTH-40, 40);
    [_login setTitle:@"登录" forState:UIControlStateNormal];
    _login.backgroundColor = [UIColor greenColor];
    _login.layer.cornerRadius = 10;
    [self.view addSubview:_login];
    
    _toRegister = [UIButton new];
    _toRegister.frame = CGRectMake(20, SCREENWIDTH/3 +300, SCREENWIDTH-40, 40);
    [_toRegister setTitle:@"注册" forState:UIControlStateNormal];
    _toRegister.backgroundColor = [UIColor redColor];
    _toRegister.layer.cornerRadius = 10;
    [self.view addSubview:_toRegister];
    
    [_login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void) toBack{
    //返回的点击事件
    //NSLog(@"返回按钮被点击了");
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) login{
    NSString *userName = _userNameTF.text;
    NSString *password = _passwordTF.text;
    if(userName != nil&&userName.length!=0&&password!=nil&&password.length!=0){
        //发送用户名密码
        //NSLog(@"用户名 ＝ %@ \n 密码 ＝ %@",userName,password);
        
    }else{
        //用户名密码为空，弹出提示信息
    }
    
}
@end
