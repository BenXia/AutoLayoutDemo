//
//  CustomiseDemoView.m
//  AutoLayoutDemo
//
//  Created by Ben on 15/7/15.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "CustomiseDemoView.h"
#import "Masonry.h"

/*
   自定义UITableViewCell规范和该自定义View的规范一致
 */

@interface CustomiseDemoView ()

@property (nonatomic, strong) UIView *viewA;
@property (nonatomic, strong) UIView *viewB;

@end

@implementation CustomiseDemoView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Initialize

- (void)commonInit {
    self.viewA = [UIView new];
    self.viewB = [UIView new];
    self.viewA.backgroundColor = [UIColor greenColor];
    self.viewB.backgroundColor = [UIColor blueColor];
    
    [self addSubview:self.viewA];
    [self addSubview:self.viewB];
    
    self.isLeftRightStyle = NO;
}

#pragma mark - Setters

- (void)setIsLeftRightStyle:(BOOL)isLeftRightStyle {
    _isLeftRightStyle = isLeftRightStyle;
    
    [self setNeedsUpdateConstraints];
}

#pragma mark - 布局相关统一代码规范

// 布局相关的代码，统一填写到下面
/*
 setNeedsUpdateConstraints ： 当一个自定义的View某一个属性的改变可能影响到界面布局，我们应该调用这个方法来告诉布局系统在未来某个时刻需要更新。系统会调用updateConstraints去更新布局。
 
 updateConstraints ：自定义View时，我们应该重写这个方法来设置当前view局部的布局约束。重写这个方法时，一定要调用[super updateConstraints]。
*/
- (void)updateConstraints {
    [super updateConstraints];
    
    __weak CustomiseDemoView *weakSelf = self;
    if (_isLeftRightStyle) {
        [self.viewA mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf.mas_width).with.multipliedBy(0.5);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.height.equalTo(weakSelf.mas_height);
            make.left.equalTo(weakSelf).with.offset(0);
        }];
        [self.viewB mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf.mas_width).with.multipliedBy(0.5);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.height.equalTo(weakSelf.mas_height);
            make.right.equalTo(weakSelf).with.offset(0);
        }];
    } else {
        [self.viewA mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf.mas_width);
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.height.equalTo(weakSelf.mas_height).with.multipliedBy(0.5);
            make.top.equalTo(weakSelf).with.offset(0);
        }];
        [self.viewB mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf.mas_width);
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.height.equalTo(weakSelf.mas_height).with.multipliedBy(0.5);
            make.bottom.equalTo(weakSelf).with.offset(0);
        }];
    }
}

@end
