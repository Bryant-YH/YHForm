//
//  AppDelegate.m
//  YHForm
//
//  Created by Bryant_YH on 2020/8/25.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "YHAppDelegate.h"
#import "MainVC.h"
#import "ViewController.h"
#import "TestXVC.h"
@interface YHAppDelegate ()

@end

@implementation YHAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    ViewController 为三区域 X方向
//    TestXVC 为三区域 Y方向
//    MainVC 为两区域
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MainVC alloc] init];
//    self.window.rootViewController = [[ViewController alloc] init];
//    self.window.rootViewController = [[TestXVC alloc] init];

    [self.window makeKeyAndVisible];
    return YES;
}


@end
