//
//  MouseEventProtocol.h
//  Snip
//
//  Created by isee15 on 15/2/5.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MouseEventProtocol <NSObject>

- (void)mouseDown:(NSEvent *)theEvent;

- (void)mouseUp:(NSEvent *)theEvent;

- (void)mouseDragged:(NSEvent *)theEvent;

- (void)mouseMoved:(NSEvent *)theEvent;
@end
