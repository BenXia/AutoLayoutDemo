//
//  CustomView.m
//  TestTemplateProject
//
//  Created by Ben on 2017/12/24.
//  Copyright © 2017年 iOSStudio. All rights reserved.
//

#import "CustomView.h"

@interface CustomView ()

@end

@implementation CustomView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSLog (@"%@=======awakeFromNib", [self class]);
    NSLog (@"self.titleLabel: %@", self.titleLabel);
}

- (instancetype)init {
    self = [super init];
    
    NSLog (@"%@=======init", [self class]);
    NSLog (@"self.titleLabel: %@", self.titleLabel);
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    NSLog (@"%@=======initWithCoder:", [self class]);
    NSLog (@"self.titleLabel: %@", self.titleLabel);
    
    return self;
}

@end


