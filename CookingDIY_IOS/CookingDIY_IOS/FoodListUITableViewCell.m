//
//  FoodListUITableViewCell.m
//  CookingDIY_IOS
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "FoodListUITableViewCell.h"
#import "UIColor+ZXLazy.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface FoodListUITableViewCell (){
    UIView *foodListView;
    UILabel *foodListNameLabel;
    UILabel *foodListCountLabel;
}

@end

@implementation FoodListUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    foodListView = [[UIView alloc]initWithFrame:CGRectMake(10, 1, SCREENWIDTH-20, 30)];
    foodListNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ((SCREENWIDTH-20)/3)*2, 30)];
    foodListCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(((SCREENWIDTH-20)/3)*2, 0, ((SCREENWIDTH-20)/3), 30)];
    foodListCountLabel.textColor = [UIColor colorWithHexString:@"#A9A9A9"];
    [foodListView addSubview:foodListNameLabel];
    [foodListView addSubview:foodListCountLabel];
    foodListView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:foodListView];
}
-(void)setFoodlistName:(NSString *)foodListName foodlistcount:(NSString *)foodListCount{
    foodListNameLabel.text = foodListName;
    foodListCountLabel.text = foodListCount;
   
}


@end
