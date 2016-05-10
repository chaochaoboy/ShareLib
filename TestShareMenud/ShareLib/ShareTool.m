//
//  ShareTool.m
//  HiSports
//
//  Created by zhangweiwei on 16/4/29.
//  Copyright © 2016年 com.ouj. All rights reserved.
//

#import "ShareTool.h"

//#import <WXApi.h>
//#import <WeiboSDK.h>
#import "TencentOpenAPI/QQApiInterface.h"

@interface ShareTool ()

@end

@implementation ShareTool

static id instance_;
+ (instancetype)shareTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] init];
    });
    return instance_;
}


#pragma mark - 微信分享方法

- (void)wechatShare:(ShareInfo *)info inPlatform:(SharePlatformType)platform
{
    
//    WXMediaMessage *message = [WXMediaMessage message];
//    
//    if ([info isKindOfClass:[ShareLinkInfo class]]) {
//        ShareLinkInfo *linkInfo = (ShareLinkInfo *)info;
//        WXWebpageObject *webpageObject = [WXWebpageObject object];
//        webpageObject.webpageUrl = linkInfo.link;
//        message.mediaObject = webpageObject;
//        
//        
//        [message setThumbImage:[self drawImage:linkInfo.thumbialImage withWidth:120]];//图片大小不能超过32k
//    }else if ([info isKindOfClass:[ShareImageInfo class]]) {
//        
//        ShareImageInfo *imageInfo = (ShareImageInfo *)info;
//        
//        WXImageObject *imageObj = [WXImageObject object];
//        imageObj.imageData = UIImagePNGRepresentation(imageInfo.image);
//        message.mediaObject = imageObj;
//        
//        UIImage *thumbImage = imageInfo.thumbialImage ? imageInfo.thumbialImage : imageInfo.image;
//        [message setThumbImage:[self drawImage:thumbImage withWidth:120]];//图片大小不能超过32k
//        
//    }
//    
//    NSString *title = info.title;
//    if (title.length > 100) {
//        title = [title substringToIndex:100];
//    }
//    NSString *description = info.desc;
//    if (description.length > 200) {
//        description = [description substringToIndex:200];
//    }
//    
//    message.title = title;
//    message.description = description;
//    
//    
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
//    
//    switch (platform) {
//        case SharePlatformTypeWechatFriend:
//            
//            req.scene = WXSceneSession;
//            break;
//        case SharePlatformTypeWechatMoment:
//            
//            req.scene = WXSceneTimeline;
//            break;
//            
//        default:
//            break;
//    }
//    
//    [WXApi sendReq:req];

    
}

#pragma mark - 微博分享方法

- (void)weiboShare:(ShareInfo *)info
{
//    WBMessageObject *message = [WBMessageObject message];
//    
//    NSString *title = info.title;
//    if (title.length > 80) {
//        title = [NSMutableString stringWithString:[title substringToIndex:80]];
//    }
//    
//    if ([info isKindOfClass:[ShareLinkInfo class]]) {
//        ShareLinkInfo *linkInfo = (ShareLinkInfo *)info;
//        
//        message.text = [NSString stringWithFormat:@"%@：%@ %@", title, linkInfo.desc, linkInfo.link];
//        
//    }else if ([info isKindOfClass:[ShareImageInfo class]]) {
//        
//        ShareImageInfo *imageInfo = (ShareImageInfo *)info;
//        
//        WBImageObject *imageObj = [WBImageObject object];
//        imageObj.imageData = UIImageJPEGRepresentation(imageInfo.image, 1);
//        message.imageObject = imageObj;
//        
//    }
//
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
//    
//    [WeiboSDK sendRequest:request];
}

#pragma mark - qq分享方法

- (void)qqShare:(ShareInfo *)info inPlatform:(SharePlatformType)platform
{
    NSString *title = info.title;
    if (title.length > 80) {
        title = [title substringToIndex:80];
    }
    NSString *description = info.desc;
    if (description.length > 120) {
        description = [description substringToIndex:120];
    }

    
    QQApiObject *obj = nil;
    if ([info isKindOfClass:[ShareLinkInfo class]]) {
        ShareLinkInfo *linkInfo = (ShareLinkInfo *)info;
        
        obj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:linkInfo.link]
                                       title:title
                                 description:description
                            previewImageData:UIImagePNGRepresentation(linkInfo.thumbialImage)];
        
    }else if ([info isKindOfClass:[ShareImageInfo class]]) {
        
        ShareImageInfo *imageInfo = (ShareImageInfo *)info;
        
        obj = [QQApiImageObject objectWithData:UIImagePNGRepresentation(imageInfo.image) previewImageData:nil title:title description:description imageDataArray:nil];
        
    }
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
    
    switch (platform) {
        case SharePlatformTypeQQZone:
            
            [QQApiInterface SendReqToQZone:req];
            break;
        case SharePlatformTypeQQFriend:
            
            [QQApiInterface sendReq:req];
            break;
            
        default:
            break;
    }

}

- (void)share:(ShareInfo *)info inPlatform:(SharePlatformType)platform
{
    switch (platform) {
            
        case SharePlatformTypeWechatFriend:
        case SharePlatformTypeWechatMoment:
            
            [self wechatShare:info inPlatform:platform];
            break;
        case SharePlatformTypeQQFriend:
        case SharePlatformTypeQQZone:
            
            [self qqShare:info inPlatform:platform];
            break;
            
        case SharePlatformTypeSinaWeibo:
            [self weiboShare:info];
            break;
            
        default:
            break;
    }

}


#pragma mark -分类方法
- (UIImage *)drawImage:(UIImage *)image withWidth:(CGFloat)width {
    CGSize imageSize = image.size;
    
    //小于目标宽度则返回自己
    if (imageSize.width < width) {
        return image;
    }
    
    CGFloat height = (imageSize.height /imageSize.width) * width;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, width, height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;

    
}


@end
