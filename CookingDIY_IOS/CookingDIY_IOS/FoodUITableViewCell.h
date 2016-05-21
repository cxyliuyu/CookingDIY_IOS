//
//  FoodUITableViewCell.h
//  CookingDIY_IOS
//
//  Created by admin on 16/5/7.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FoodUITableViewCell : UITableViewCell

@property (nonatomic,strong) NSString *foodName;
@property (nonatomic,strong) NSString *foodImg;
@property (nonatomic,strong) NSString *foodId;
@property (nonatomic,strong) NSString *content;
-(void)setFoodImgImageView:(NSString *)foodImg foodNameLabel:(NSString *)foodName contentLabel:(NSString *)content foodId:(NSInteger )foodid;
@end
