//
//  ShareMacro.h
//  ShareViewController
//
//  Created by zhangweiwei on 16/4/29.
//  Copyright © 2016年 56dian. All rights reserved.
//

#ifndef ShareMacro_h
#define ShareMacro_h
typedef NS_ENUM(NSInteger, SharePlatformType) {
    SharePlatformTypeWechatFriend,
    SharePlatformTypeWechatMoment,
    SharePlatformTypeSinaWeibo,
    SharePlatformTypeQQFriend,
    SharePlatformTypeQQZone
};

typedef NS_ENUM(NSInteger, ShareDataType) {
    ShareDataTypeLink,
    ShareDataTypeImage
};

#endif /* ShareMacro_h */
