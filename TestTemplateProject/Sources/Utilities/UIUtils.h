//
//  UIUtils.h
//  TestTemplateProject
//
//  Created by Ben on 15/7/16.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const BOOL IS_SCREEN_35_INCH;     // iPhone2G/3G/3GS/4/4S   (640, 960)
extern const BOOL IS_SCREEN_4_INCH;      // iPhone5/5S/5C          (640, 1136)
extern const BOOL IS_SCREEN_47_INCH;     // iPhone6/7/8            (750, 1334)
extern const BOOL IS_SCREEN_55_INCH;     // iPhone6/7/8P           (1242, 2208)
extern const BOOL IS_SCREEN_58_INCH;     // iPhoneX                (1125, 2436)

extern const BOOL IS_IPHONEX;            // iPhoneX 有刘海有点奇葩，单独拎一个常量（暂时和 IS_SCREEN_58_INCH 一致，只是为了方便理解使用）

#define IS_IPAD    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA  ([[UIScreen mainScreen] scale] >= 2.0)

#pragma mark - UIUtils

extern const CGFloat kiPadStatusBarHeight;
extern const CGFloat kiPadNavigationBarHeight;

// 下面的都只是用于 iPhone，没有考虑 iPad

extern const CGFloat kPortaitLargeTitleAreaHeight;  // iOS11 只有竖屏模式下会有，横屏下没有

#define kStatusBarHeight                 [UIUtils statusBarHeight]
#define kPortraitNavigationBarHeight     [UIUtils portraitNavigationBarHeight]
#define kLandscapeNavigationBarHeight    [UIUtils landscapeNavigationBarHeight]
#define kPortraitLargeTitleNavigationBarHeight      [UIUtils portraitLargeTitleNavigationBarHeight]
#define kPortraitStatusBarAndNavigationBarHeight    [UIUtils portraitStatusBarAndNavigationBarHeight]
#define kPortraitStatusBarAndLargeTitleNavigationBarHeight  [UIUtils portraitStatusBarAndLargeTitleNavigationBarHeight]

#define kPortraitTabBarHeight                       [UIUtils portraitTabBarHeight]
#define kLandscapeTabBarHeight                      [UIUtils landscapeTabBarHeight]
#define kPortraitBottomDangerAreaHeight             [UIUtils portraitBottomDangerAreaHeight]
#define kLandscapeBottomDangerAreaHeight            [UIUtils landscapeBottomDangerAreaHeight]
#define kPortraitTabBarAndBottomDangerAreaHeight    [UIUtils portraitTabBarAndBottomDangerAreaHeight]
#define kLandscapeTabBarAndBottomDangerAreaHeight   [UIUtils landscapeTabBarAndBottomDangerAreaHeight]

#define kLandscapeLeftDangerAreaWidth   [UIUtils landscapeLeftDangerAreaWidth]
#define kLandscapeRightDangerAreaWidth  [UIUtils landscapeRightDangerAreaWidth]

#define kScreenWidth                     [UIUtils screenWidth]
#define kScreenHeight                    [UIUtils screenHeight]

@interface UIUtils : NSObject

/**
 * 状态栏高度（已适配 iPhoneX）
 */
+ (CGFloat)statusBarHeight;

/**
 * 竖屏模式下 单纯的导航栏 高度
 */
+ (CGFloat)portraitNavigationBarHeight;

/**
 * 横屏模式下 单纯的导航栏 高度
 */
+ (CGFloat)landscapeNavigationBarHeight;

/**
 * 竖屏模式iOS11大标题情况下 单纯的导航栏 + 大标题区域 高度
 */
+ (CGFloat)portraitLargeTitleNavigationBarHeight;

/**
 * 竖屏模式下 状态栏 + 单纯的导航栏 高度
 */
+ (CGFloat)portraitStatusBarAndNavigationBarHeight;

/**
 * 竖屏模式iOS11大标题情况下 状态栏 + 单纯的导航栏 + 大标题区域 高度
 */
+ (CGFloat)portraitStatusBarAndLargeTitleNavigationBarHeight;

#pragma mark - 底部
/**
 * 竖屏模式下 单纯的tabbar 高度
 */
+ (CGFloat)portraitTabBarHeight;

/**
 * 横屏模式下 单纯的tabbar 高度
 */
+ (CGFloat)landscapeTabBarHeight;

/**
 * 竖屏模式下 底部危险区域 高度(底部刘海高度)
 */
+ (CGFloat)portraitBottomDangerAreaHeight;

/**
 * 横屏模式下 底部危险区域 高度(底部刘海高度)
 */
+ (CGFloat)landscapeBottomDangerAreaHeight;

/**
 * 竖屏模式下 tabbar + 底部危险区域 高度
 */
+ (CGFloat)portraitTabBarAndBottomDangerAreaHeight;

/**
 * 横屏模式下 tabbar + 底部危险区域 高度
 */
+ (CGFloat)landscapeTabBarAndBottomDangerAreaHeight;

#pragma mark - 两边

/**
 * 横屏模式下 左边危险区域 宽度
 */
+ (CGFloat)landscapeLeftDangerAreaWidth;

/**
 * 横屏模式下 右边危险区域 宽度
 */
+ (CGFloat)landscapeRightDangerAreaWidth;

#pragma mark - 其它

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

