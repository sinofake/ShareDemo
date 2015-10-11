//
//  AppDelegate.m
//  Demo
//
//  Created by zhucuirong on 15/10/11.
//  Copyright © 2015年 SINOFAKE SINEP. All rights reserved.
//

#import "AppDelegate.h"
#import <Diplomat.h>
#import <Diplomat/WeiboProxy.h>
#import <Diplomat/WechatProxy.h>
#import <Diplomat/QQProxy.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[Diplomat sharedInstance] registerWithConfigurations:@{kDiplomatTypeWeibo: @{kDiplomatAppIdKey: @"3775309307",
                                                                                  kDiplomatAppRedirectUrlKey: @"http://www.kanghe.com"},
                                                            kDiplomatTypeWechat: @{kDiplomatAppIdKey: @"wxd930ea5d5a258f4f",
                                                                                   kDiplomatAppSecretKey: @"db426a9829e4b49a0dcac7b4162da6b6"},
                                                            kDiplomatTypeQQ: @{kDiplomatAppIdKey: @"1101777551"}}];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[Diplomat sharedInstance] handleOpenURL:url];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
