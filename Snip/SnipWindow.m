//
//  SnipWindow.m
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "SnipWindow.h"
#import "SnipManager.h"

@interface SnipWindow ()
@end

@implementation SnipWindow

//- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
//{
//    // Using NSBorderlessWindowMask results in a window without a title bar.
//    if (self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO]) {
//        [self setAcceptsMouseMovedEvents:YES];
//        self.movable = NO;
//        self.movableByWindowBackground = NO;
//    }
//    return self;
//}

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag screen:(NSScreen *)screen
{
    if (self = [super initWithContentRect:contentRect styleMask:aStyle backing:NSBackingStoreBuffered defer:NO screen:screen]) {
        [self setAcceptsMouseMovedEvents:YES];
        [self setFloatingPanel:YES];
        [self setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces | NSWindowCollectionBehaviorFullScreenAuxiliary];
        [self setMovableByWindowBackground:NO];
        [self setExcludedFromWindowsMenu:YES];
        [self setAlphaValue:1.0];
        [self setOpaque:NO];
        [self setHasShadow:NO];
        [self setHidesOnDeactivate:NO];
        [self setLevel:kCGMaximumWindowLevel];
        [self setRestorable:NO];
        [self disableSnapshotRestoration];
        [self setLevel:kCGMaximumWindowLevel];

        self.movable = NO;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"snip window dealloc");
}

- (void)mouseMoved:(NSEvent *)theEvent
{
    //[super mouseMoved:theEvent];
    [self.mouseDelegate mouseMoved:theEvent];

}

- (BOOL)canBecomeKeyWindow
{
    return YES;
}

- (BOOL)canBecomeMainWindow
{
    return YES;
}

- (void)mouseDown:(NSEvent *)theEvent
{
    //[super mouseDown:theEvent];
    [self.mouseDelegate mouseDown:theEvent];
}

- (void)mouseUp:(NSEvent *)theEvent
{
    //[super mouseUp:theEvent];
    [self.mouseDelegate mouseUp:theEvent];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    //[super mouseDragged:theEvent];
    [self.mouseDelegate mouseDragged:theEvent];

}

- (void)keyDown:(NSEvent *)event
{
    if ([event keyCode] == kKEY_ESC_CODE) {
        NSLog(@"Escape has been pressed");
        [self orderOut:nil];
        [[SnipManager sharedInstance] endCapture:nil];
        return;
    }
    [super keyDown:event];
}

@end
