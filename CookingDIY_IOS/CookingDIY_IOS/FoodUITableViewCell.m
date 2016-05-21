//
//  FoodUITableViewCell.m
//  CookingDIY_IOS
//
//  Created by admin on 16/5/7.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "FoodUITableViewCell.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface FoodUITableViewCell(){
    UIButton *cellButton;
    UIImageView *foodImageView;
    UILabel *foodNameLabel;
    UILabel *contentLabel;
    
}
@end
@implementation FoodUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    //初始化视图
    NSLog(@"initView被调用了");
    
    cellButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, SCREENWIDTH-10, 200)];
    foodImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-10, 150)];
    foodNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, SCREENWIDTH-10, 20)];
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 170, SCREENWIDTH-10, 14)];
    [cellButton addSubview:foodImageView];
    [cellButton addSubview:foodNameLabel];
    [cellButton addSubview:contentLabel];
    [self.contentView addSubview:cellButton];
}

-(void)setFoodImgImageView:(NSString *)foodImg foodNameLabel:(NSString *)foodName contentLabel:(NSString *)content{
    NSLog(@"setFoodImgImageView被调用了");
    NSLog(@"1%@2%@3%@",foodImg,foodName,content);
    foodNameLabel.text = foodName;
    contentLabel.text = content;
}

@end
