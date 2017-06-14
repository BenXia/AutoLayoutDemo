//
//  SizeClassesVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/13.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "SizeClassesVC.h"

/*
 Size Classes是iOS 8的功能，但是Xcode 6对它做了一点向后兼容的处理，可以有限度地支持iOS 7等版本。
 
 对于iOS 7等不支持Size Classes功能的版本，
   iPhone会使用Compact-Regular的设置，
   iPad会使用Regular-Regular的设置，其它设置都被忽略。
 */


@interface SizeClassesVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *labelA;

@property (weak, nonatomic) IBOutlet UILabel *labelB;

@property (weak, nonatomic) IBOutlet UILabel *labelC;

@end

@implementation SizeClassesVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 布局相关统一代码规范

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    
    if (IS_IPHONE && UIInterfaceOrientationIsPortrait(((UIInterfaceOrientation)currentOrientation))) {
        self.labelB.hidden = NO;
    } else {
        self.labelB.hidden = YES;
    }

    self.labelA.font = IS_IPAD ? [UIFont systemFontOfSize:30.0f] : [UIFont systemFontOfSize:17.0f];
    self.contentViewWidthConstraint.constant = IS_IPAD ? 400 : 200;
    self.contentViewHeightConstraint.constant = IS_IPAD ? 500 : (UIInterfaceOrientationIsPortrait((UIInterfaceOrientation)currentOrientation) ? 300 : 100);
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

// 只有iOS8的旋转会回调下面的方法
//- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
//              withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
//    [super willTransitionToTraitCollection:newCollection
//                 withTransitionCoordinator:coordinator];
//    [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context) {
//        if ((newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular)
//         && (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact)) {
//            self.labelB.hidden = YES;
//        } else {
//            self.labelB.hidden = NO;
//        }
//        
//        if ((newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular)
//            && (newCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular)) {
//            self.contentViewWidthConstraint.constant = 400;
//            self.labelA.font =[UIFont systemFontOfSize:30.0f];
//        } else {
//            self.contentViewHeightConstraint.constant = 200;
//            self.labelA.font = [UIFont systemFontOfSize:17.0f];
//        }
//        
//        if ((newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular)
//            && (newCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular)) {
//            self.contentViewHeightConstraint.constant = 500;
//        } else if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
//            self.contentViewHeightConstraint.constant = 100;
//        } else {
//            self.contentViewHeightConstraint.constant = 300;
//        }
//        
//        [self.view setNeedsLayout];
//     } completion:nil];
//}

@end
