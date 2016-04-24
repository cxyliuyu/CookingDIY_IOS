//
//  PersonalViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/3/19.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "PersonalViewController.h"
#import "UIColor+ZXLazy.h"
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
    
    //各种功能
    _mysaveBtn = [UIButton new];
    _mysaveBtn.frame = CGRectMake(5, 154, SCREENWIDTH/2 -7, 60);
    _mysaveBtn.backgroundColor = [UIColor whiteColor];
    
    _uploadBtn = [UIButton new];
    _uploadBtn.frame = CGRectMake(SCREENWIDTH/2 + 3, 155, SCREENWIDTH/2 -8, 60);
    _uploadBtn.backgroundColor = [UIColor whiteColor];
    
    _myfood = [UIButton new];
    _myfood.frame = CGRectMake(0, 220, SCREENWIDTH, 60);
    _myfood.backgroundColor = [UIColor whiteColor];
    
    _quit = [UIButton new];
    

    
    [self.view addSubview:_userBtn];
    [self.view addSubview:_mysaveBtn];
    [self.view addSubview:_uploadBtn];
    [self.view addSubview:_myfood];
    
}
- (void)refreshView{
    //刷新页面
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
