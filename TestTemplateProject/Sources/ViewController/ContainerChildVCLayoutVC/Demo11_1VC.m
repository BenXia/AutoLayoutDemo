//
//  Demo11_1VC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/15.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "Demo11_1VC.h"

@interface Demo11_1VC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Demo11_1VC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone; // UIRectEdgeTop;
//        self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight;
//        self.edgesForExtendedLayout = UIRectEdgeBottom;
    }
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;//UIScrollViewContentInsetAdjustmentNever; //UIScrollViewContentInsetAdjustmentAlways;UIScrollViewContentInsetAdjustmentAutomatic;
    } else {
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
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
