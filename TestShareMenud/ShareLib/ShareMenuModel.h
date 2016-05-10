//
//  ShareMenuModel.h
//  ShareViewController
//
//  Created by zc on 16/4/28.
//  Copyright © 2016年 56dian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareMacro.h"

@interface ShareMenuModel : NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic, assign) SharePlatformType platform;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

+ (NSArray *)menuModelsWithSharePlatforms:(NSArray *)platforms;

@end
