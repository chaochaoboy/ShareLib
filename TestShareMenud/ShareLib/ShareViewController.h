//
//  ShareViewController.h
//  ShareViewController
//
//  Created by zc on 16/4/28.
//  Copyright © 2016年 56dian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareMacro.h"
#import "ShareInfo.h"


@interface ShareViewController : UIViewController

+ (void)setShareDefaultPlatforms:(NSArray *)defaultPlatform;

// 针对全部分享平台统一处理
+ (instancetype)share:(ShareInfo *)info inViewController:(UIViewController *)vc;
// 针对单个分享平台处理
+ (instancetype)shareInViewController:(UIViewController *)vc platformSelectedHandle:(ShareInfo *(^)(SharePlatformType platform))handle;

@end
