//
//  TestLayoutSubviewCustomView.m
//  TestTemplateProject
//
//  Created by Ben on 2020/12/4.
//  Copyright © 2020 iOSStudio. All rights reserved.
//

#import "TestLayoutSubviewCustomView.h"

@implementation TestLayoutSubviewCustomView

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect currentFrame = self.frame;
    self.frame = CGRectMake(currentFrame.origin.x, currentFrame.origin.y, currentFrame.size.width + 1, currentFrame.size.height + 1);
    
//    [self setNeedsLayout];
}

@end


