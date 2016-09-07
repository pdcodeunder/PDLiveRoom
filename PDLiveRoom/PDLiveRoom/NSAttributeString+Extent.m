//
//  NSAttributeString+Extent.m
//  PDLiveRoom
//
//  Created by 彭懂 on 16/9/6.
//  Copyright © 2016年 彭懂. All rights reserved.
//

#import "NSAttributeString+Extent.h"

@implementation NSAttributedString (NSAttributeString_Extent)

+ (NSAttributedString *)attributedStringWithStr:(NSString *)string anotherString:(NSString *)anotherStr andColor:(UIColor *)color
{
    NSString *Str = [NSString stringWithFormat:@"%@  %@", string, anotherStr];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:Str];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, Str.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, string.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(Str.length - anotherStr.length, anotherStr.length)];
    return attributedStr;
}

@end
