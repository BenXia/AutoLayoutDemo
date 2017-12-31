//
//  ModifyConstraintVC.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/13.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "ModifyConstraintVC.h"
#import "Masonry.h"

@interface ModifyConstraintVC ()

@property (weak, nonatomic) IBOutlet UIView *viewA;
@property (weak, nonatomic) IBOutlet UIView *viewB;

@property (strong, nonatomic) UIView *viewCByCode;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viweATopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewBVerticalSpaceConstraint;

@end

@implementation ModifyConstraintVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.viewCByCode = [UIView new];
    self.viewCByCode.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.viewCByCode];
    
    __weak ModifyConstraintVC *weakSelf = self;
    [self.viewCByCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.left.equalTo(weakSelf.view).with.offset(110);
        make.height.mas_equalTo(@220);
        make.top.equalTo(weakSelf.view).with.offset(40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)clickChangeConstraintButton:(id)sender {
    // 直接使用IBOutlet的constraint变量
    self.viweATopConstraint.constant = 200;
    
    // 用代码遍历得到需要修改的constraint
//    for (NSLayoutConstraint *cons in self.view.constraints) {
//        if ((cons.firstItem == self.viewA) && (cons.firstAttribute == NSLayoutAttributeTop)
//            && (cons.secondItem == self.view) && (cons.secondAttribute == NSLayoutAttributeTop)) {
//            cons.constant = 200;
//        }
//    }
    
    [self.view removeConstraint:self.viewBVerticalSpaceConstraint];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.viewB attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-10]];
    
    // 使用Masonry接口实现修改
    __weak ModifyConstraintVC *weakSelf = self;
    // Wrong code:
//    [self.viewB mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(weakSelf.view).with.offset(-10);
//    }];

//    // Wrong code:
//    [self.viewB mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakSelf.view.mas_centerX);
//        make.left.equalTo(weakSelf.view).with.offset(100);
//        make.height.mas_equalTo(@500);
//    }];
    
    // 使用Masonry接口需要注意的地方（remake前提是之前的约束必须也是通过masonry接口添加的）
    // Right Code:
    [self.viewCByCode mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.left.equalTo(weakSelf.view).with.offset(150);
        make.height.mas_equalTo(@500);
        make.bottom.equalTo(weakSelf.view).with.offset(-10);
    }];
    
    // Wrong code:
//    [self.viewCByCode mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakSelf.view.mas_centerX);
//        make.left.equalTo(weakSelf.view).with.offset(150);
//        make.height.mas_equalTo(@500);
//        make.bottom.equalTo(weakSelf.view).with.offset(-10);
//    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 屏幕旋转相关

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
