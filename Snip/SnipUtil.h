//
//  SnipUtil.h
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "ImageButton.h"

@interface SnipUtil : NSObject
+ (CGImageRef)screenShot:(NSScreen *)screen;

+ (BOOL)isPoint:(NSPoint)point inRect:(NSRect)rect;

+ (double)pointDistance:(NSPoint)p1 toPoint:(NSPoint)p2;

+ (NSRect)uniformRect:(NSRect)rect;

+ (NSRect)rectToZero:(NSRect)rect;

+ (NSRect)cgWindowRectToScreenRect:(CGRect)windowRect;

+ (ImageButton *)createButton:(NSImage *)image withAlternate:(NSImage *)alter;
@end
