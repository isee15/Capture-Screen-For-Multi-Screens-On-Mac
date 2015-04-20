//
//  SnipUtil.m
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "SnipUtil.h"

@implementation SnipUtil
+ (CGImageRef)screenShot:(NSScreen *)screen
{
    CFArrayRef windowsRef = CGWindowListCreate(kCGWindowListOptionOnScreenOnly, kCGNullWindowID);

    NSRect rect = [screen frame];
    NSRect mainRect = [NSScreen mainScreen].frame;
    for (NSScreen *subScreen in [NSScreen screens]) {
        if ((int) subScreen.frame.origin.x == 0 && (int) subScreen.frame.origin.y == 0) {
            mainRect = subScreen.frame;
        }
    }
    rect = NSMakeRect(rect.origin.x, (mainRect.size.height) - (rect.origin.y + rect.size.height), rect.size.width, rect.size.height);

    NSLog(@"screenShot: %@", NSStringFromRect(rect));
    CGImageRef imgRef = CGWindowListCreateImageFromArray(rect, windowsRef, kCGWindowImageDefault);
    CFRelease(windowsRef);

    return imgRef;
}

+ (BOOL)isPoint:(NSPoint)point inRect:(NSRect)rect
{
    //if (NSPointInRect(point, rect))
    //NSLog(@"point:%@ in rect:%@",NSStringFromPoint(point),NSStringFromRect(rect));
    return NSPointInRect(point, rect);
}

+ (double)pointDistance:(NSPoint)p1 toPoint:(NSPoint)p2
{
    return (p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y);
}

+ (NSRect)uniformRect:(NSRect)rect
{
    double x = rect.origin.x;
    double y = rect.origin.y;
    double w = rect.size.width;
    double h = rect.size.height;
    if (w < 0) {
        x += w;
        w = -w;
    }
    if (h < 0) {
        y += h;
        h = -h;
    }
    return NSMakeRect(x, y, w, h);
}

+ (NSRect)rectToZero:(NSRect)rect
{
    return NSOffsetRect(rect, -rect.origin.x, -rect.origin.y);
}

+ (NSRect)cgWindowRectToScreenRect:(CGRect)windowRect
{
    NSRect mainRect = [NSScreen mainScreen].frame;
    //NSRect snipRect = screen.frame;
    for (NSScreen *screen in [NSScreen screens]) {
        if ((int) screen.frame.origin.x == 0 && (int) screen.frame.origin.y == 0) {
            mainRect = screen.frame;
        }
    }
    NSRect rect = NSMakeRect(windowRect.origin.x, mainRect.size.height - windowRect.size.height - windowRect.origin.y, windowRect.size.width, windowRect.size.height);
    return rect;
}

+ (ImageButton *)createButton:(NSImage *)image withAlternate:(NSImage *)alter
{
    ImageButton *button = [[ImageButton alloc] init];
    //button.bordered = NO;
    //button.bezelStyle = NSShadowlessSquareBezelStyle;
    [button setImage:image];
    //[button setAlternateImage:alter];
    return button;
}

@end
