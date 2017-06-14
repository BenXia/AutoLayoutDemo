//
//  UIUtils.h
//  TestTemplateProject
//
//  Created by Ben on 15/7/16.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kStatusBarHeight            [UIUtils statusHeight]
#define kNavigationBarHeight        [UIUtils navigationBarHeight]
#define kTabBarHeight               [UIUtils tabBarHeight]

#define kScreenWidth                [UIUtils screenWidth]
#define kScreenHeight               [UIUtils screenHeight]
#define IS_IPHONE_4_OR_LESS  ((kScreenWidth == 320) && (kScreenHeight == 480))
#define QQIPHONE_5_5C_5S     ((kScreenWidth == 320) && (kScreenHeight == 568))
#define QQIPHONEBELOW_6      ([UIScreen width] == 320)
#define IS_IPHONE_6          (IS_IPHONE && kScreenHeight == 667.0)
#define IS_IPHONE_6P         (IS_IPHONE && kScreenHeight == 736.0)

@interface UIUtils : NSObject

/**
 * 状态栏高度
 */
+ (CGFloat)statusHeight;

/**
 * 导航栏高度
 */
+ (CGFloat)navigationBarHeight;

/**
 * tabbar高度
 */
+ (CGFloat)tabBarHeight;

/**
 * 键盘高度
 */
+ (CGFloat)keyboardHeightFromNotificationUserInfo:(NSDictionary *)userInfo;

/**
 * 屏幕高度
 */
+ (CGFloat)screenHeight;

/**
 * 屏幕宽度
 */
+ (CGFloat)screenWidth;

@end

