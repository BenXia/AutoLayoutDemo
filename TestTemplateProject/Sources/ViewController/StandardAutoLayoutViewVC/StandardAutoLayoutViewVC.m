//
//  StandardAutoLayoutViewVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/13.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "StandardAutoLayoutViewVC.h"
#import "CustomiseDemoView.h"

@interface StandardAutoLayoutViewVC ()

@property (weak, nonatomic) IBOutlet CustomiseDemoView *customView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *customViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *customViewHeightConstraint;

@end

@implementation StandardAutoLayoutViewVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //self.customView.translatesAutoresizingMaskIntoConstraints = YES; // Notice
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)didClickChangeStyleButtonAction:(id)sender {
    self.customView.isLeftRightStyle = !self.customView.isLeftRightStyle;
}

#pragma mark - 布局相关统一代码规范

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    
    self.customViewWidthConstraint.constant = IS_IPAD ? 400 : 200;
    self.customViewHeightConstraint.constant = IS_IPAD ? 600 : (UIInterfaceOrientationIsPortrait((UIInterfaceOrientation)currentOrientation) ? 400 : 100);
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
