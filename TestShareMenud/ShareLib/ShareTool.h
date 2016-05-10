//
//  ShareTool.h
//  HiSports
//
//  Created by zhangweiwei on 16/4/29.
//  Copyright © 2016年 com.ouj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareMacro.h"
#import "ShareInfo.h"

@interface ShareTool : NSObject

+ (instancetype)shareTool;


/** ShareInfo分享内容模型
    SharePlatformType:需要分享的平台
 */
- (void)share:(ShareInfo *)info inPlatform:(SharePlatformType)platform;

@end
