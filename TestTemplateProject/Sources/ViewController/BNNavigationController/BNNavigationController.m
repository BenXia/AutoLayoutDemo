//
//  BNNavigationController.m
//  TestTemplateProject
//
//  Created by Ben on 15/7/16.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "BNNavigationController.h"

@interface BNNavigationController ()

@end

@implementation BNNavigationController

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

@end

