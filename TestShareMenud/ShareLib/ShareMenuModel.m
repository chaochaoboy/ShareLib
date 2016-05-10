//
//  ShareMenuModel.m
//  ShareViewController
//
//  Created by zc on 16/4/28.
//  Copyright © 2016年 56dian. All rights reserved.
//

#import "ShareMenuModel.h"
#import "ShareViewController.h"
@implementation ShareMenuModel

static NSDictionary *modelDict_ = nil;

+ (void)initialize
{
    modelDict_ = @{
                   
                    @(SharePlatformTypeWechatFriend) : @{@"title":@"微信好友",@"icon":@"resource.bundle/icon_weixin"}
                    ,

                    @(SharePlatformTypeWechatMoment) : @{@"title":@"朋友圈",@"icon":@"resource.bundle/icon_moment"}
                    ,

                    @(SharePlatformTypeSinaWeibo) : @{@"title":@"新浪微博",@"icon":@"resource.bundle/icon_weibo"}
                    ,

                    @(SharePlatformTypeQQFriend) : @{@"title":@"QQ好友",@"icon":@"resource.bundle/icon_qq"}
                    ,

                    @(SharePlatformTypeQQZone) : @{@"title":@"QQ空间",@"icon":@"resource.bundle/icon_qqzone"}

                    };
    
    
}


+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    ShareMenuModel *model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}


+ (NSArray *)menuModelsWithSharePlatforms:(NSArray *)platforms
{
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSNumber *platform in platforms) {
        
        NSDictionary *modelDict = modelDict_[platform];
        
        ShareMenuModel *menuModel = [self modelWithDict:modelDict];
        menuModel.platform = platform.integerValue;
        [arrM addObject:menuModel];
        
    }
    
    
    return arrM;
}

@end
