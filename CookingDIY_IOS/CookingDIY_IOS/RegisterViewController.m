//
//  RegisterViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/6/10.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworking.h"
#import "ValueUtil.h"
#import "UIColor+ZXLazy.h"

#define SCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen]bounds].size.height


@interface RegisterViewController()<UIAlertViewDelegate>{
    
    UINavigationBar *registerNav;
    
    UIView *formView;
    UITextField *userNameTF;
    UITextField *trueNameTF;
    UITextField *password1TF;
    UITextField *password2TF;
    UIButton *registerButton;
    BOOL isRegisterSuccess;//注册结果
}
@end

@implementation RegisterViewController

-(void) viewDidLoad{
    [self initView];
}

-(void) initView{
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    registerNav = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 68)];
    registerNav.backgroundColor = [UIColor whiteColor];
    UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:@"注册"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem new]initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    [navigationItem setLeftBarButtonItem:leftButton];
    [registerNav pushNavigationItem:navigationItem animated:NO];
    
    
    formView = [[UIView alloc]initWithFrame:CGRectMake(10, 90, SCREENWIDTH-20, 170)];
    formView.layer.cornerRadius = 5;
    userNameTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, SCREENWIDTH-40, 30)];
    trueNameTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 50, SCREENWIDTH-40, 30)];
    password1TF = [[UITextField alloc]initWithFrame:CGRectMake(10, 90, SCREENWIDTH-40, 30)];
    password2TF = [[UITextField alloc]initWithFrame:CGRectMake(10, 130, SCREENWIDTH-40, 30)];
    registerButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 270, SCREENWIDTH-20, 35)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.backgroundColor = [UIColor colorWithHexString:@"#1EC75B"];
    registerButton.layer.cornerRadius = 5;
    formView.backgroundColor = [UIColor whiteColor];
    
    [userNameTF setBorderStyle:UITextBorderStyleRoundedRect];
    [trueNameTF setBorderStyle:UITextBorderStyleRoundedRect];
    [password1TF setBorderStyle:UITextBorderStyleRoundedRect];
    [password2TF setBorderStyle:UITextBorderStyleRoundedRect];
    userNameTF.placeholder = @"用户名";
    trueNameTF.placeholder = @"昵称";
    password1TF.placeholder = @"密码";
    password2TF.placeholder = @"确认密码";
    password1TF.secureTextEntry = YES;
    password2TF.secureTextEntry = YES;
    
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:formView];
    [self.view addSubview:registerNav];
    [self.view addSubview:registerButton];
    [formView addSubview:userNameTF];
    [formView addSubview:trueNameTF];
    [formView addSubview:password1TF];
    [formView addSubview:password2TF];
    
    isRegisterSuccess = NO;
}

- (void)toBack{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) registerAction{
    //注册事件
    NSString *userName = userNameTF.text;
    NSString *trueName = trueNameTF.text;
    NSString *password1 = password1TF.text;
    NSString *password2 = password2TF.text;
    
    //NSLog(@"param = %@,%@,%@,%@",userName,trueName,password1,password2);
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:userName forKey:@"username"];
    [params setValue:password1 forKey:@"password1"];
    [params setValue:password2 forKey:@"password2"];
    [params setValue:trueName forKey:@"truename"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //post请求
    [manager POST:[ValueUtil getRegisterUrl] parameters:params constructingBodyWithBlock:^(id  _Nonnull formData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功，解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSString *code = (NSString *)[dic objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            //注册成功
            isRegisterSuccess = YES;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"成功" message:@"注册用户成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
            isRegisterSuccess = NO;
            NSString *message = (NSString *)[dic objectForKey:@"msg"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"失败" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 请求失败
        NSLog(@"请求失败");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"加载菜谱失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //NSLog(@"被点击的buttonIndex = %ld",buttonIndex);
    if(isRegisterSuccess == YES){
        [self toBack];
    }
}
@end
