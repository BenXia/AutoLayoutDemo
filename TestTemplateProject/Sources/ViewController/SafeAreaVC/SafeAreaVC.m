//
//  SafeAreaVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/11/20.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "SafeAreaVC.h"
#import <WebKit/WebKit.h>
#import "MJRefresh.h"

@interface SafeAreaVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *greenView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *webViewContentView;
@property (nonatomic, strong) UIWebView *uiWebView;
@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) UIViewController *childVC;

@end

@implementation SafeAreaVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
//    [self initUIViewRelated];
    
    // 2.SafeArea 之 UIScrollView
//    [self initUIScrollViewRelated];
    
    // 3.SafeArea 之 UITableView
//    [self initUITableViewRelated];
    
    // 4.SafeArea 之 UIWebView/WKWebView
//    [self initUIWebViewRelated];
    [self initWKWebViewRelated];

    // 5.SafeArea 之 UIViewController
//    [self initUIViewControllerRelated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 1.SafeArea 之 UIView
    //[self postDidLayoutUIViewRelated];
    
    // 2.SafeArea 之 UIScrollView
    //[self postDidLayoutUIScrollViewRelated];
    
    // 3.SafeArea 之 UITableView
    //[self postDidLayoutUITableViewRelated];
    
    // 4.SafeArea 之 UIWebView/WKWebView
//    [self postDidLayoutUIWebViewRelated];
    [self postDidLayoutWKWebViewRelated];
    
    // 5.SafeArea 之 UIViewController
//    [self postDidLayoutUIViewControllerRelated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIView related

// SafeArea 之 UIView
- (void)initUIViewRelated {
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 300)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];

    self.greenView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 40, 280)];
    self.greenView.backgroundColor = [UIColor greenColor];
    [self.redView addSubview:self.greenView];
}

- (void)postDidLayoutUIViewRelated {
    if (@available(iOS 11.0, *)) {
        NSLog (@"self.view.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.view.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.view.layoutMargins), NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
        NSLog (@"redView.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.redView.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.redView.layoutMargins),
            NSStringFromUIEdgeInsets(self.redView.safeAreaInsets));
        NSLog (@"greenView.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.greenView.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.greenView.layoutMargins),
            NSStringFromUIEdgeInsets(self.greenView.safeAreaInsets));
        self.view.insetsLayoutMarginsFromSafeArea = NO;
        NSLog (@"self.view.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.view.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.view.layoutMargins),
            NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
        NSLog (@"redView.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.redView.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.redView.layoutMargins),
            NSStringFromUIEdgeInsets(self.redView.safeAreaInsets));
        NSLog (@"greenView.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.greenView.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.greenView.layoutMargins),
            NSStringFromUIEdgeInsets(self.greenView.safeAreaInsets));
    }
}

#pragma mark - UIScrollView related

- (void)initUIScrollViewRelated {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, kScreenHeight - 88 - 20)];
    self.scrollView.backgroundColor = [UIColor clearColor];

    UIView *scrollContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, 2 * (kScreenHeight - 88 - 20))];
    scrollContentView.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:scrollContentView];
    [scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.centerX.mas_equalTo(self.scrollView.mas_centerX);
        make.height.mas_equalTo(2 * (kScreenHeight - 88 - 20));
    }];

    UIView *contentSubView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, kScreenHeight - 88 - 20)];
    contentSubView1.backgroundColor = [UIColor redColor];
    [scrollContentView addSubview:contentSubView1];

    UIView *contentSubView2 = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 88 - 20, kScreenWidth - 20, kScreenHeight - 88 - 20)];
    contentSubView2.backgroundColor = [UIColor greenColor];
    [scrollContentView addSubview:contentSubView2];

    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];

    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
}

- (void)postDidLayoutUIScrollViewRelated {
    if (@available(iOS 11.0, *)) {
        NSLog (@"self.scrollView.safeAreaInsets: %@, self.scrollView.adjustedContentInset: %@, self.scrollView.contentLayoutGuide: %@, self.scrollView.frameLayoutGuide: %@", NSStringFromUIEdgeInsets(self.scrollView.safeAreaInsets), NSStringFromUIEdgeInsets(self.scrollView.adjustedContentInset), NSStringFromCGRect(self.scrollView.contentLayoutGuide.layoutFrame),
               NSStringFromCGRect(self.scrollView.frameLayoutGuide.layoutFrame));
    }
}

