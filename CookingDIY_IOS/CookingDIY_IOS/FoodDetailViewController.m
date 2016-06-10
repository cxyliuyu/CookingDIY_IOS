//
//  FoodDetailViewController.m
//  CookingDIY_IOS
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "UIColor+ZXLazy.h"
#import "AFNetworking.h"
#import "ValueUtil.h"
#import "FoodUITableViewCell.h"
#import "FoodListUITableViewCell.h"
#import "FoodStepUITableViewCell.h"
#import "NSUserDefaultsUtil.h"
#import "ValueUtil.h"
#import "CommentViewController.h"

#define SCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen]bounds].size.height

@interface FoodDetailViewController()<UITableViewDataSource,UITableViewDelegate>{
    UINavigationBar *foodDetailNavBar;
    UITableView *foodDetailTableView;
    NSDictionary *foodDic;
    NSArray *foodListArray;
    NSArray *foodStepsArray;
    NSInteger numberOfFoodList;//材料的种类数
    NSInteger numberOfFoodStep;//做菜步骤数
    NSInteger foodStepCellHeight;
    NSInteger foodCellHeight;
    UIImageView *saveImg;
    BOOL isSaved;
}
@end

@implementation FoodDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [self initView];
    
    [self getFoodById];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView{
    //添加导航栏
    foodDetailNavBar = [UINavigationBar new];
    foodDetailNavBar.frame = CGRectMake(0, 0, SCREENWIDTH, 68);
    foodDetailNavBar.backgroundColor = [UIColor whiteColor];
    foodStepCellHeight = 0;
    foodCellHeight = 0 ;
    isSaved = NO;
    UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:@"菜谱详情"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem new]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    [navigationItem setLeftBarButtonItem:leftButton];
    [foodDetailNavBar pushNavigationItem:navigationItem animated:NO];
    
    //初始化列表视图
    foodDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, SCREENHEIGHT, SCREENHEIGHT-70) style:UITableViewStyleGrouped];
    foodDetailTableView.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.view addSubview:foodDetailNavBar];
    [self.view addSubview:foodDetailTableView];
}

- (void)toBack{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)getFoodById{
    //根据菜谱id获取菜谱详情，并显示在屏幕上
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:[[NSString alloc]initWithFormat:@"%ld",_foodId] forKey:@"id"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[ValueUtil getGetFoodByIdURL] parameters:params constructingBodyWithBlock:^(id _NonnullformData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
    }  progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"%@", dic);
        NSString *code = (NSString *)[dic objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            foodDic = (NSDictionary *)[dic objectForKey:@"food"];
            foodListArray = (NSArray *)[dic objectForKey:@"foodlist"];
            foodStepsArray = (NSArray *)[dic objectForKey:@"foodsteps"];
            numberOfFoodList = [foodListArray count];//配料的个数
            numberOfFoodStep = [foodStepsArray count];//步骤的个数
            foodDetailTableView.dataSource = self;
            foodDetailTableView.delegate = self;
            [foodDetailTableView reloadData];
        }
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"请求失败");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"加载菜谱失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
}

