//
//  NSUserDefaultsUtil.h
//  CookingDIY_IOS
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultsUtil : NSObject

+(void)saveBoolean:(NSString*) key value:(Boolean) value;
+(Boolean)getBoolean:(NSString*) key;
+(void)saveNSString:(NSString*) key value:(NSString*) value;
+(NSString*)getNSString:(NSString*) key;
+(void)saveInteger:(NSString *)key value:(NSInteger)value;
+(NSInteger)getInteger:(NSString *)key;
@end
