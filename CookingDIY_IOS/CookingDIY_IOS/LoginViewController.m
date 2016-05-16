//
//  LoginViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+ZXLazy.h"
#import "MD5Util.h"
#import "ValueUtil.h"
#import "HttpUtil.h"
#import "NSUserDefaultsUtil.h"


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
    _passwordTF.secureTextEntry = YES;
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
    
    [_login addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void) toBack{
    //返回的点击事件
    //NSLog(@"返回按钮被点击了");
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) loginAction{
    NSString *userName = _userNameTF.text;
    NSString *password = _passwordTF.text;
    NSString *value = [NSString new];
    value = [[NSString alloc]initWithFormat:@"%@%@%@",userName,password,[ValueUtil getKey]];
    //NSLog(@"value = %@",value);
    NSString *md5Value = [MD5Util md5:value];
    //NSLog(@"md5Value = %@",md5Value);
    if(userName != nil&&userName.length!=0&&password!=nil&&password.length!=0){
        //NSLog(@"用户名 ＝ %@ \n 密码 ＝ %@",userName,password);
        //异步POST方法发送请求
        NSURL *loginURL = [NSURL URLWithString:[ValueUtil getLoginURL]];
        //NSString
        NSMutableDictionary *params = [NSMutableDictionary new];
        [params setValue:userName forKey:@"username"];
        [params setValue:password forKey:@"password"];
        [params setValue:md5Value forKey:@"value"];
        
        if([HttpUtil NetWorkIsOK]){
            //发送请求，并且得到返回的数据
            [HttpUtil post:[ValueUtil getLoginURL] RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                //传回来的数据存在，则执行该回调函数
                if(data){
                    //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                    //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
                    [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
                }else{
                    NSLog(@"无效的数据");
                }
            }];
        }
    }else{
        //用户名密码为空，弹出提示信息
    }
    
}
- (void)login_callBack:(id)value{
    NSLog(@"登录成功");
    NSData *data = (NSData *)value;
    //NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSString *code = (NSString *)[resultDictionary objectForKey:@"code"];
    //NSLog(code);
    if ([code isEqualToString:@"200"]) {
        //访问成功
        NSDictionary *userDic = [resultDictionary objectForKey:@"data"];
        //NSLog(@"%@",userDic);
        NSString *userId = [userDic objectForKey:@"id"];
        NSString *userTrueName = [userDic objectForKey:@"truename"];
        NSString *userImg = [userDic objectForKey:@"userimg"];
        NSString *userName = [userDic objectForKey:@"username"];
        
        //设置已经登录，并且保存用户数据
        [NSUserDefaultsUtil saveBoolean:@"ISLOGIN" value:YES];
        [NSUserDefaultsUtil saveNSString:@"userId" value:userId];
        [NSUserDefaultsUtil saveNSString:@"userTrueName" value:userTrueName];
        [NSUserDefaultsUtil saveNSString:@"userImg" value:userImg];
        [NSUserDefaultsUtil saveNSString:@"userName" value:userName];
        [self toBack];
    }
    
//
}
@end
