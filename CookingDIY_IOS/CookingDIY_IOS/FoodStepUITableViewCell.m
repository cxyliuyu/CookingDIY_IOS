//
//  FoodStepUITableViewCell.m
//  CookingDIY_IOS
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "FoodStepUITableViewCell.h"
#import "UIImageView+WebCache.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
@interface FoodStepUITableViewCell(){
    UIView *foodStepView;
    UIImageView *foodStepImageView;
    UILabel *foodStepContentLabel;
}
@end
@implementation FoodStepUITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView{
    foodStepView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREENWIDTH-20, 200)];
    foodStepImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-20, 150)];
    foodStepContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, SCREENWIDTH-20, 50)];
    [foodStepView addSubview:foodStepImageView];
    [foodStepView addSubview:foodStepContentLabel];
    [self.contentView addSubview:foodStepView];
    
}


-(void)setFoodImgImageView:(NSString *)foodImg foodContentTextView:(NSString *)foodContent{
    [foodStepImageView sd_setImageWithURL:[NSURL URLWithString:foodImg]];
    foodStepContentLabel.text = foodContent;
}
@end
