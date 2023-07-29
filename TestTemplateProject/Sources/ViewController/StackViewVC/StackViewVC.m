//
//  StackViewVC.m
//  TestTemplateProject
//
//  Created by Ben on 2017/12/31.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "StackViewVC.h"


#import <WebKit/WebKit.h>

@interface StackViewVC ()

@end

@implementation StackViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    if (IOS9_OR_LATER) {
        UIStackView *stackView = [UIStackView new];
        stackView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
        // UILayoutConstraintAxisVertical、UILayoutConstraintAxisHorizontal
        stackView.axis = UILayoutConstraintAxisHorizontal;
        // UIStackViewAlignmentFill、UIStackViewAlignmentLeading、UIStackViewAlignmentTop = UIStackViewAlignmentLeading、UIStackViewAlignmentFirstBaseline、UIStackViewAlignmentCenter、UIStackViewAlignmentBottom = UIStackViewAlignmentTrailing、UIStackViewAlignmentLastBaseline
        stackView.alignment = UIStackViewAlignmentLastBaseline;//UIStackViewAlignmentLastBaseline;
        // UIStackViewDistributionFill、UIStackViewDistributionFillEqually、UIStackViewDistributionFillProportionally、UIStackViewDistributionEqualSpacing、UIStackViewDistributionEqualCentering
        stackView.distribution = UIStackViewDistributionFillEqually;//UIStackViewDistributionFillEqually; //UIStackViewDistributionEqualCentering;//
        stackView.spacing = 10;

        UILabel *labelOne = [UILabel new];
        labelOne.textColor = [UIColor redColor];
        labelOne.backgroundColor = [UIColor greenColor];
        labelOne.font = [UIFont systemFontOfSize:10];
        labelOne.text = @"labelOne g";

        UILabel *labelTwo = [UILabel new];
        labelTwo.textColor = [UIColor greenColor];
        labelTwo.backgroundColor = [UIColor blueColor];
        labelTwo.font = [UIFont systemFontOfSize:20];
        labelTwo.text = @"labelTwo g";

        UILabel *labelThree = [UILabel new];
        labelThree.textColor = [UIColor blueColor];
        labelThree.backgroundColor = [UIColor redColor];
        labelThree.font = [UIFont systemFontOfSize:15];
        labelThree.text = @"labelThree g";

        [stackView addArrangedSubview:labelOne];
        [stackView addArrangedSubview:labelTwo];
        [stackView addArrangedSubview:labelThree];

        [self.view addSubview:stackView];
        [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(@10);
            make.width.mas_equalTo(300);  // 测试 UIStackViewDistributionFillProportionally、UIStackViewDistributionEqualSpacing、UIStackViewDistributionEqualCentering 时用到
            make.height.mas_equalTo(100);
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


