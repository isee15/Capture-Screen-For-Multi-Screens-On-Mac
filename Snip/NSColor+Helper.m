//
//  NSColor+Helper.m
//  Snip
//
//  Created by isee15 on 15/2/5.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "NSColor+Helper.h"

@implementation NSColor (Helper)

+ (NSColor *)colorFromInt:(int)colorValue
{
    float b = colorValue & 0xff;
    float g = (colorValue & 0xff00) >> 8;
    float r = (colorValue & 0xff0000) >> 16;
    return [NSColor colorWithRed:r / 255 green:g / 255 blue:b / 255 alpha:1];
}

+ (NSColor*)colorWithHex:(NSString *)hexValue alpha:(CGFloat)alphaValue
{
    NSScanner *scanner = [NSScanner scannerWithString:hexValue];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]){
        return [NSColor blackColor];
    }
    return [NSColor colorWithRed:((float)((hexNum & 0xFF0000) >> 16))/255.0
                           green:((float)((hexNum & 0xFF00) >> 8))/255.0
                            blue:((float)(hexNum & 0xFF))/255.0 alpha:alphaValue];
}
@end
