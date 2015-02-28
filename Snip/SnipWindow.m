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

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
    // Using NSBorderlessWindowMask results in a window without a title bar.
    if (self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO]) {
        [self setAcceptsMouseMovedEvents:YES];
    }
    return self;
}

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag screen:(NSScreen *)screen {
    if (self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO screen:screen]) {
        [self setAcceptsMouseMovedEvents:YES];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"snip window dealloc");
}

- (void)mouseMoved:(NSEvent *)theEvent {
    [self.mouseDelegate mouseMoved:theEvent];

}

- (BOOL)canBecomeKeyWindow {
    return YES;
}

- (BOOL)canBecomeMainWindow {
    return YES;
}

- (void)mouseDown:(NSEvent *)theEvent {
    [self.mouseDelegate mouseDown:theEvent];
}

- (void)mouseUp:(NSEvent *)theEvent {
    [self.mouseDelegate mouseUp:theEvent];
}

- (void)mouseDragged:(NSEvent *)theEvent {

    [self.mouseDelegate mouseDragged:theEvent];

}

- (void)keyDown:(NSEvent *)event {
    if ([event keyCode] == kKEY_ESC_CODE) {
        NSLog(@"Escape has been pressed");
        [self orderOut:nil];
        [[SnipManager sharedInstance] endCapture:nil];
        return;
    }
    [super keyDown:event];
}

@end
