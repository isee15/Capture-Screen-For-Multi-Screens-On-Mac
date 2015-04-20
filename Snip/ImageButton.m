//
//  ImageButton.m
//  Snip
//
//  Created by isee15 on 15/2/5.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "ImageButton.h"

@implementation ImageButton

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];

    // Drawing code here.
}

- (void)mouseDown:(NSEvent *)theEvent
{
    [NSApp sendAction:self.action
                   to:self.target
                 from:self];
}

@end
