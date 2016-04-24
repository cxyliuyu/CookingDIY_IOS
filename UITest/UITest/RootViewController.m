//
//  RootViewController.m
//  UITest
//
//  Created by admin on 16/4/13.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 300, 500)];
    UIView * vv = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 150, 400)];
    [vv setBackgroundColor:[UIColor redColor]];
    [v setBackgroundColor:[UIColor blueColor]];
    [v addSubview:vv];
    [self.view addSubview:v];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
