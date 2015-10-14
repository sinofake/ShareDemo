//
//  ViewController.m
//  Demo
//
//  Created by zhucuirong on 15/10/11.
//  Copyright © 2015年 SINOFAKE SINEP. All rights reserved.
//

#import "ViewController.h"
#import "ShareViewController.h"
#import <Diplomat.h>
#import <Diplomat/WechatProxy.h>
#import <Diplomat/WeiboProxy.h>
#import <Diplomat/QQProxy.h>

@interface ViewController ()<ShareViewControllerShareDelegate>
@property (nonatomic, strong) ShareViewController *shareViewController;
@property (nonatomic, assign) BOOL isShareStatus;
@property (nonatomic, assign) BOOL wechatIsTimelineStatus;
//@property (nonatomic, assign) BOOL qqIsQQZoneStatus;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)loginAction:(id)sender {
    self.isShareStatus = NO;
    [self.shareViewController presentPopupControllerAnimated:YES];
}
- (IBAction)shareAction:(id)sender {
    self.isShareStatus = YES;
    [self.shareViewController presentPopupControllerInView:self.view animated:YES];
}

#pragma mark - ShareViewControllerShareDelegate
- (void)shareViewController:(ShareViewController *)shareViewController actionWithType:(ShareType)type {
    [self.shareViewController dismissPopupControllerAnimated:YES];
    
    if (self.isShareStatus) {
        switch (type) {
            case ShareTypeWeiXin: {
                self.wechatIsTimelineStatus = NO;
                [self shareMessage:[self generateImageMessage] type:kDiplomatTypeWechat];
                break;
            }
            case ShareTypeWeiXinTimeLine: {
                self.wechatIsTimelineStatus = YES;
                [self shareMessage:[self generateImageMessage] type:kDiplomatTypeWechat];
                break;
            }
            case ShareTypeWeibo: {
                [self shareMessage:[self generateImageMessage] type:kDiplomatTypeWeibo];
                break;
            }
            case ShareTypeQQ: {
//                self.qqIsQQZoneStatus = NO;
                [self shareMessage:[self generateImageMessage] type:kDiplomatTypeQQ];
                break;
            }
            case ShareTypeQQZone: {
//                self.qqIsQQZoneStatus = YES;
                DTAudioMessage *message = [[DTAudioMessage alloc] init];
                message.messageId = @"79jklfdja89u8klmkl98";
                message.title = @"成功闯关";
                message.desc = @"成功过关！我在玩#英语流利说#闯关之#逛超市#，每次说完英语都有种欲言又止、意犹未尽的感觉，小宇宙马上就要爆发啦。来听听我的伦敦郊区音";
                message.audioUrl = @"http://share.liulishuo.com/v2/share/8a6d90f0dcfa013245d752540071c562";
                message.audioDataUrl = @"http://cdn.llsapp.com/54251c18636d734cc90b4900_Zjk0MWQwMDAwMDBiODdlNQ==_1431672097.mp3";
                message.thumbnailableImage = [UIImage imageNamed:@"IMG_0965_thumb.png"];
                message.userInfo = @{kTencentQQSceneTypeKey: @(TencentSceneZone)};
                [self shareMessage:message type:kDiplomatTypeQQ];
                break;
            }
            default: {
                break;
            }
        }

    }
    else {
        switch (type) {
            case ShareTypeWeiXin: {
                [self loginWithType:kDiplomatTypeWechat];
                break;
            }
            case ShareTypeWeiXinTimeLine: {

                break;
            }
            case ShareTypeWeibo: {
                [self loginWithType:kDiplomatTypeWeibo];
                break;
            }
            case ShareTypeQQ: {
                [self loginWithType:kDiplomatTypeQQ];
                break;
            }
            case ShareTypeQQZone: {
                
                break;
            }
            default: {
                break;
            }
        }
    }
}

- (void)loginWithType:(NSString *)type
{
    [[Diplomat sharedInstance] authWithName:type
                                  completed:^(id result, NSError *error) {
                                      NSLog(@"result:%@", result);
                                      NSLog(@"error: %@", error);
                                      
                                  }];
     /**
      登录成功：resutl: DTUser对象, error: nil
      如果登录失败或用户取消登录，可通过如下对象捕获错误码：
      1.微信：error.code: WXErrCode
      2.微博：error.code: WeiboSDKResponseStatusCode
      3.QQ： error.code： -1024，这里的error.code=-1024是在Diplomat中手动加入的，因为QQ没有提供Code的捕获方法，所以如果发生error，这里可以直接读取错误信息error.localizedDescription
      
      
      
      
     登录成功：resutl: DTUser对象, error:nil
     用户取消登录: resutl:nil,
     微信登录成功：
     uid: o1A_BjsKDZq-o0yxpiFNMpPwn7Sw
     nick: LSMSEED
     avatar: http://wx.qlogo.cn/mmopen/FrdAUicrPIibesLgcoFDiaaANwZDj3kdDWjFDLzevjicVlCiaFgdrNGic9maGz4yesnWVfRM1pfwd4mSkibicreVPqTvBQ/0
     gender: female
     provider: wechat
     
     用户取消登录： error.code:  WXErrCode
     Error Domain=wechat_error_domain Code=-2 "取消" UserInfo=0x15eafc40 {NSLocalizedDescription=取消}
     
     
     QQ登录成功:
     uid: FE6370D9BB30CE6C0F0C8F51A970F891
     nick: freedam
     avatar: http://q.qlogo.cn/qqapp/222222/FE6370D9BB30CE6C0F0C8F51A970F891/100
     gender: male
     provider: qqspace
     
     用户取消登录：这里的Code=-1024是在Diplomat中手动加入的，因为QQ没有提供Code的捕获方法，所以如果发生error，这里可以直接读取error.localizedDescription
     Error Domain=qq_error_domain Code=-1024 "QQ 登录被取消" UserInfo=0x15e9edb0 {NSLocalizedDescription=QQ 登录被取消}
     
     
     
     微博登录成功：
     uid: 1628322050
     nick: lsmseed
     avatar: http://tp3.sinaimg.cn/1628322050/180/0/1
     gender: male
     provider: weibo
     
     用户取消登录： error.code: WeiboSDKResponseStatusCode
     Error Domain=weibo_error_domain Code=-1 "微博请求失败" UserInfo=0x15e60950 {NSLocalizedDescription=微博请求失败}
     */
}

- (DTMessage *)generateImageMessage
{
    DTImageMessage *message = [[DTImageMessage alloc] init];
    message.title = @"我的头像";
    message.desc = @"我在分享我的头像来做测试";
    message.imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"IMG_0965.jpg"], 0.75);;
    message.thumbnailableImage = [UIImage imageNamed:@"IMG_0965.jpg"];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[kWechatSceneTypeKey] = @(WXSceneSession);
    if (self.wechatIsTimelineStatus) {
        userInfo[kWechatSceneTypeKey] = @(WXSceneTimeline);
    }

    userInfo[kTencentQQSceneTypeKey] = @(TencentSceneQQ);
    message.userInfo = userInfo;
    return message;
}

- (void)shareMessage:(DTMessage *)message type:(NSString *)name
{
    [[Diplomat sharedInstance] share:message
                                name:name
                           completed:^(id result, NSError *error) {
                               NSLog(@"result:%@", result);
                               NSLog(@"error:%@", error);
                           }];
}


- (ShareViewController *)shareViewController {
    if (!_shareViewController) {
        _shareViewController = [[ShareViewController alloc] init];
        _shareViewController.shareDelegate = self;
    }
    return _shareViewController;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
