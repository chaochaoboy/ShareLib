//
//  ShareMenuView.m
//  ShareViewController
//
//  Created by zc on 16/4/28.
//  Copyright © 2016年 56dian. All rights reserved.
//

#import "ShareMenuView.h"
#import "ShareMenuCell.h"
@interface ShareMenuView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

static NSString * const menuCellReuseId = @"ShareMenuCell";

static CGFloat const AnimationDuration = 0.25;

static CGFloat const MenuCellHeight = 100;
static CGFloat const MenuCellWidth = 80;

static CGFloat const ToolBarHeight = 44;

@implementation ShareMenuView

+(instancetype)shareMenuView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
-(void)awakeFromNib
{
    NSInteger defaultMaxColums = [UIScreen mainScreen].bounds.size.width / MenuCellWidth;
    self.colums = defaultMaxColums;

    [self setupCollectionView];
    
    [self.closeButton setImage:[UIImage imageNamed:@"resource.bundle/icon_close"] forState:UIControlStateNormal];
}

#pragma mark-初始化collecitonView
-(void)setupCollectionView
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ShareMenuCell class]) bundle:nil] forCellWithReuseIdentifier:menuCellReuseId];
    
}

- (void)setColums:(NSInteger)colums
{
    _colums = colums;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.itemSize = CGSizeMake(MenuCellWidth, MenuCellHeight);
    
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - self.colums*MenuCellWidth)/(self.colums+1);
    
    layout.minimumInteritemSpacing = margin;
    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    
    [self.collectionView reloadData];

}

#pragma mark-弹出菜单
-(void)showInView:(UIView *)view
{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [view addSubview:self];
    CGFloat w = view.frame.size.width;
    
    CGFloat h = (self.colums + self.menus.count - 1) / self.colums * MenuCellHeight+ToolBarHeight;
    CGFloat maxHeight = view.frame.size.height * 0.5;
    if (h > maxHeight) {
        h = maxHeight;
    }
    
    CGFloat x = 0;
    CGFloat y = view.frame.size.height;
    
    self.frame = CGRectMake(x, y, w, h);
    
    [UIView animateWithDuration:AnimationDuration animations:^{
        CGRect rect = self.frame;
        rect.origin.y = view.frame.size.height -rect.size.height;
        self.frame = rect;
    }];
}

#pragma mark-销毁菜单
-(void)dismiss
{
    [UIView animateWithDuration:AnimationDuration animations:^{
        CGRect rect = self.frame;
        rect.origin.y = self.superview.frame.size.height ;
        self.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        !_DimissBlock?:_DimissBlock();
    }];
}

#pragma mark-取消分享
- (IBAction)cancleShareClick:(id)sender {
    
    [self dismiss];
}

#pragma mark-collectionView数据源实现
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.menus.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:menuCellReuseId forIndexPath:indexPath];
    cell.menuModel = self.menus[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    !_DidSelectedMenu?:_DidSelectedMenu(self.menus[indexPath.item]);
}

@end
