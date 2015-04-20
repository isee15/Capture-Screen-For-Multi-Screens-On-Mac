//
//  SnipView.m
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "SnipView.h"
#import "NSColor+Helper.h"
#import "SimpleLabelView.h"

const int kDRAG_POINT_NUM = 8;
const int kDRAG_POINT_LEN = 5;

@interface SnipView ()
@property SimpleLabelView *tipView;

@end

@implementation SnipView


- (instancetype)initWithCoder:(NSCoder *)coder
{

    if (self = [super initWithCoder:coder]) {
        //_rectArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)setupTrackingArea:(NSRect)rect
{
    self.trackingArea = [[NSTrackingArea alloc] initWithRect:rect options:NSTrackingMouseMoved | NSTrackingActiveAlways owner:self userInfo:nil];
    NSLog(@"track init:%@", NSStringFromRect(self.frame));
    [self addTrackingArea:self.trackingArea];
}

- (void)setupTool
{
    self.toolContainer = [[ToolContainer alloc] init];
    [self addSubview:self.toolContainer];
    [self hideToolkit];

    self.tipView = [[SimpleLabelView alloc] init];
    [self addSubview:self.tipView];
    [self hideTip];
}

- (void)setupDrawPath
{
    if (self.pathView != nil) return;
    NSLog(@"setupDrawPath");
    self.pathView = [[DrawPathView alloc] init];
    [self addSubview:self.pathView];
    NSRect imageRect = NSIntersectionRect(self.drawingRect, self.bounds);
    [self.pathView setFrame:imageRect];
    [self.pathView setHidden:NO];
}

- (void)showToolkit
{
    NSLog(@"show toolkit:%@",self);
    NSRect imageRect = NSIntersectionRect(self.drawingRect, self.bounds);
    double y = imageRect.origin.y - 28;
    double x = imageRect.origin.x + imageRect.size.width;
    if (y < 0) y = 0;
    int margin = 10;
    int toolWidth = 35 * 5 + margin * 2 - (35-28);
    if (x < toolWidth) x = toolWidth;
    if (!NSEqualRects(self.toolContainer.frame,NSMakeRect(x - toolWidth, y, toolWidth, 26))) {
        [self.toolContainer setFrame:NSMakeRect(x - toolWidth, y, toolWidth, 26)];
    }
    if (self.toolContainer.isHidden) {
        [self.toolContainer setHidden:NO];
    }
}

- (void)hideToolkit
{
    [self.toolContainer setHidden:YES];
}

//- (void)mouseMoved:(NSEvent *)theEvent
//{
//    [super mouseMoved:theEvent];
//    NSLog(@"snipview track mouse moved:%@",self);
//    
//}
- (void)showTip
{
    NSPoint mouseLocation = [NSEvent mouseLocation];
    NSRect frame = self.window.frame;
    if (mouseLocation.x > frame.origin.x + frame.size.width - 100) {
        mouseLocation.x -= 100;
    }
    if (mouseLocation.x < frame.origin.x) {
        mouseLocation.x = frame.origin.x;
    }
    if (mouseLocation.y > frame.origin.y + frame.size.height - 26) {
        mouseLocation.y -= 26;
    }
    if (mouseLocation.y < frame.origin.y) {
        mouseLocation.y = frame.origin.y;
    }
    
    NSRect rect = NSMakeRect(mouseLocation.x, mouseLocation.y, 100, 25);
    NSRect imageRect = NSIntersectionRect(self.drawingRect, self.bounds);
    self.tipView.text = [NSString stringWithFormat:@"%dX%d", (int) imageRect.size.width, (int) imageRect.size.height];
    [self.tipView setFrame:[self.window convertRectFromScreen:rect]];
    [self.tipView setHidden:NO];
}

- (void)hideTip
{
    [self.tipView setHidden:YES];
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent
{
    return YES;
}

- (NSRect)pointRect:(int)index inRect:(NSRect)rect
{
    double x = 0, y = 0;
    switch (index) {
        case 0:
            x = NSMinX(rect);
            y = NSMaxY(rect);
            break;
        case 1:
            x = NSMidX(rect);
            y = NSMaxY(rect);
            break;
        case 2:
            x = NSMaxX(rect);
            y = NSMaxY(rect);
            break;
        case 3:
            x = NSMinX(rect);
            y = NSMidY(rect);
            break;
        case 4:
            x = NSMaxX(rect);
            y = NSMidY(rect);
            break;
        case 5:
            x = NSMinX(rect);
            y = NSMinY(rect);
            break;
        case 6:
            x = NSMidX(rect);
            y = NSMinY(rect);
            break;
        case 7:
            x = NSMaxX(rect);
            y = NSMinY(rect);
            break;

        default:
            break;
    }
    return NSMakeRect(x - kDRAG_POINT_LEN, y - kDRAG_POINT_LEN, kDRAG_POINT_LEN * 2, kDRAG_POINT_LEN * 2);
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSDisableScreenUpdates();
    [super drawRect:dirtyRect];
    /*if (self.window.screen)
    {
        [[NSColor whiteColor] set];
        for (NSDictionary *dir in [SnipManager sharedInstance].arrayRect) {
            CGRect windowRect;
            CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef) dir[(id) kCGWindowBounds], &windowRect);
            NSRect rect = [SnipUtil cgWindowRectToWindowRect:windowRect inScreen:self.window.screen];
            NSBezierPath *rectPath = [NSBezierPath bezierPath];
            [rectPath setLineWidth:0.5];
            [rectPath appendBezierPathWithRect:rect];
            [rectPath stroke];
        }
    }*/

    if (self.image) {
        NSRect imageRect = NSIntersectionRect(self.drawingRect, self.bounds);
        [self.image drawInRect:imageRect fromRect:imageRect operation:NSCompositeSourceOver fraction:1.0];
        [[NSColor colorFromInt:kBORDER_LINE_COLOR] set];
        NSBezierPath *rectPath = [NSBezierPath bezierPath];
        [rectPath setLineWidth:kBORDER_LINE_WIDTH];
        [rectPath removeAllPoints];
        [rectPath appendBezierPathWithRect:imageRect];
        [rectPath stroke];
        if ([SnipManager sharedInstance].captureState == CAPTURE_STATE_ADJUST) {
            [[NSColor whiteColor] set];
            for (int i = 0; i < kDRAG_POINT_NUM; i++) {
                NSBezierPath *adjustPath = [NSBezierPath bezierPath];
                [adjustPath removeAllPoints];
                [adjustPath appendBezierPathWithOvalInRect:[self pointRect:i inRect:imageRect]];
                [adjustPath fill];
            }
        }
//        else if ([SnipManager sharedInstance].captureState == CAPTURE_STATE_EDIT) {
//            [self drawCommentInRect:imageRect];
//            if (self.currentInfo) {
//                NSRect rect = NSMakeRect(self.currentInfo.startPoint.x, self.currentInfo.startPoint.y, self.currentInfo.endPoint.x-self.currentInfo.startPoint.x, self.currentInfo.endPoint.y-self.currentInfo.startPoint.y);
//                rect = [SnipUtil uniformRect:rect];
//                rect = [self.window convertRectFromScreen:rect];
//                NSBezierPath *rectPath = [NSBezierPath bezierPath];
//                [rectPath setLineWidth:1.5];
//                [rectPath appendBezierPathWithRect:rect];
//                [rectPath stroke];
//            }
//        }
    }
    if (self.toolContainer != nil && !self.toolContainer.isHidden) {
        [self showToolkit];
    }
    // Drawing code here.
    NSEnableScreenUpdates();
}

@end
