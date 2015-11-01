//
//  ShareViewController.h
//  Demo
//
//  Created by zhucuirong on 15/10/11.
//  Copyright © 2015年 SINOFAKE SINEP. All rights reserved.
//

#import "SSPopupController.h"



@class ShareViewController;

typedef NS_ENUM(NSInteger, ShareType) {
    ShareTypeWeiXin,
    ShareTypeWeiXinTimeLine,
    ShareTypeWeibo,
    ShareTypeQQ,
    ShareTypeQQZone
};

@protocol ShareViewControllerShareDelegate <NSObject>

- (void)shareViewController:(ShareViewController *)shareViewController actionWithType:(ShareType)type;

@end

@interface ShareViewController : SSPopupController
@property (nonatomic, weak) id<ShareViewControllerShareDelegate>shareDelegate;

@end
