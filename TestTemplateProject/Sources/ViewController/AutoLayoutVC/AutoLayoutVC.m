//
//  AutoLayoutVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/13.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "AutoLayoutVC.h"

//static const CGFloat kViewAiPhoneVerticalOriginY = 10;
//static const CGFloat kViewAiPhoneHorizontalOriginY = 44;
//static const CGFloat kViewAiPadOriginY = 10;


/*
 UIViewController中的Xib中的尺寸是 (320, 568)。
 
 2015-06-18 22:14:00.055 TestProject[10783:607] initWithNibName
 2015-06-18 22:14:00.086 TestProject[10783:607] viewDidLoad
 2015-06-18 22:14:00.086 TestProject[10783:607] self.view.frame: {{0, 0}, {320, 568}}
 2015-06-18 22:14:00.087 TestProject[10783:607] viewWillAppear:
 2015-06-18 22:14:00.087 TestProject[10783:607] self.view.frame: {{0, 0}, {320, 480}}
 2015-06-18 22:14:00.090 TestProject[10783:607] viewWillLayoutSubviews
 2015-06-18 22:14:00.090 TestProject[10783:607] self.view.frame: {{0, 0}, {320, 480}}
 2015-06-18 22:14:00.090 TestProject[10783:607] viewDidLayoutSubviews
 2015-06-18 22:14:00.091 TestProject[10783:607] self.view.frame: {{0, 0}, {320, 480}}
 2015-06-18 22:14:00.206 TestProject[10783:607] viewDidAppear:
 2015-06-18 22:14:00.206 TestProject[10783:607] self.view.frame: {{0, 0}, {320, 480}}
 */


@interface AutoLayoutVC ()

@property (weak, nonatomic) IBOutlet UIView *viewA;
@property (weak, nonatomic) IBOutlet UIView *viewB;
@property (weak, nonatomic) IBOutlet UIView *viewC;
@property (weak, nonatomic) IBOutlet UIView *viewD;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation AutoLayoutVC

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

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
