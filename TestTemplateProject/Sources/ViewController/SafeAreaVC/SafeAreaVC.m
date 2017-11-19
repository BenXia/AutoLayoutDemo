//
//  SafeAreaVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/11/20.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "SafeAreaVC.h"

@interface SafeAreaVC ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *greenView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SafeAreaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    BOOL IS_SCREEN_58_INCH = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
    
    if (IS_SCREEN_58_INCH) {
        NSLog (@"IS_SCREEN_58_INCH");
    } else {
        NSLog (@"Not IS_SCREEN_58_INCH");
    }
    
    // 1.SafeArea 之 UIView
    //    self.redView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 300)];
    //    self.redView.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:self.redView];
    //
    //    self.greenView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 40, 280)];
    //    self.greenView.backgroundColor = [UIColor greenColor];
    //    [self.redView addSubview:self.greenView];
    
    // 2.SafeArea 之 UIScrollView
    //    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, kScreenHeight - 88 - 20)];
    //    self.scrollView.backgroundColor = [UIColor clearColor];
    //
    //    UIView *scrollContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, 2 * (kScreenHeight - 88 - 20))];
    //    scrollContentView.backgroundColor = [UIColor grayColor];
    //    [self.scrollView addSubview:scrollContentView];
    //    [scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.scrollView);
    //        make.centerX.mas_equalTo(self.scrollView.mas_centerX);
    //        make.height.mas_equalTo(2 * (kScreenHeight - 88 - 20));
    //    }];
    //
    //    UIView *contentSubView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, kScreenHeight - 88 - 20)];
    //    contentSubView1.backgroundColor = [UIColor redColor];
    //    [scrollContentView addSubview:contentSubView1];
    //
    //    UIView *contentSubView2 = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 88 - 20, kScreenWidth - 20, kScreenHeight - 88 - 20)];
    //    contentSubView2.backgroundColor = [UIColor greenColor];
    //    [scrollContentView addSubview:contentSubView2];
    //
    //    [self.view addSubview:self.scrollView];
    //    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    //    }];
    //
    //    self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    
    // 3.SafeArea 之 UITableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, kScreenHeight - 88 - 20)];
    self.tableView.backgroundColor = [UIColor blueColor];
    
    NSLog (@"self.tableView.contentInsetAdjustmentBehavior : %d", self.tableView.contentInsetAdjustmentBehavior);
    
    //    UIWebView
    //    UIViewController
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 1.SafeArea 之 UIView
    //    NSLog (@"self.view.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.view.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.view.layoutMargins), NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    //    NSLog (@"redView.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.redView.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.redView.layoutMargins),
    //        NSStringFromUIEdgeInsets(self.redView.safeAreaInsets));
    //    NSLog (@"greenView.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.greenView.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.greenView.layoutMargins),
    //        NSStringFromUIEdgeInsets(self.greenView.safeAreaInsets));
    //    self.view.insetsLayoutMarginsFromSafeArea = NO;
    //    NSLog (@"self.view.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.view.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.view.layoutMargins),
    //        NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    //    NSLog (@"redView.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.redView.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.redView.layoutMargins),
    //        NSStringFromUIEdgeInsets(self.redView.safeAreaInsets));
    //    NSLog (@"greenView.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.greenView.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.greenView.layoutMargins),
    //        NSStringFromUIEdgeInsets(self.greenView.safeAreaInsets));
    
    // 2.SafeArea 之 UIScrollView
    //    NSLog (@"self.scrollView.safeAreaInsets: %@, self.scrollView.adjustedContentInset: %@, self.scrollView.contentLayoutGuide: %@, self.scrollView.frameLayoutGuide: %@", NSStringFromUIEdgeInsets(self.scrollView.safeAreaInsets), NSStringFromUIEdgeInsets(self.scrollView.adjustedContentInset), NSStringFromCGRect(self.scrollView.contentLayoutGuide.layoutFrame),
    //           NSStringFromCGRect(self.scrollView.frameLayoutGuide.layoutFrame));
    
    // 3.SafeArea 之 UITableView
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


