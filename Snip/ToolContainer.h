//
//  ToolContainer.h
//  Snip
//
//  Created by isee15 on 15/2/5.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, ActionType)
{
    ActionCancel,
    ActionOK,
    ActionShapeRect,
    ActionShapeEllipse,
    ActionShapeArrow
};

@interface ToolContainer : NSView
@property(nonatomic, copy) void (^toolClick)(long index);
@end
