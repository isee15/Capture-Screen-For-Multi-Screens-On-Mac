//
//  SnipManager.m
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "SnipManager.h"
#import "SnipWindowController.h"
#import "SnipView.h"
#import "SnipWindow.h"

const double kBORDER_LINE_WIDTH = 2.0;
const int kBORDER_LINE_COLOR = 0x1191FE;
const int kKEY_ESC_CODE = 53;

@interface SnipManager ()

@end

@implementation SnipManager

+ (instancetype)sharedInstance
{
    static SnipManager *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void) {
        sharedSingleton = [[self alloc] init];
        sharedSingleton.windowControllerArray = [NSMutableArray array];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:sharedSingleton
                                                               selector:@selector(screenChanged:)
                                                                   name:NSWorkspaceActiveSpaceDidChangeNotification
                                                                 object:[NSWorkspace sharedWorkspace]];
        [[NSNotificationCenter defaultCenter] addObserver:sharedSingleton selector:@selector(screenChanged:) name:NSApplicationDidChangeScreenParametersNotification object:nil];
    });
    return sharedSingleton;
}

- (void)dealloc
{
    NSLog(@"manager dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
}

- (void)screenChanged:(NSNotification *)notify
{
    NSLog(@"--space changed--%@", notify.userInfo);
    if (self.isWorking) {
        [self endCapture:nil];
    }
}

- (void)clearController
{
    if (_windowControllerArray) {
        [_windowControllerArray removeAllObjects];
    }
}

- (void)startCapture
{
    if (self.isWorking) return;
    self.isWorking = YES;
    self.arrayRect = [NSMutableArray array];
    //CFArrayRef windowArray = CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly, kCGNullWindowID);
    NSArray *windows = (__bridge NSArray *) CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly, kCGNullWindowID);
    NSUInteger count = [windows count];
    for (NSUInteger i = 0; i < count; i++) {
        NSDictionary *windowDescriptionDictionary = windows[i];
//        CGRect bounds;
//        CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef) windowDescriptionDictionary[(id) kCGWindowBounds], &bounds);
        //NSLog(@"------%@",NSStringFromRect(bounds));
        [self.arrayRect addObject:windowDescriptionDictionary];
    }
    //CFRelease(windowArray);

    for (NSScreen *screen in [NSScreen screens]) {
//        SnipWindowController *snipController = [[SnipWindowController alloc] initWithWindowNibName:@"SnipWindowController"];
        SnipWindowController *snipController = [[SnipWindowController alloc] init];
        SnipWindow *snipWindow = [[SnipWindow alloc] initWithContentRect:[screen frame] styleMask:NSNonactivatingPanelMask backing:NSBackingStoreBuffered defer:NO screen:screen];
        snipController.window = snipWindow;
        SnipView *snipView = [[SnipView alloc] initWithFrame:NSMakeRect(0, 0, [screen frame].size.width, [screen frame].size.height)];
        snipWindow.contentView = snipView;
        [self.windowControllerArray addObject:snipController];
        self.captureState = CAPTURE_STATE_HILIGHT;
        [snipController startCaptureWithScreen:screen];
    }
}

- (void)endCapture:(NSImage *)image
{
    if (!self.isWorking) return;
    self.isWorking = NO;
    for (SnipWindowController *windowController in self.windowControllerArray) {
        [windowController.window orderOut:nil];
    }
    [self clearController];
    NSLog(@"post endcapture:%@", kNotifyCaptureEnd);
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyCaptureEnd object:nil userInfo:image == nil ? nil : @{@"image" : image}];
}
@end
