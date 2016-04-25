//
//  NSUserDefaultsUtil.m
//  CookingDIY_IOS
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "NSUserDefaultsUtil.h"

@implementation NSUserDefaultsUtil
+(void)saveBoolean:(NSString *)key :(Boolean)value{
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
+(void)saveNSString:(NSString *)key :(NSString *)value{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:value forKey:key];
}
+(NSString*)getNSString:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *value = (NSString*)[user objectForKey:key];
    return value;
}
@end
