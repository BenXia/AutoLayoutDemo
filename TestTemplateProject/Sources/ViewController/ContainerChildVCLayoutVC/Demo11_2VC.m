//
//  Demo11_2VC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/15.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "Demo11_2VC.h"

@interface Demo11_2VC ()

@end

@implementation Demo11_2VC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        //self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight;
        //self.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeLeft;
    }
    
    // 如果设置了edgesForExtendedLayout属性不含UIRectEdgeTop时，automaticallyAdjustsScrollViewInsets则没用
//    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
