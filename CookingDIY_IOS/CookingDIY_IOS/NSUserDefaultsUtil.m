//
//  NSUserDefaultsUtil.m
//  CookingDIY_IOS
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "NSUserDefaultsUtil.h"

@implementation NSUserDefaultsUtil
+(void)saveBoolean:(NSString *)key value:(Boolean)value{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:value forKey:key];
}
+(Boolean)getBoolean:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    Boolean value = [user boolForKey:key];
    if ([user boolForKey:key]==nil) {
        return false;
    }else{
        return value;
    }
}
+(void)saveNSString:(NSString *)key value:(NSString *)value{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:value forKey:key];
}
+(NSString*)getNSString:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *value = (NSString*)[user objectForKey:key];
    return value;
}

+(void)saveInteger:(NSString *)key value:(NSInteger)value{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setInteger:value forKey:key];
}

+(NSInteger)getInteger:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger value = (NSInteger)[user integerForKey:key];
    return value;
}
@end
