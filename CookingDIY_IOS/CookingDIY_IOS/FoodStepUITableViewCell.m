//
//  FoodStepUITableViewCell.m
//  CookingDIY_IOS
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "FoodStepUITableViewCell.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
@interface FoodStepUITableViewCell(){
    UIView *foodStepView;
    UIImageView *foodStepImageView;
    UITextView *foodStepContentTextView;
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
    foodStepImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, SCREENWIDTH-20, 150)];
    foodStepContentTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 150, SCREENWIDTH-20, 50)];
    
}

-(void)setFoodImgImageView:(NSString *)foodImg foodContentTextView:(NSString *)foodContent{
    
}
@end
