//
//  FoodStepUITableViewCell.h
//  CookingDIY_IOS
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodStepUITableViewCell : UITableViewCell
@property (nonatomic,strong) NSString *foodImg;
@property (nonatomic,strong) NSString *foodContent;

-(NSInteger)setFoodImgImageView:(NSString *)foodImg foodContentTextView:(NSString *)foodContent;

@end
