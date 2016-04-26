//
//  ValueUtil.m
//  CookingDIY_IOS
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "ValueUtil.h"
static NSString *loginURL = @"http://114.215.135.70/lypublic/1/index.php/CaiApi/User/login";
static NSString *key = @"E5240C4307AA500300BAA94F9E31CEFD";
@implementation ValueUtil
+ (NSString *)getLoginURL{
    return loginURL;
}
+ (NSString *)getKey{
    return key;
}
@end
