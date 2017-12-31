//
//  SmartLabel.m
//  TestTemplateProject
//
//  Created by Ben on 2017/12/31.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "SmartLabel.h"

@interface SmartLabel ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation SmartLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor redColor];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [self labelsFont];
    titleLabel.textColor = [UIColor greenColor];
    titleLabel.text = @"";
    self.titleLabel = titleLabel;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(self);
        make.height.equalTo(@25);
    }];
    [self.titleLabel setContentCompressionResistancePriority:1 forAxis:UILayoutConstraintAxisHorizontal];
    
    UILabel *tipLabel = [UILabel new];
    tipLabel.font = [self labelsFont];
    tipLabel.textColor = [UIColor blueColor];
    tipLabel.text = @"";
    self.tipLabel = tipLabel;
    [self addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    [self.tipLabel setContentCompressionResistancePriority:0 forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tipLabel.text = [NSString stringWithFormat:@"width: %.0f", self.size.width];
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    
    self.titleLabel.text = _title;
    
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    CGFloat titleLabelWidth = [_title textSizeForOneLineWithFont:[self labelsFont]].width;
    
    return CGSizeMake(titleLabelWidth, 50);
}

- (UIFont *)labelsFont {
    static UIFont *s_labelsFont = nil;
    
    if (!s_labelsFont) {
        s_labelsFont = [UIFont systemFontOfSize:12.f];
    }
    
    return s_labelsFont;
}

@end


