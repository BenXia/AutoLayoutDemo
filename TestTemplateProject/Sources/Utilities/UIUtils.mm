//
//  UIUtils.m
//  TestTemplateProject
//
//  Created by Ben on 15/7/16.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "UIUtils.h"

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
const BOOL IS_SCREEN_35_INCH = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO);
const BOOL IS_SCREEN_4_INCH = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO);
const BOOL IS_SCREEN_47_INCH = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO);
const BOOL IS_SCREEN_55_INCH = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO);
const BOOL IS_SCREEN_58_INCH = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);

const BOOL IS_IPHONEX = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
#else
const BOOL IS_SCREEN_35_INCH = NO;
const BOOL IS_SCREEN_4_INCH = NO;
const BOOL IS_SCREEN_47_INCH = NO;
const BOOL IS_SCREEN_55_INCH = NO;
const BOOL IS_SCREEN_58_INCH = NO;

const BOOL IS_IPHONEX = NO;
#endif

const CGFloat kiPadStatusBarHeight = 20.f;
const CGFloat kiPadNavigationBarHeight = 44.f;

// 下面的都只是用于 iPhone，没有考虑 iPad

static const CGFloat kInnerPortaitNavigationBarHeight = 44.f;
static const CGFloat kInnerLandscapeNavigationBarHeight = 32.f;
static const CGFloat kInnerPortraitTabBarHeight = 49.f;
static const CGFloat kInnerLandscapeBeforeiOS11TabBarHeight = 49.f;
static const CGFloat kInnerLandscapeAfteriOS11TabBarHeight = 32.f;
static const CGFloat kInnerPortaitBottomDangerAreaHeight = 34.f;
static const CGFloat kInnerLandscapeBottomDangerAreaHeight = 21.f;
static const CGFloat kInnerLandscapeLeftDangerAreaWidth = 44.f;
static const CGFloat kInnerLandscapeRightDangerAreaWidth = 44.f;

const CGFloat kPortaitLargeTitleAreaHeight = 52.f;

@implementation UIUtils

#pragma mark - 头部
/**
 * 状态栏高度（已适配 iPhoneX）
 */
+ (CGFloat)statusBarHeight {
    static CGFloat s_statusHeight = 0;
    if (s_statusHeight <= 1e-6) {
        // 适配 iPhoneX（横屏下 iPhone 上显示状态栏，用 hacker 方法显示出状态栏，高度与竖屏保持一致）
        s_statusHeight = IS_SCREEN_58_INCH ? 44 : 20;
    }
    
    return s_statusHeight;
}

/**
 * 竖屏模式下 单纯的导航栏 高度
 */
+ (CGFloat)portraitNavigationBarHeight {
    static CGFloat s_portraitNavigationBarHeight = 0;
    if (s_portraitNavigationBarHeight <= 1e-6) {
        s_portraitNavigationBarHeight = kInnerPortaitNavigationBarHeight;
    }
    
    return s_portraitNavigationBarHeight;
}

/**
 * 横屏模式下 单纯的导航栏 高度
 */
+ (CGFloat)landscapeNavigationBarHeight {
    static CGFloat s_landscapeNavigationBarHeight = 0;
    if (s_landscapeNavigationBarHeight <= 1e-6) {
        s_landscapeNavigationBarHeight = kInnerLandscapeNavigationBarHeight;
    }
    
    return s_landscapeNavigationBarHeight;
}

/**
 * 竖屏模式iOS11大标题情况下 单纯的导航栏 + 大标题区域 高度
 */
+ (CGFloat)portraitLargeTitleNavigationBarHeight {
    static CGFloat s_portraitLargeTitleNavigationBarHeight = 0;
    if (s_portraitLargeTitleNavigationBarHeight <= 1e-6) {
        s_portraitLargeTitleNavigationBarHeight = [UIUtils portraitNavigationBarHeight] + kPortaitLargeTitleAreaHeight;
    }
    
    return s_portraitLargeTitleNavigationBarHeight;
}

/**
 * 竖屏模式下 状态栏 + 单纯的导航栏 高度
 */
+ (CGFloat)portraitStatusBarAndNavigationBarHeight {
    static CGFloat s_portraitStatusBarAndNavigationBarHeight = 0;
    if (s_portraitStatusBarAndNavigationBarHeight <= 1e-6) {
        // 适配 iPhoneX
        s_portraitStatusBarAndNavigationBarHeight = kStatusBarHeight + kPortraitNavigationBarHeight;
    }
    
    return s_portraitStatusBarAndNavigationBarHeight;
}

/**
 * 竖屏模式iOS11大标题情况下 状态栏 + 单纯的导航栏 + 大标题区域 高度
 */
+ (CGFloat)portraitStatusBarAndLargeTitleNavigationBarHeight {
    static CGFloat s_portraitStatusBarAndLargeTitleNavigationBarHeight = 0;
    if (s_portraitStatusBarAndLargeTitleNavigationBarHeight <= 1e-6) {
        // 适配 iPhoneX
        s_portraitStatusBarAndLargeTitleNavigationBarHeight = kStatusBarHeight + kPortraitLargeTitleNavigationBarHeight;
    }
    
    return s_portraitStatusBarAndLargeTitleNavigationBarHeight;
}

#pragma mark - 底部
/**
 * 竖屏模式下 单纯的tabbar 高度
 */
