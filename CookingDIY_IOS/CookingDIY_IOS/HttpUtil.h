//
//  HttpUtil.h
//  CookingDIY_IOS
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface HttpUtil : NSObject

+ (BOOL)NetWorkIsOK;//检查网络是否可用
+ (void)post:(NSString *)Url RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;//post请求封装

@end