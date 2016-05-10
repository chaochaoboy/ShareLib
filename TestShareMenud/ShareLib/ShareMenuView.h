//
//  ShareMenuView.h
//  ShareViewController
//
//  Created by zc on 16/4/28.
//  Copyright © 2016年 56dian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareMenuModel.h"
#import "ShareMacro.h"

@interface ShareMenuView : UIView

@property (nonatomic,strong) NSArray <ShareMenuModel *> * menus;

@property (nonatomic,copy) void (^(DimissBlock))();

@property (nonatomic,copy) void (^(DidSelectedMenu))(ShareMenuModel *model);

+(instancetype)shareMenuView;

- (void)showInView:(UIView *)view;

- (void)dismiss;

/** 每行得最大列数 */
@property (nonatomic,assign) NSInteger colums;

@end


