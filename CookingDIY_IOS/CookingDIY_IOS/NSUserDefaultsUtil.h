//
//  NSUserDefaultsUtil.h
//  CookingDIY_IOS
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultsUtil : NSObject

+(void)saveBoolean:(NSString*) key:(Boolean) value;
+(Boolean)getBoolean:(NSString*) key;
+(void)saveNSString:(NSString*) key:(NSString*) value;
+(NSString*)getNSString:(NSString*) key;

@end
