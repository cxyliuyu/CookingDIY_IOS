//
//  ValueUtil.m
//  CookingDIY_IOS
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 cxyliuyu. All rights reserved.
//

#import "ValueUtil.h"
//登录接口
static NSString *loginURL = @"http://114.215.135.70/lypublic/1/index.php/CaiApi/User/login";
static NSString *key = @"E5240C4307AA500300BAA94F9E31CEFD";
//根据page获取菜谱列表接口
static NSString *foodsURL = @"http://114.215.135.70/lypublic/1/index.php/CaiApi/Food/getFoodsByPage";
static NSString *getFoodByIdURL = @"http://114.215.135.70/lypublic/1/index.php/CaiApi/Food/getFoodById";
static NSString *isSaved = @"http://114.215.135.70/lypublic/1/index.php/CaiApi/Save/isSaved";
static NSString *addSave = @"http://114.215.135.70/lypublic/1/index.php/CaiApi/Save/addSave";
static NSString *deleteSave = @"http://114.215.135.70/lypublic/1/index.php/CaiApi/Save/deleteSave";

@implementation ValueUtil

+ (NSString *)getLoginURL{
    return loginURL;
}

+ (NSString *)getKey{
    return key;
}

+ (NSString *)getFoodsURL{
    return foodsURL;
}

+ (NSString *)getGetFoodByIdURL{
    return getFoodByIdURL;
}

+ (NSString *)getIsSaved{
    return isSaved;
}

+ (NSString *)getAddSave{
    return addSave;
}

+ (NSString *)getDeleteSave{
    return deleteSave;
}

@end
