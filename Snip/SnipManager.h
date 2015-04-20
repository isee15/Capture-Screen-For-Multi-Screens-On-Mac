//
//  SnipManager.h
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, CAPTURE_STATE)
{
    CAPTURE_STATE_IDLE,
    CAPTURE_STATE_HILIGHT,
    CAPTURE_STATE_FIRSTMOUSEDOWN,
    CAPTURE_STATE_READYADJUST,
    CAPTURE_STATE_ADJUST,
    CAPTURE_STATE_EDIT,
    CAPTURE_STATE_DONE,
};

typedef NS_ENUM(int, DRAW_TYPE)
{
    DRAW_TYPE_RECT,
    DRAW_TYPE_ELLIPSE,
    DRAW_TYPE_ARROW
};

#define kNotifyCaptureEnd @"kNotifyCaptureEnd"
#define kNotifyMouseLocationChange @"kNotifyMouseLocationChange"
extern const double kBORDER_LINE_WIDTH;
extern const int kBORDER_LINE_COLOR;
extern const int kKEY_ESC_CODE;


@interface SnipManager : NSObject

@property NSMutableArray *windowControllerArray;

@property NSMutableArray *arrayRect;

@property CAPTURE_STATE captureState;

@property DRAW_TYPE drawType;

@property BOOL isWorking;

+ (instancetype)sharedInstance;

- (void)endCapture:(NSImage *)image;

- (void)startCapture;
@end
