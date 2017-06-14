//
//  ScrollViewAutoLayoutVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/13.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "ScrollViewAutoLayoutVC.h"

@interface ScrollViewAutoLayoutVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;

@end

@implementation ScrollViewAutoLayoutVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 布局相关统一代码规范

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    self.contentViewWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width * 2;
}

@end
