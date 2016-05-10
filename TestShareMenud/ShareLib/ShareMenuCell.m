//
//  ShareMenuCell.m
//  ShareViewController
//
//  Created by zc on 16/4/28.
//  Copyright © 2016年 56dian. All rights reserved.
//

#import "ShareMenuCell.h"
@interface ShareMenuCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ShareMenuCell


- (void)setMenuModel:(ShareMenuModel *)menuModel
{
    _menuModel = menuModel;
    self.iconView.image = [UIImage imageNamed:menuModel.icon];
    self.titleLabel.text = menuModel.title;
}

@end
