//
//  FoodStepUITableViewCell.m
//  CookingDIY_IOS
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "FoodStepUITableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIColor+ZXLazy.h"

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
    return self;
}


-(NSInteger)setFoodImgImageView:(NSString *)foodImg foodContentTextView:(NSString *)foodContent{
    
    foodStepImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-20, 150)];
    foodStepView = [UIView new];
    foodStepContentLabel = [UILabel new];
    foodStepContentLabel.textColor = [UIColor colorWithHexString:@"#339933"];
    foodStepContentLabel.lineBreakMode = UILineBreakModeWordWrap;
    foodStepContentLabel.numberOfLines = 0;
    [foodStepImageView sd_setImageWithURL:[NSURL URLWithString:foodImg]];
    foodStepContentLabel.text = foodContent;
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];
    foodStepContentLabel.font = font;
    CGSize size = CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX);
    CGSize labelSize = [foodContent sizeWithFont:font constrainedToSize:size lineBreakMode:foodStepContentLabel.lineBreakMode];
    foodStepContentLabel.frame = CGRectMake(0, 150, labelSize.width, labelSize.height);
    foodStepView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREENWIDTH-20, 165+labelSize.height)];
    [foodStepView addSubview:foodStepImageView];
    [foodStepView addSubview:foodStepContentLabel];
    [self.contentView addSubview:foodStepView];
    return labelSize.height;
}
@end