//UItableView的数据源以及代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回节的个数
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"numberOfRowsInSection");
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return  numberOfFoodList;
    }
    if (section == 2) {
        return numberOfFoodStep;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180 + foodCellHeight;
    }
    if (indexPath.section == 1) {
        return 30;
    }
    if (indexPath.section == 2) {
        //NSLog(@"heightForRowAtIndexPath cellHeight = %ld",cellHeight);
        return 170 + foodStepCellHeight;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (indexPath.section == 0) {
        FoodUITableViewCell *cell1 = [[FoodUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        NSString *foodName = (NSString *)[foodDic objectForKey:@"foodname"];
        NSString *foodImg = (NSString *)[foodDic objectForKey:@"foodimg"];
        NSString *foodId =  (NSString *)[foodDic objectForKey:@"id"];
        NSString *content = (NSString *)[foodDic objectForKey:@"content"];
        foodCellHeight = [cell1 setFoodImgImageView:foodImg foodNameLabel:foodName contentLabel:content foodId:[foodId intValue]];
        [self tableView:tableView heightForRowAtIndexPath:indexPath];
        cell1.userInteractionEnabled = NO;//设置不能被点击
        return cell1;
    }
    if (indexPath.section == 1) {
        FoodListUITableViewCell *cell2 = [[FoodListUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        NSString *foodListName = [foodListArray[row] objectForKey:@"foodlistname"];
        NSString *foodListCount = [foodListArray[row] objectForKey:@"foodlistcount"];
        [cell2 setFoodlistName:foodListName foodlistcount:foodListCount];
        [self tableView:tableView heightForRowAtIndexPath:indexPath];
        cell2.userInteractionEnabled = NO;//设置不能被点击
        return cell2;
    }
    if (indexPath.section == 2) {
        FoodStepUITableViewCell *cell3 = [[FoodStepUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        NSString *foodImg = (NSString *)[foodStepsArray[row] objectForKey:@"stepimg"];
        NSString *foodContent = (NSString *)[foodStepsArray[row] objectForKey:@"steptxt"];
        //NSLog(@"foodimg = %@",foodImg);
        foodStepCellHeight = [cell3 setFoodImgImageView:foodImg foodContentTextView:foodContent];
        //NSLog(@"cellHeight = %ld",cellHeight);
        cell3.userInteractionEnabled = NO;//设置不能被点击
        [self tableView:tableView heightForRowAtIndexPath:indexPath];
        return cell3;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //定义分组的头
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    //view.backgroundColor = [UIColor redColor];
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(10, 0, SCREENWIDTH, 30);
    label.font = [UIFont fontWithName:@"Helvetica" size:20];
    label.textColor = [UIColor colorWithHexString:@"#339933"];
    [view addSubview:label];
    if (section == 1) {
        label.text = @"食材清单";
        return view;
    }if(section == 2){
        label.text = @"做法步骤";
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    //设置header的高度
    if (section == 1) {
        return 30;
    }
    if (section == 2) {
        return 30;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
        UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, SCREENWIDTH/2-15, 50)];
        UIButton *commentButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH/2+5, 10, SCREENWIDTH/2-15, 50)];
        saveButton.backgroundColor = [UIColor whiteColor];
        commentButton.backgroundColor = [UIColor whiteColor];
        saveImg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        UIImageView *commentImg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        saveImg.image = [UIImage imageNamed:@"shoucang_n"];
        commentImg.image = [UIImage imageNamed:@"message_n"];
        UILabel *saveLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, SCREENWIDTH/2-15-60, 40)];
        saveLabel.text = @"收藏";
        UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, SCREENWIDTH/2-15-60, 40)];
        commentLabel.text = @"评论";
        [saveButton addSubview:saveLabel];
        [commentButton addSubview:commentLabel];
        [saveButton addSubview:saveImg];
        [commentButton addSubview:commentImg];
        [view addSubview:saveButton];
        [view addSubview:commentButton];
        
        //初始化收藏按钮
        NSMutableDictionary *params = [NSMutableDictionary new];
        [params setValue:[[NSString alloc]initWithFormat:@"%ld",_foodId] forKey:@"foodId"];
        [params setValue:[NSUserDefaultsUtil getNSString:@"userId"] forKey:@"userId"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:[ValueUtil getIsSaved]parameters:params constructingBodyWithBlock: ^(id _NonnullformData) {
            // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        }  progress:^(NSProgress * _Nonnull uploadProgress) {
            // 这里可以获取到目前的数据请求的进度
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //NSLog(@"请求数据成功");
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSString *code = (NSString *)[dic objectForKey:@"code"];
            if ([code isEqualToString:@"200"]) {
                //已被收藏
                saveImg.image = [UIImage imageNamed:@"shoucang_y"];
                isSaved = YES;
            }else{
                //未被收藏
                saveImg.image = [UIImage imageNamed:@"shoucang_n"];
                isSaved = NO;
            }
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 请求失败
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"加载菜谱失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }];
    
        [saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
        [commentButton addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    //返回footer的高度
    if (section == 0) {
        return 70;
    }
    return 0;
}

- (void)saveAction{
    //收藏被点击事件
    NSString *URL;
    if (isSaved == NO) {
        URL = [ValueUtil getAddSave];
    }else{
        URL = [ValueUtil getDeleteSave];
    }
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:[[NSString alloc]initWithFormat:@"%ld",_foodId] forKey:@"foodId"];
    [params setValue:[NSUserDefaultsUtil getNSString:@"userId"] forKey:@"userId"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params constructingBodyWithBlock: ^(id _NonnullformData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
    }  progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"请求数据成功");
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSString *code = (NSString *)[dic objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            //已被收藏
            if (isSaved == NO) {
                isSaved = YES;
                saveImg.image = [UIImage imageNamed:@"shoucang_y"];
            }else{
                isSaved = NO;
                saveImg.image = [UIImage imageNamed:@"shoucang_n"];
            }
        }else{
            //未被收藏
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"请求失败");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"加载菜谱失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
}
- (void)commentAction{
    //评论被点击事件,前往评论页面
    CommentViewController *commentViewController = [[CommentViewController alloc]init];
    commentViewController.foodId = _foodId;
    [self presentViewController:commentViewController animated:YES completion:nil];
   
}

@end
