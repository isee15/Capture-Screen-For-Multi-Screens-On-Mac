//
//  NSColor+Helper.h
//  Snip
//
//  Created by isee15 on 15/2/5.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (Helper)
+ (NSColor *)colorFromInt:(int)colorValue;
+ (NSColor*)colorWithHex:(NSString *)hexValue alpha:(CGFloat)alphaValue;
@end
