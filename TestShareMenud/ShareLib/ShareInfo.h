//
//  ShareInfo.h
//  HiSports
//
//  Created by zhangweiwei on 16/4/29.
//  Copyright © 2016年 com.ouj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareInfo : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) UIImage *thumbialImage;


@end

@interface ShareLinkInfo : ShareInfo

@property (nonatomic, copy) NSString *link;


@end

@interface ShareImageInfo : ShareInfo

@property (nonatomic, strong) UIImage *image;


@end
