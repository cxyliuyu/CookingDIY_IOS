//
//  AppDelegate.m
//  CookingDIY_IOS
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "AlarmViewController.h"
#import "PersonalViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UINavigationBar appearance]setBarTintColor:[UIColor whiteColor]];
    RootViewController * rootVC = [[RootViewController alloc]init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor =[UIColor whiteColor];
    //标签栏控制器
    UITabBarController *tab =  [[UITabBarController alloc] init];
    //创建基本视图
    HomeViewController * home = [[HomeViewController alloc]init];
    MessageViewController * message = [[MessageViewController alloc]init];
    AlarmViewController * alarm = [[AlarmViewController alloc]init];
    PersonalViewController  * personal = [[PersonalViewController alloc]init];
    
    //创建导航视图
    UINavigationController * homeNAV = [[UINavigationController alloc]initWithRootViewController:home];
    homeNAV.tabBarItem.title = @"首页";
    homeNAV.tabBarItem.image = [UIImage imageNamed:@"tabbar_home.png"];
    UINavigationController * alarmNAV = [[UINavigationController alloc]initWithRootViewController:alarm];
    alarmNAV.tabBarItem.title = @"计时";
    alarmNAV.tabBarItem.image = [UIImage imageNamed:@"tabbar_alarm.png"];
    UINavigationController * messageNAV = [[UINavigationController alloc]initWithRootViewController:message];
    messageNAV.tabBarItem.title = @"消息";
    messageNAV.tabBarItem.image = [UIImage imageNamed:@"tabbar_message.png"];
    UINavigationController * personalNAV = [[UINavigationController alloc]initWithRootViewController:personal];
    personalNAV.tabBarItem.title = @"个人";
    personalNAV.tabBarItem.image = [UIImage imageNamed:@"tabbar_personal.png"];
    
    tab.viewControllers = [[NSArray alloc]initWithObjects:homeNAV,alarmNAV,messageNAV,personalNAV, nil];
    tab.tabBar.tintColor = [UIColor colorWithRed:50/255.0 green:205/255.0 blue:50/255.0 alpha:1];
    //设置标签栏视图为根视图
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
