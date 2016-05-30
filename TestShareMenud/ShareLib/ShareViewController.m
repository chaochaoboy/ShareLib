//
//  ShareViewController.m
//  ShareViewController
//
//  Created by zc on 16/4/28.
//  Copyright © 2016年 56dian. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareMenuView.h"

#import "ShareTool.h"

typedef enum {
    PresentType,//弹出
    DissType//消失
}TransitionType;



@interface PresentModal : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) TransitionType type;

+(instancetype)transitionWithType:(TransitionType)type;

@end

@implementation PresentModal



+(instancetype)transitionWithType:(TransitionType)type
{
    
    PresentModal *transition = [[self alloc]init];
    transition.type = type;
    return transition;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    if (self.type == PresentType ) {
        [self presentAnimation:transitionContext];
    }else{
        [self dismissAnimation:transitionContext];
    }
    
}


- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    UIView *containerView = [transitionContext containerView];
    
    
    [containerView addSubview:toVC.view];
    
    
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    
}

//实现dismiss动画逻辑代码
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    [fromVC.view removeFromSuperview];
    
    
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    
}

@end



/******华丽的分割线*****/


@interface ShareViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic,strong)ShareMenuView *menuView;

@end

@implementation ShareViewController

static NSArray *defaultPlatform_ = nil;

+ (void)initialize
{
    defaultPlatform_ = @[
                         @(SharePlatformTypeWechatFriend),
                         @(SharePlatformTypeWechatMoment),
                         @(SharePlatformTypeQQFriend),
                         @(SharePlatformTypeSinaWeibo),
                         @(SharePlatformTypeQQZone),
                         ];
}

- (ShareMenuView *)menuView{
    if (_menuView == nil) {
        ShareMenuView *menuView = [ShareMenuView shareMenuView];
        
        _menuView = menuView;
        
        __weak typeof(self) weakSelf = self;
        
        [_menuView setDimissBlock:^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [_menuView setDidSelectedMenu:^(ShareMenuModel *menuModel) {
            NSLog(@"modal");
        }];
        
//        _menuView.menus = [ShareMenuModel menuModels];
        
    }
    return _menuView;
}



-(instancetype)init
{
    if (self = [super init]) {
        //自定义modal
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self.menuView dismiss];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.menuView showInView:self.view];
}

#pragma mark-自定义modal动画代理
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //初始化presentType
    return [PresentModal transitionWithType:PresentType];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //初始化dismissType
    return  [PresentModal transitionWithType:DissType];
}


#pragma mark -公共方法


+ (void)setShareDefaultPlatforms:(NSArray *)defaultPlatform
{
    if (!defaultPlatform) return;
    
    defaultPlatform_ = defaultPlatform;
    
}

+ (instancetype)shareInViewController:(UIViewController *)vc platformSelectedHandle:(ShareInfo *(^)(SharePlatformType platform))handle
{
    return [self presentShareVcInViewController:vc withSelectedHandle:^(ShareMenuModel *model) {
        
        if (handle) {
            
            [[ShareTool shareTool] share:handle(model.platform) inPlatform:model.platform];
            
        }
        
    }];
}

+ (instancetype)share:(ShareInfo*)info inViewController:(UIViewController *)vc
{
    return [self presentShareVcInViewController:vc withSelectedHandle:^(ShareMenuModel *model) {
        
        [[ShareTool shareTool] share:info inPlatform:model.platform];
    }];
}

+ (instancetype)presentShareVcInViewController:(UIViewController *)vc withSelectedHandle:(void(^)(ShareMenuModel *model))handle
{
    ShareViewController *shareVc = [ShareViewController new];
    
    shareVc.menuView.menus = [ShareMenuModel menuModelsWithSharePlatforms:defaultPlatform_];
    
    shareVc.menuView.DidSelectedMenu = handle;
    
    if (!vc) {
        vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    
    [vc presentViewController:shareVc animated:NO completion:nil];
    
    return shareVc;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [UIApplication sharedApplication].statusBarStyle;
}


@end


