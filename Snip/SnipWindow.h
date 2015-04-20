//
//  SnipWindow.h
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MouseEventProtocol.h"

@interface SnipWindow : NSPanel

@property(weak) id <MouseEventProtocol> mouseDelegate;
@end