+ (CGFloat)portraitTabBarHeight {
    static CGFloat s_portraitTabBarHeight = 0;
    if (s_portraitTabBarHeight <= 1e-6) {
        s_portraitTabBarHeight = kInnerPortraitTabBarHeight;   // iPhoneX 上为 单纯的TabBar 的高度，不包括底部刘海高度
    }
    
    return s_portraitTabBarHeight;
}

/**
 * 横屏模式下 单纯的tabbar 高度
 */
+ (CGFloat)landscapeTabBarHeight {
    static CGFloat s_landscapeTabBarHeight = 0;
    if (s_landscapeTabBarHeight <= 1e-6) {
        // 适配 iOS11 前后
        s_landscapeTabBarHeight = IOS11_OR_LATER ? kInnerLandscapeAfteriOS11TabBarHeight : kInnerLandscapeBeforeiOS11TabBarHeight;   // iPhoneX 上为 单纯的TabBar 的高度，不包括底部刘海高度
    }
    
    return s_landscapeTabBarHeight;
}

/**
 * 竖屏模式下 底部危险区域 高度(底部刘海高度)
 */
+ (CGFloat)portraitBottomDangerAreaHeight {
    static CGFloat s_portraitBottomDangerAreaHeight = -1;
    if (s_portraitBottomDangerAreaHeight < 0) {
        // 适配 iPhoneX
        s_portraitBottomDangerAreaHeight = IS_SCREEN_58_INCH ? kInnerPortaitBottomDangerAreaHeight: 0;
    }
    
    return s_portraitBottomDangerAreaHeight;
}

/**
 * 横屏模式下 底部危险区域 高度(底部刘海高度)
 */
+ (CGFloat)landscapeBottomDangerAreaHeight {
    static CGFloat s_landscapeBottomDangerAreaHeight = -1;
    if (s_landscapeBottomDangerAreaHeight < 0) {
        s_landscapeBottomDangerAreaHeight = IS_SCREEN_58_INCH ? kInnerLandscapeBottomDangerAreaHeight : 0;
    }
    
    return s_landscapeBottomDangerAreaHeight;
}

/**
 * 竖屏模式下 tabbar + 底部危险区域 高度
 */
+ (CGFloat)portraitTabBarAndBottomDangerAreaHeight {
    static CGFloat s_portraitTabBarAndBottomDangerAreaHeight = 0;
    if (s_portraitTabBarAndBottomDangerAreaHeight <= 1e-6) {
        // 适配 iPhoneX
        s_portraitTabBarAndBottomDangerAreaHeight = IS_SCREEN_58_INCH ? (kPortraitTabBarHeight + kInnerPortaitBottomDangerAreaHeight) : kPortraitTabBarHeight;    // kInnerPortaitBottomDangerAreaHeight 为底部刘海高度
    }
    
    return s_portraitTabBarAndBottomDangerAreaHeight;
}

/**
 * 横屏模式下 tabbar + 底部危险区域 高度
 */
+ (CGFloat)landscapeTabBarAndBottomDangerAreaHeight {
    static CGFloat s_landscapeTabBarAndBottomDangerAreaHeight = 0;
    if (s_landscapeTabBarAndBottomDangerAreaHeight <= 1e-6) {
        // 适配 iPhoneX
        s_landscapeTabBarAndBottomDangerAreaHeight = IS_SCREEN_58_INCH ? (kLandscapeTabBarHeight + kInnerLandscapeBottomDangerAreaHeight) : kLandscapeTabBarHeight;           // kInnerLandscapeBottomDangerAreaHeight 为底部刘海高度
    }
    
    return s_landscapeTabBarAndBottomDangerAreaHeight;
}

+ (CGFloat)keyboardHeightFromNotificationUserInfo:(NSDictionary *)userInfo {
    CGFloat currentKeyboardHeight = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= 80000))
    //以下代码主要是为了让iOS8SDK＋iOS8之后的设备得到的键盘尺寸与iOS8SDK之前的计算方法保持一致
    if (([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)
        && UIDeviceOrientationIsLandscape((UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation)) {
        currentKeyboardHeight = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.width;
    }
#endif
    
    return currentKeyboardHeight;
}

#pragma mark - 两边

/**
 * 横屏模式下 左边危险区域 宽度
 */
+ (CGFloat)landscapeLeftDangerAreaWidth {
    static CGFloat s_landscapeLeftDangerAreaWidth = 0;
    if (s_landscapeLeftDangerAreaWidth <= 1e-6) {
        // 适配 iPhoneX
        s_landscapeLeftDangerAreaWidth = IS_SCREEN_58_INCH ? kInnerLandscapeLeftDangerAreaWidth : 0;
    }
    
    return s_landscapeLeftDangerAreaWidth;
}

/**
 * 横屏模式下 右边危险区域 宽度
 */
+ (CGFloat)landscapeRightDangerAreaWidth {
    static CGFloat s_landscapeRightDangerAreaWidth = 0;
    if (s_landscapeRightDangerAreaWidth <= 1e-6) {
        // 适配 iPhoneX
        s_landscapeRightDangerAreaWidth = IS_SCREEN_58_INCH ? kInnerLandscapeRightDangerAreaWidth : 0;
    }
    
    return s_landscapeRightDangerAreaWidth;
}

#pragma mark - 其它

+ (CGFloat)screenWidth {
    return MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

+ (CGFloat)screenHeight {
    return MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

@end

