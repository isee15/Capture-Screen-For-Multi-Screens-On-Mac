//
//  DrawPathView.m
//  Snip
//
//  Created by isee15 on 15/2/5.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "DrawPathView.h"
#import "SnipUtil.h"

@implementation DrawPathView

- (instancetype)init
{
    if (self = [super init]) {
        _rectArray = [NSMutableArray array];
    }
    return self;
}

- (NSRect)rectFromScreen:(NSRect)rect
{
    NSRect rectRet = [self.window convertRectFromScreen:rect];
    rectRet.origin.x -= self.frame.origin.x;
    rectRet.origin.y -= self.frame.origin.y;
    return rectRet;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    if ([SnipManager sharedInstance].captureState == CAPTURE_STATE_EDIT) {
        [self drawCommentInRect:self.bounds];
        if (self.currentInfo) {
            [self drawShape:self.currentInfo inBackground:NO];
        }
    }
    // Drawing code here.
}

- (void)drawCommentInRect:(NSRect)imageRect
{
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:imageRect];
    [path addClip];
    [[NSColor redColor] set];
    for (DrawPathInfo *info in self.rectArray) {
        [self drawShape:info inBackground:NO];
    }
}

- (void)drawFinishCommentInRect:(NSRect)imageRect
{
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:imageRect];
    [path addClip];
    [[NSColor redColor] set];
    for (DrawPathInfo *info in self.rectArray) {
        [self drawShape:info inBackground:YES];
    }
}

- (void)drawShape:(DrawPathInfo *)info inBackground:(BOOL)bIn
{
    NSRect rect = NSMakeRect(info.startPoint.x, info.startPoint.y, info.endPoint.x - info.startPoint.x, info.endPoint.y - info.startPoint.y);
    if (bIn) {
        rect = [self.window convertRectFromScreen:rect];
    }
    else {
        rect = [self rectFromScreen:rect];
    }
    NSBezierPath *rectPath = [NSBezierPath bezierPath];
    [rectPath setLineWidth:4];
    [rectPath setLineCapStyle:NSRoundLineCapStyle];
    [rectPath setLineJoinStyle:NSRoundLineJoinStyle];
    switch (info.drawType) {
        case DRAW_TYPE_RECT:
            rect = [SnipUtil uniformRect:rect];
            if (rect.size.width * rect.size.width < 1e-2) return;
            [rectPath appendBezierPathWithRect:rect];
            [rectPath stroke];
            break;
        case DRAW_TYPE_ELLIPSE:
            rect = [SnipUtil uniformRect:rect];
            if (rect.size.width * rect.size.width < 1e-2) return;
            [rectPath appendBezierPathWithOvalInRect:rect];
            [rectPath stroke];
            break;
        case DRAW_TYPE_ARROW: {
            // arrow
            CGFloat x0 = rect.origin.x;
            CGFloat y0 = rect.origin.y;
            CGFloat x1 = x0 + rect.size.width;
            CGFloat y1 = y0 + rect.size.height;

            [rectPath moveToPoint:CGPointZero];
            CGFloat ex1 = sqrt((x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0));
            if (fabs(rect.size.width) < 5 && fabs(rect.size.height) < 5) return;
            [rectPath lineToPoint:NSMakePoint(ex1, 0)];
            [rectPath lineToPoint:NSMakePoint(ex1 - 8, 5)];
            [rectPath lineToPoint:NSMakePoint(ex1 - 2, 0)];
            [rectPath lineToPoint:NSMakePoint(ex1 - 8, -5)];
            [rectPath lineToPoint:NSMakePoint(ex1, 0)];
            [rectPath closePath];

            NSAffineTransform *af = [NSAffineTransform transform];
            [af translateXBy:x0 yBy:y0];
            [af rotateByRadians:atan2(y1 - y0, x1 - x0)];
            [rectPath transformUsingAffineTransform:af];
            [rectPath fill];
            [rectPath stroke];
        }
            break;
    }
}

@end
