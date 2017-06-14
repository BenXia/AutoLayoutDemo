//
//  AutoLayoutAPIVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/13.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "AutoLayoutAPIVC.h"
#import "Masonry.h"

/*
 注意:任何你使用Xcode4.5或更高版本中，nib或者storyboard文件都默认激活了自动布局。因为自动布局是iOS6以及以上系统的一个新特性，如果你想使用最新的Xcode开发兼容iOS5的程序，你需要将这个选项去掉。
 */


@implementation AutoLayoutAPIVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

//    [self setUiWithConstraints];
//    [self setUiWithVfl];
    [self setUiWithMasonry];
}

#pragma mark - Private methods

- (void)setUiWithConstraints {
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor lightGrayColor];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:contentView];

    /*
         NSLayoutConstraint中的公式如下：
         item1.attribute = multiplier ⨉ item2.attribute + constant
     */
    //设置contentView
    NSLayoutConstraint *contentLeft = [NSLayoutConstraint constraintWithItem:contentView
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1
                                                                    constant:50];
    
    NSLayoutConstraint *contentRight = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-50];
    
    NSLayoutConstraint *contentTop = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:100];
    
    NSLayoutConstraint *contentBottom = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-50];
    
    [self.view addConstraints:@[contentLeft, contentRight, contentTop, contentBottom]];
}

- (void)setUiWithVfl {
    /*
                     功能　　　　　　　　表达式
                     
                     水平方向  　　　　　　  H:
                     
                     垂直方向  　　　　　　  V:
                     
                     Views　　　　　　　　 [view]
                     
                     SuperView　　　　　　|
                     
                     关系　　　　　　　　　>=,==,<=
                     
                     空间,间隙　　　　　　　-
                     
                     优先级　　　　　　　　@value
     
     
     @"H:|-[button1(button)]"和@"V:[button]-[button1(button)]"实现等宽等高
     
     @"V:|-20-[button(==30)]"可以用常量数字
     
     在view名字后面添加括号以及连接处的数字可以赋予表达式更多意义，比如：
     
     •	[cancelButton(72)]-12-[acceptButton(50)]
     •	取消按钮宽72point，accept按钮宽50point，它们之间间距12point
     
     •	[wideView(>=60@700)]
     •	wideView宽度大于等于60point，该约束条件优先级为700（优先级最大值为1000，优先级越高的约束越先被满足）
     
     •	V:[redBox][yellowBox(==redBox)]
     •	竖直布局，先是一个redBox，其下方紧接一个宽度等于redBox宽度的yellowBox
     
     •	H:|-[Find]-[FindNext]-[FindField(>=20)]-|
     •	水平布局，Find距离父view左边缘默认间隔宽度，之后是FindNext距离Find间隔默认宽度；再之后是宽度不小于20的FindField，它和FindNext以及父view右边缘的间距都是默认宽度。（竖线'|‘ 表示superview的边缘）
     
     */
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor lightGrayColor];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:contentView];
    
    NSDictionary *contentViewMetricsDic = @{@"height" : @200, @"padding" : @50};
    NSDictionary *contentViewDict = NSDictionaryOfVariableBindings(contentView);
    
    NSString *contentViewHonVflStr = @"|-padding-[contentView]-padding-|";
    NSString *contentViewVerVflStr = @"V:|-100-[contentView(height)]";
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:contentViewHonVflStr
                                                                      options:NSLayoutFormatAlignAllBottom
                                                                      metrics:contentViewMetricsDic
                                                                        views:contentViewDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:contentViewVerVflStr
                                                                      options:NSLayoutFormatAlignAllBottom
                                                                      metrics:contentViewMetricsDic
                                                                        views:contentViewDict]];
}

- (void)setUiWithMasonry {
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:contentView];
    
    __weak AutoLayoutAPIVC *weakSelf = self;

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        //居中300*300
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
//        make.left.equalTo(weakSelf.view).with.offset(20);
//        make.right.equalTo(weakSelf.view).with.offset(-20);
    }];
    
    UIView *sv1 = [UIView new];
    sv1.backgroundColor = [UIColor redColor];
    [contentView addSubview:sv1];
    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //边距20
        make.edges.equalTo(contentView).with.insets(UIEdgeInsetsMake(100, 20, 100, 20));
        
        /* 等价于
         make.top.equalTo(weakSelf.view).with.offset(20);
         make.left.equalTo(weakSelf.view).with.offset(20);
         make.bottom.equalTo(weakSelf.view).with.offset(-20);
         make.right.equalTo(weakSelf.view).with.offset(-20);
         */
        
        /* 也等价于
         make.top.left.bottom.and.right.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(20, 20, 20, 20));
         */
    }];

    
    /*
     - (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *make))block;
     - (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *make))block;
     - (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block;
     
     
     mas_makeConstraints 只负责新增约束 Autolayout不能同时存在两条针对于同一对象相同的约束 否则会报错
     mas_updateConstraints 针对上面的情况 会更新在block中出现的约束 不会导致出现两个相同约束的情况
     mas_remakeConstraints 则会清除之前的所有约束 仅保留最新的约束
     
     三种函数有效利用 就可以应对各种情况
     
     ！！！注意不要用原生接口或VFL创建后，再用上述三个接口
     */
    
    /*支持的属性
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_left;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_top;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_right;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_bottom;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_leading;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_trailing;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_width;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_height;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_centerX;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_centerY;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_baseline;
     @property (nonatomic, strong, readonly) MASViewAttribute *(^mas_attribute)(NSLayoutAttribute attr);
     
     #if TARGET_OS_IPHONE
     
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_leftMargin;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_rightMargin;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_topMargin;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_bottomMargin;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_leadingMargin;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_trailingMargin;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_centerXWithinMargins;
     @property (nonatomic, strong, readonly) MASViewAttribute *mas_centerYWithinMargins;
     
     #endif
    */
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
