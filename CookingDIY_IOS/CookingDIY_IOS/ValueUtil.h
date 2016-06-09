//
//  ValueUtil.h
//  CookingDIY_IOS
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValueUtil : NSObject
+ (NSString *)getLoginURL;
+ (NSString *)getKey;
+ (NSString *)getFoodsURL;
+ (NSString *)getGetFoodByIdURL;
+ (NSString *)getIsSaved;
+ (NSString *)getAddSave;
+ (NSString *)getDeleteSave;
@end
