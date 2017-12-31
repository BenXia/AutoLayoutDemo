//
//  AbsoluteLayoutVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/13.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "AbsoluteLayoutVC.h"

/*
 layoutSubviews在以下情况下会被调用：
 1、init初始化不会触发layoutSubviews
 2、addSubview会触发layoutSubviews
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 4、滚动一个UIScrollView会触发layoutSubviews
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */


static const CGFloat kViewEdge = 10;
static const CGFloat kViewAiPhoneVerticalOriginY = 10;
static const CGFloat kViewAiPhoneHorizontalOriginY = 44;
static const CGFloat kViewAiPadOriginY = 10;
static const CGFloat kViewAHeight = 200;

@interface AbsoluteLayoutVC ()

@property (weak, nonatomic) IBOutlet UIView *viewA;
@property (weak, nonatomic) IBOutlet UIView *viewB;
@property (weak, nonatomic) IBOutlet UIView *viewC;
@property (weak, nonatomic) IBOutlet UIView *viewD;

@end

@implementation AbsoluteLayoutVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat kViewAOriginY = IS_IPHONE ? (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) ? kViewAiPhoneVerticalOriginY : kViewAiPhoneHorizontalOriginY) : kViewAiPadOriginY;
    
    _viewA.frame = CGRectMake(kViewEdge, kViewAOriginY, (screenWidth - 3 * kViewEdge) / 2, kViewAHeight);
    
    _viewB.frame = CGRectMake(CGRectGetMaxX(_viewA.frame) + kViewEdge,
                              kViewAOriginY,
                              _viewA.frame.size.width,
                              (_viewA.frame.size.height - kViewEdge) / 10 * 3);
    _viewC.frame = CGRectMake(_viewB.frame.origin.x,
                              CGRectGetMaxY(_viewB.frame) + kViewEdge,
                              _viewB.frame.size.width,
                              _viewB.frame.size.height / 3 * 7);
    _viewD.frame = CGRectMake(kViewEdge,
                              CGRectGetMaxY(_viewA.frame) + kViewEdge,
                              screenWidth - 2 * kViewEdge,
                              screenHeight - (CGRectGetMaxY(_viewA.frame) + kViewEdge) - kViewEdge);
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
   
@end

