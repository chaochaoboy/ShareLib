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


+ (instancetype)share:(ShareInfo *)info inViewController:(UIViewController *)vc;

@end
