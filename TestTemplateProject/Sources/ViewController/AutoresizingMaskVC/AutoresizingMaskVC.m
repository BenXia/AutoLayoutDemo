//
//  AutoresizingMaskVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/13.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "AutoresizingMaskVC.h"

//static const CGFloat kViewEdge = 10;
//static const CGFloat kViewAiPhoneVerticalOriginY = 10;
//static const CGFloat kViewAiPhoneHorizontalOriginY = 44;
//static const CGFloat kViewAiPadOriginY = 10;
//static const CGFloat kViewAHeight = 200;

@interface AutoresizingMaskVC ()

@property (weak, nonatomic) IBOutlet UIView *viewA;
@property (weak, nonatomic) IBOutlet UIView *viewB;
@property (weak, nonatomic) IBOutlet UIView *viewC;
@property (weak, nonatomic) IBOutlet UIView *viewD;

@end

@implementation AutoresizingMaskVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGFloat kStatusBarAndNavigationBarHeight = 0;
    if (IS_IPHONE) {
        kStatusBarAndNavigationBarHeight = UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) ? kPortraitStatusBarAndNavigationBarHeight : (kLandscapeNavigationBarHeight + (IOS11_OR_LATER ? 0 : kStatusBarHeight));
    } else {
        kStatusBarAndNavigationBarHeight = kiPadStatusBarHeight + kiPadNavigationBarHeight;
    }
    
    CGFloat kBottomDangerAreaHeight = IS_IPHONE ? (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) ? kPortraitBottomDangerAreaHeight : kLandscapeBottomDangerAreaHeight) : 0;
    self.viewD.height = kScreenHeight - kStatusBarAndNavigationBarHeight - kBottomDangerAreaHeight - 220 - 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    
//    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
//    CGFloat kViewAOriginY = IS_IPHONE ? (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) ? kViewAiPhoneVerticalOriginY : kViewAiPhoneHorizontalOriginY) : kViewAiPadOriginY;
//    
//    _viewA.frame = CGRectMake(kViewEdge, kViewAOriginY, (screenWidth - 3 * kViewEdge) / 2, kViewAHeight);
//    
//    _viewB.frame = CGRectMake(CGRectGetMaxX(_viewA.frame) + kViewEdge,
//                              kViewAOriginY,
//                              _viewA.frame.size.width,
//                              (_viewA.frame.size.height - kViewEdge) / 10 * 3);
//    _viewC.frame = CGRectMake(_viewB.frame.origin.x,
//                              CGRectGetMaxY(_viewB.frame) + kViewEdge,
//                              _viewB.frame.size.width,
//                              _viewB.frame.size.height / 3 * 7);
//    _viewD.frame = CGRectMake(kViewEdge,
//                              CGRectGetMaxY(_viewA.frame) + kViewEdge,
//                              screenWidth - 2 * kViewEdge,
//                              screenHeight - (CGRectGetMaxY(_viewA.frame) + kViewEdge) - kViewEdge);
//}


/*
 这个方法默认的实现是调用对应View的 -updateConstraints 。ViewController的View在更新视图布局时，会先调用ViewController的updateViewConstraints 方法。我们可以通过重写这个方法去更新当前View的内部布局，而不用再继承这个View去重写-updateConstraints方法。我们在重写这个方法时，务必要调用 super 或者 调用当前View的 -updateConstraints 方法。
 */

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    NSLog (@"注意，这种情况下永远不会触发");
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
