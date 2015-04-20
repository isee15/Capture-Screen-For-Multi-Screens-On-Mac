//
//  FlatView.m
//  Snip
//
//  Created by isee15 on 15/2/6.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "SimpleLabelView.h"

@implementation SimpleLabelView

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    NSBezierPath *bgPath = [NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:6 yRadius:6];
    [bgPath setClip];
    [[NSColor colorWithCalibratedWhite:0.0 alpha:0.8f] setFill];
    NSRectFill(self.bounds);
    if (self.text.length > 0) {
        NSDictionary *stringAttributes = @{NSForegroundColorAttributeName : [NSColor colorWithCalibratedWhite:1.0 alpha:1.0],
                NSFontAttributeName : [NSFont boldSystemFontOfSize:12.0]};
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.text attributes:stringAttributes];
        NSRect stringRect = [attrStr boundingRectWithSize:self.bounds.size options:(NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin)];

        [attrStr drawAtPoint:NSMakePoint((self.bounds.size.width - stringRect.size.width) / 2, (self.bounds.size.height - stringRect.size.height) / 2)];
    }
    // Drawing code here.
}

@end