#pragma mark - UITableView related

- (void)initUITableViewRelated {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, kScreenHeight - 88 - 20)];
    self.tableView.backgroundColor = [UIColor blueColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    @weakify(self);
    if (@available(iOS 11.0, *)) {
        NSLayoutConstraint *top = [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
        NSLayoutConstraint *bottom = [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
        //NSLayoutConstraint *bottom = [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor];
        NSLayoutConstraint *left = [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
        NSLayoutConstraint *right = [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
        [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
    } else {
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
//            if (@available(iOS 11.0, *)) {
//                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
//                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//                make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
//                make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
//            } else {
                make.edges.equalTo(self.view);
//            }
        }];
    }
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];

    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开就可以刷新了";
    self.tableView.headerRefreshingText = @"正在刷新";

    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];

    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在加载中";
    
//    if (@available(iOS 11.0, *)) {
//        NSLog (@"self.tableView.contentInsetAdjustmentBehavior : %d", self.tableView.contentInsetAdjustmentBehavior);
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
//        NSLog (@"self.tableView.contentInsetAdjustmentBehavior : %d", self.tableView.contentInsetAdjustmentBehavior);
//    }
}

- (void)headerRereshing {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView footerEndRefreshing];
    });
}

- (void)postDidLayoutUITableViewRelated {
    if (@available(iOS 11.0, *)) {
        NSLog (@"self.tableView.contentInsetAdjustmentBehavior : %zd", self.tableView.contentInsetAdjustmentBehavior);
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        NSLog (@"self.tableView.contentInsetAdjustmentBehavior : %zd", self.tableView.contentInsetAdjustmentBehavior);
        
        NSLog (@"self.tableView.insetsContentViewsToSafeArea: %d", self.tableView.insetsContentViewsToSafeArea);
    }
}

#pragma mark - UITableViewDatesource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor redColor];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row];
    cell.detailTextLabel.text = @"YY直播被判侵权 游戏直播冬天来了？";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIWebView/WKWebView related

- (void)initUIWebViewRelated {
    self.webViewContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 88)];
    self.webViewContentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.webViewContentView];
    
    @weakify(self);
//    if (@available(iOS 11.0, *)) {
//        NSLayoutConstraint *top = [self.webViewContentView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
//        NSLayoutConstraint *bottom = [self.webViewContentView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
////        NSLayoutConstraint *bottom = [self.webViewContentView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor];
//        NSLayoutConstraint *left = [self.webViewContentView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
//        NSLayoutConstraint *right = [self.webViewContentView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
//        [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
//    } else {
        [self.webViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
//            if (@available(iOS 11.0, *)) {  // 只有走这儿 UIWebView 的 frame 才会上去
//                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
//                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//                make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
//                make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
//            } else {
                make.edges.equalTo(self.view);
//            }
        }];
//    }
    
    self.uiWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 88)];
//    [self.view addSubview:self.uiWebView];
    [self.webViewContentView addSubview:self.uiWebView];
    
    [self.uiWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.webViewContentView);
    }];
    
//    @weakify(self);
//    if (@available(iOS 11.0, *)) {
//        NSLayoutConstraint *top = [self.uiWebView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
//        NSLayoutConstraint *bottom = [self.uiWebView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
////        NSLayoutConstraint *bottom = [self.uiWebView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor];
//        NSLayoutConstraint *left = [self.uiWebView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
//        NSLayoutConstraint *right = [self.uiWebView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
//        [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
//    } else {
//        [self.uiWebView mas_makeConstraints:^(MASConstraintMaker *make) {
//            @strongify(self);
////            if (@available(iOS 11.0, *)) {      // 只有走这儿 UIWebView 的 frame 才会上去
////                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
////                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
////                make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
////                make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
////            } else {
//                make.edges.equalTo(self.view);
////            }
//        }];
//    }
    
    [self.uiWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.csdn.net"]]];
}

