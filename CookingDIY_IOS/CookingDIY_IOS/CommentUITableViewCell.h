//
//  CommentUITableViewCell.h
//  CookingDIY_IOS
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentUITableViewCell : UITableViewCell
@property NSString *foodId;
- (NSInteger)setUserImgView:(NSString *)userImg userNameView:(NSString *)userName ContentView:(NSString *) content timeView:(NSString *)time;
@end
