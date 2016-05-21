//
//  FoodListUITableViewCell.h
//  CookingDIY_IOS
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodListUITableViewCell : UITableViewCell

@property (nonatomic,strong) NSString *foodListName;
@property (nonatomic,strong) NSString *foodListCount;
-(void)setFoodlistName:(NSString *)foodListName foodlistcount:(NSString *)foodListCount;
@end
