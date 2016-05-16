//
//  AlarmViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/3/19.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "AlarmViewController.h"
#import "UIColor+ZXLazy.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface AlarmViewController ()

@end

@implementation AlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    super.view.backgroundColor = [UIColor whiteColor];
    if (self) {
        self.navigationItem.title = @"计时";
    }
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView{
    _topView = [UIView new];
    _topView.frame = CGRectMake(0, 65, SCREENWIDTH, (SCREENHEIGHT-65-60)/2);
    _topView.backgroundColor = [UIColor colorWithHexString:@"#6bd403"];
    
    _bottomView = [UIView new];
    _bottomView.frame = CGRectMake(0, (SCREENHEIGHT/2)+1, SCREENWIDTH, (SCREENHEIGHT-65-60)/2);
    //_bottomView.backgroundColor = [UIColor colorWithHexString:@"#ff0000"];
    
    //时间选择器布局
    _choseTimeView = [UIView new];
    _choseTimeView.frame =CGRectMake(0, ((SCREENHEIGHT-65-60)/2)/3-10, SCREENWIDTH, ((SCREENHEIGHT-65-60)/2)/3+10);
    [_topView addSubview:_choseTimeView];
    
    
    [self.view addSubview:_topView];
    [self.view addSubview:_bottomView];
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
