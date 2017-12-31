//
//  HomePageVC.m
//  TestTemplateProject
//
//  Created by Ben on 15/7/16.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "HomePageVC.h"
#import "AbsoluteLayoutVC.h"
#import "AutoresizingMaskVC.h"
#import "AutoLayoutVC.h"
#import "IntrinsicContentSizeVC.h"
#import "GalleryVC.h"
#import "AutoLayoutAPIVC.h"
#import "ModifyConstraintVC.h"
#import "ScrollViewAutoLayoutVC.h"
#import "SizeClassesVC.h"
#import "StandardAutoLayoutVC.h"
#import "StandardAutoLayoutViewVC.h"
#import "MixLayoutVC.h"
#import "CellHeightCalcVC.h"
#import "Demo11_1VC.h"
#import "Demo11_2VC.h"
#import "Demo11_3VC.h"
#import "SafeAreaVC.h"
#import "LifeCycleVC.h"
#import "StackViewVC.h"
#import "PlaygroundVC.h"

typedef void(^Block)(void);

static const CGFloat kTableViewCellHeight = 60.0f;

@interface HomePageCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) Block didSelectCellHandleBlock;

+ (instancetype)modelWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
                       vcClass:(Class)vcClass
                  navigationVC:(UINavigationController *)navigationVC;

+ (instancetype)modelWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
      didSelectCellHandleBlock:(Block)didSelectCellHandleBlock;

@end

@implementation HomePageCellModel

+ (instancetype)modelWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
                       vcClass:(Class)vcClass
                  navigationVC:(UINavigationController *)navigationVC {
    
    return [HomePageCellModel modelWithTitle:title
                                    subTitle:subTitle
                    didSelectCellHandleBlock:^{
                        UIViewController *vc = [[vcClass alloc] init];
                        [navigationVC pushViewController:vc animated:YES];
                    }];
}


+ (instancetype)modelWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
      didSelectCellHandleBlock:(Block)didSelectCellHandleBlock {
    HomePageCellModel *model = [HomePageCellModel new];
    model.title = title;
    model.subTitle = subTitle;
    model.didSelectCellHandleBlock = didSelectCellHandleBlock;
    
    return model;
}

@end

@interface HomePageVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray <HomePageCellModel *> *dataSourceArray;

@end

