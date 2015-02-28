//
//  DrawPathView.h
//  Snip
//
//  Created by isee15 on 15/2/5.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DrawPathInfo.h"

@interface DrawPathView : NSView
@property NSMutableArray *rectArray;
@property DrawPathInfo *currentInfo;

- (void)drawFinishCommentInRect:(NSRect)imageRect;
@end
