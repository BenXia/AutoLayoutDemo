//
//  UIUtils.m
//  TestTemplateProject
//
//  Created by Ben on 15/7/16.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils

+ (CGFloat)statusHeight {
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height;
}

+ (CGFloat)navigationBarHeight {
    UINavigationController *vc =[UINavigationController new];
    CGRect rectNav = [vc.navigationBar frame];
    return rectNav.size.height;
}

+ (CGFloat)tabBarHeight {
    UITabBarController *vc = [UITabBarController new];
    CGRect rectTab = [vc.tabBar frame];
    return rectTab.size.height;
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

+ (CGFloat)screenWidth {
    return MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

+ (CGFloat)screenHeight {
    return MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

@end

