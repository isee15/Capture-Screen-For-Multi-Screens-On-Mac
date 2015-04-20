//
//  DrawPathInfo.m
//  Snip
//
//  Created by isee15 on 15/2/4.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "DrawPathInfo.h"

@implementation DrawPathInfo

- (instancetype)initWith:(NSPoint)startPoint andEndPoint:(NSPoint)endPoint andType:(DRAW_TYPE)drawType
{
    if (self = [super init]) {
        _startPoint = startPoint;
        _endPoint = endPoint;
        _drawType = drawType;
    }
    return self;
}
@end
