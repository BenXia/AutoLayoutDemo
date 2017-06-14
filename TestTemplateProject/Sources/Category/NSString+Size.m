//
//  NSString+Size.m
//  TestTemplateProject
//
//  Created by Ben on 15/7/16.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textSize = [self sizeWithAttributes:attributes];
    } else {
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（译者注：字体大小+行间距=行高）
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
    }
    return CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
}

- (int)textLineNumWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGFloat realHeight = [self textSizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping].height;
    CGFloat oneLineHeight = [self textSizeForOneLineWithFont:font].height;
    return (int)ceilf(realHeight/oneLineHeight);
}

- (CGSize)textSizeForOneLineWithFont:(UIFont *)font {
    return [self textSizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
}

@end