@implementation HomePageVC

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    @weakify(self);
    
    HomePageCellModel *model1 = [HomePageCellModel modelWithTitle:@"绝对布局"
                                                         subTitle:@"最原始的布局方式"
                                                          vcClass:[AbsoluteLayoutVC class]
                                                     navigationVC:self.navigationController];
    HomePageCellModel *model2 = [HomePageCellModel modelWithTitle:@"AutoresizingMask"
                                                         subTitle:@"自动布局之AutoresizingMask"
                                                          vcClass:[AutoresizingMaskVC class]
                                                     navigationVC:self.navigationController];
    HomePageCellModel *model3 = [HomePageCellModel modelWithTitle:@"AutoLayout"
                                                         subTitle:@"相对布局之初体验"
                                                          vcClass:[AutoLayoutVC class]
                                                     navigationVC:self.navigationController];
    HomePageCellModel *model4 = [HomePageCellModel modelWithTitle:@"隐式约束"
                                                         subTitle:@"intrinsicContentSize - Content Hugging Priority，Content Compression Resistance Priority"
                                                          vcClass:[IntrinsicContentSizeVC class]
                                                     navigationVC:self.navigationController];
    HomePageCellModel *model5 = [HomePageCellModel modelWithTitle:@"画廊案例"
                                                         subTitle:@"一个简单的相对布局案例"
                                                          vcClass:[GalleryVC class]
                                                     navigationVC:self.navigationController];
    HomePageCellModel *model6 = [HomePageCellModel modelWithTitle:@"代码设置约束"
                                                         subTitle:@"原生API，VFL，Masonry"
                                                          vcClass:[AutoLayoutAPIVC class]
                                                     navigationVC:self.navigationController];
    HomePageCellModel *model7 = [HomePageCellModel modelWithTitle:@"代码修改约束"
                                                         subTitle:@"原生API，VFL，Masonry"
                                                          vcClass:[ModifyConstraintVC class]
                                                     navigationVC:self.navigationController];
    HomePageCellModel *model8 = [HomePageCellModel modelWithTitle:@"UIScrollView使用AutoLayout"
                                                         subTitle:@"一个需要注意的AutoLayout使用场景"
                                                          vcClass:[ScrollViewAutoLayoutVC class]
                                                     navigationVC:self.navigationController];
    HomePageCellModel *model9 = [HomePageCellModel modelWithTitle:@"Size Classes"
                                                         subTitle:@"适配iPhone、iPad不同屏幕横竖屏"
                                                          vcClass:[SizeClassesVC class]
                                                     navigationVC:self.navigationController];
    HomePageCellModel *model10 = [HomePageCellModel modelWithTitle:@"VC自动布局基本结构"
                                                         subTitle:@"自定义UIViewController中布局相关代码，统一规范"
                                                          vcClass:[StandardAutoLayoutVC class]
                                                     navigationVC:self.navigationController];
    HomePageCellModel *model11 = [HomePageCellModel modelWithTitle:@"View自动布局基本结构"
                                                         subTitle:@"自定义视图(包括TableViewCell)中布局相关代码，统一规范"
                                                          vcClass:[StandardAutoLayoutViewVC class]
                                                     navigationVC:self.navigationController];
    HomePageCellModel *model12 = [HomePageCellModel modelWithTitle:@"混合布局"
                                                          subTitle:@"支持/不支持AutoLayout的视图混合布局"
                                                           vcClass:[MixLayoutVC class]
                                                      navigationVC:self.navigationController];
    HomePageCellModel *model13 = [HomePageCellModel modelWithTitle:@"UITableViewCell高度计算"
                                                          subTitle:@"动态计算UITableViewCell高度详解"
                                                           vcClass:[CellHeightCalcVC class]
                                                      navigationVC:self.navigationController];
    HomePageCellModel *model14 = [HomePageCellModel modelWithTitle:@"edgesForExtendedLayout/automaticallyAdjustsScrollViewInsets"
                                                          subTitle:@"UINaviationController/UITabBarController中的视图位置适配问题"
                                          didSelectCellHandleBlock:^{
                                              @strongify(self);
                                              
                                              Demo11_1VC *VC1 = [[Demo11_1VC alloc] init];
                                              VC1.title = @"edgesForExtendedLayout属性";
                                              Demo11_2VC *VC2 = [[Demo11_2VC alloc] init];
                                              VC2.title = @"automaticallyAdjustsScrollViewInsets属性";
                                              Demo11_3VC *VC3 = [[Demo11_3VC alloc] init];
                                              VC3.title = @"contentInsetAdjustmentBehavior属性";
                                              
                                              BNNavigationController *navVC1 = [[BNNavigationController alloc] initWithRootViewController:VC1];
                                              BNNavigationController *navVC2 = [[BNNavigationController alloc] initWithRootViewController:VC2];
                                              BNNavigationController *navVC3 = [[BNNavigationController alloc] initWithRootViewController:VC3];
                                              BNTabBarController *tabVC = [[BNTabBarController alloc] init];
                                              [tabVC setViewControllers:@[navVC1, navVC2, navVC3]];
                                              tabVC.title = @"容器中视图适配";
                                              
                                              [self.navigationController pushViewController:tabVC animated:YES];
                                          }];
    HomePageCellModel *model15 = [HomePageCellModel modelWithTitle:@"SafeArea"
                                                          subTitle:@"SafeArea之UIView/UIScrollView/UITableView/UIWebView/UIViewController"
                                                           vcClass:[SafeAreaVC class]
                                                      navigationVC:self.navigationController];
    HomePageCellModel *model16 = [HomePageCellModel modelWithTitle:@"生命周期"
                                                          subTitle:@"loadView/viewDidLoad/awakeFromNib/initWithCoder"
                                                           vcClass:[LifeCycleVC class]
                                                      navigationVC:self.navigationController];
    HomePageCellModel *model17 = [HomePageCellModel modelWithTitle:@"UIStackView"
                                                          subTitle:@"iOS9 新增的布局技术"
                                                           vcClass:[StackViewVC class]
                                                      navigationVC:self.navigationController];
    
    self.dataSourceArray = [NSArray arrayWithObjects:model1, model2, model3, model4, model5, model6, model7, model8, model9, model10, model11, model12, model13, model14, model17, model16, model15, nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"LayoutSubviews Demos";
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellReuseIdentifier = @"HomePageCellReuseIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellReuseIdentifier];
    }
    
    cell.textLabel.textColor = [UIColor darkTextColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    cell.textLabel.text = [self.dataSourceArray objectAtIndex:indexPath.row].title;
    cell.detailTextLabel.text = [self.dataSourceArray objectAtIndex:indexPath.row].subTitle;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewCellHeight;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Block clickHandleBlock = [self.dataSourceArray objectAtIndex:indexPath.row].didSelectCellHandleBlock;
    if (clickHandleBlock) {
        clickHandleBlock();
    }
   
//    LifeCycleVC *vc = [[LifeCycleVC alloc] init];
//    LifeCycleVC *vc = [[LifeCycleVC alloc] initWithNibName:@"LifeCycleVC" bundle:[NSBundle mainBundle]];
//    vc.hidesBottomBarWhenPushed = YES;
//
//    //[self.navigationController pushViewController:vc animated:YES];
}


@end