- (void)initWKWebViewRelated {
//    self.webViewContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 88)];
//    self.webViewContentView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.webViewContentView];
//
//    @weakify(self);
//    if (@available(iOS 11.0, *)) {
//        NSLayoutConstraint *top = [self.webViewContentView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
//        NSLayoutConstraint *bottom = [self.webViewContentView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
////        NSLayoutConstraint *bottom = [self.webViewContentView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor];
//        NSLayoutConstraint *left = [self.webViewContentView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
//        NSLayoutConstraint *right = [self.webViewContentView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
//        [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
//    } else {
//        [self.webViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            @strongify(self);
////            if (@available(iOS 11.0, *)) {   // 只有走这儿 WKWebView 的 frame 才会上去
////                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
////                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
////                make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
////                make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
////            } else {
//                make.edges.equalTo(self.view);
////            }
//        }];
//    }

    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 88)];
    [self.view addSubview:self.wkWebView];
//    [self.webViewContentView addSubview:self.wkWebView];
//
//    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.webViewContentView);
//    }];
    
    @weakify(self);
    if (@available(iOS 11.0, *)) {
        NSLayoutConstraint *top = [self.wkWebView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
        //NSLayoutConstraint *bottom = [self.wkWebView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
        NSLayoutConstraint *bottom = [self.wkWebView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor];
        NSLayoutConstraint *left = [self.wkWebView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
        NSLayoutConstraint *right = [self.wkWebView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
        [NSLayoutConstraint activateConstraints:@[top, bottom, left, right]];
    } else {
        [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            if (@available(iOS 11.0, *)) {    // 只有走这儿 WKWebView 的 frame 才会上去
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
                make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
                make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            } else {
                make.edges.equalTo(self.view);
            }
        }];
    }
    
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.csdn.net"]]];
}

- (void)postDidLayoutUIWebViewRelated {
    if (@available(iOS 11.0, *)) {
        NSLog(@"self.additionalSafeAreaInsets: %@ self.view.frame: %@ self.view.safeAreaInsets: %@", NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets), NSStringFromCGRect(self.view.frame),  NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
        
        NSLog (@"self.uiWebView.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.uiWebView.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.uiWebView.layoutMargins), NSStringFromUIEdgeInsets(self.uiWebView.safeAreaInsets));
    }
}

- (void)postDidLayoutWKWebViewRelated {
    if (@available(iOS 11.0, *)) {
        NSLog(@"self.additionalSafeAreaInsets: %@ self.view.frame: %@ self.view.safeAreaInsets: %@", NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets), NSStringFromCGRect(self.view.frame),  NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
        
        NSLog (@"self.wkWebView.directionalLayoutMargins: %@\nlayoutMargins: %@\nsafeAreaInsets: %@", NSStringFromDirectionalEdgeInsets(self.wkWebView.directionalLayoutMargins), NSStringFromUIEdgeInsets(self.wkWebView.layoutMargins), NSStringFromUIEdgeInsets(self.wkWebView.safeAreaInsets));
    }
}

#pragma mark - UIViewController related

- (void)initUIViewControllerRelated {
    self.childVC = [[UIViewController alloc] init];
    self.childVC.view.backgroundColor = RGBA(212, 127, 0, 0.5);
    [self addChildViewController:self.childVC];
    
    [self.view addSubview:self.childVC.view];
}

- (void)postDidLayoutUIViewControllerRelated {
    self.childVC.view.frame = CGRectMake(10, 10, kScreenWidth - 20, kScreenHeight - 88 - 20);
    
    if (@available(iOS 11.0, *)) {
        NSLog(@"self.additionalSafeAreaInsets: %@ self.view.frame: %@ self.view.safeAreaInsets: %@", NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets), NSStringFromCGRect(self.view.frame),  NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
        
        NSLog(@"self.childVC.additionalSafeAreaInsets: %@ self.childVC.view.frame: %@ self.childVC.view.safeAreaInsets: %@", NSStringFromUIEdgeInsets(self.childVC.additionalSafeAreaInsets), NSStringFromCGRect(self.childVC.view.frame), NSStringFromUIEdgeInsets(self.childVC.view.safeAreaInsets));
    }
}

@end


