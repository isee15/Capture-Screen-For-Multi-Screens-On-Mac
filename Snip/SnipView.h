//
//  SnipView.h
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DrawPathInfo.h"
#import "ToolContainer.h"
#import "DrawPathView.h"

@interface SnipView : NSView
@property NSImage *image;
@property NSRect drawingRect;
@property DrawPathView *pathView;

@property(nonatomic, strong) NSTrackingArea *trackingArea;
//@property NSMutableArray *rectArray;
//@property DrawPathInfo *currentInfo;
@property ToolContainer *toolContainer;

- (void)setupTrackingArea:(NSRect)rect;

- (void)setupTool;

- (void)setupDrawPath;

- (void)showToolkit;

- (void)hideToolkit;

- (void)showTip;

- (void)hideTip;

@end
