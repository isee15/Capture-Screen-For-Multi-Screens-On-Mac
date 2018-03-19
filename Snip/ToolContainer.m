//
//  ToolContainer.m
//  Snip
//
//  Created by isee15 on 15/2/5.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "ToolContainer.h"
#import "SnipUtil.h"

@interface ToolContainer ()
@property ImageButton *rectButton;
@property ImageButton *ellipseButton;
@property ImageButton *arrowButton;
@property ImageButton *textButton;
@property ImageButton *penButton;
@property ImageButton *cancelButton;
@property ImageButton *okButton;

@property(nonatomic, copy) NSArray<ImageButton *> *tools;
@end

@implementation ToolContainer

- (instancetype)init
{
    if (self = [super init]) {
        _rectButton = [SnipUtil createButton:[NSImage imageNamed:@"ScreenCapture_toolbar_rect_ineffect"] withAlternate:nil];
        _rectButton.tag = ActionShapeRect;

        _ellipseButton = [SnipUtil createButton:[NSImage imageNamed:@"ScreenCapture_toolbar_ellipse_ineffect"] withAlternate:nil];
        _ellipseButton.tag = ActionShapeEllipse;

        _arrowButton = [SnipUtil createButton:[NSImage imageNamed:@"ScreenCapture_toolbar_arrow_ineffect"] withAlternate:nil];
        _arrowButton.tag = ActionShapeArrow;

        _textButton = [SnipUtil createButton:[NSImage imageNamed:@"ScreenCapture_toolbar_text_ineffect"] withAlternate:nil];
        _textButton.tag = ActionEditText;

        _penButton = [SnipUtil createButton:[NSImage imageNamed:@"ScreenCapture_toolbar_pen_ineffect"] withAlternate:nil];
        _penButton.tag = ActionEditPen;

        _cancelButton = [SnipUtil createButton:[NSImage imageNamed:@"ScreenCapture_toolbar_cross_normal"] withAlternate:nil];
        _cancelButton.tag = ActionCancel;

        _okButton = [SnipUtil createButton:[NSImage imageNamed:@"ScreenCapture_toolbar_tick_normal"] withAlternate:nil];
        _okButton.tag = ActionOK;

        _tools = @[_rectButton,_ellipseButton,_arrowButton,_penButton,_textButton,_cancelButton,_okButton];
        for (ImageButton *btn in _tools) {
            btn.target = self;
            btn.action = @selector(onToolClick:);
            [self addSubview:btn];
        }
    }
    return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    NSBezierPath *bgPath = [NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:3 yRadius:3];
    [bgPath setClip];
    [[NSColor colorWithCalibratedWhite:1.0 alpha:0.3f] setFill];
    NSRectFill(self.bounds);
    // Drawing code here.
}

- (void)setFrame:(NSRect)frame
{
    [super setFrame:frame];
    int step = 35;
    int margin = 10;
    int index = 0;
    for (ImageButton *btn in self.tools) {
        [btn setFrame:NSMakeRect(margin+step * (index++), 0, 28, 26)];
    }
}

- (void)onToolClick:(NSControl *)sender
{
    //need refactor
    self.rectButton.image = [NSImage imageNamed:@"ScreenCapture_toolbar_rect_ineffect"];
    self.ellipseButton.image = [NSImage imageNamed:@"ScreenCapture_toolbar_ellipse_ineffect"];
    self.arrowButton.image = [NSImage imageNamed:@"ScreenCapture_toolbar_arrow_ineffect"];
    self.textButton.image = [NSImage imageNamed:@"ScreenCapture_toolbar_text_ineffect"];
    self.penButton.image = [NSImage imageNamed:@"ScreenCapture_toolbar_pen_ineffect"];

    if (sender == self.rectButton) {
        self.rectButton.image = [NSImage imageNamed:@"ScreenCapture_toolbar_rect_effect"];
    }
    else if (sender == self.ellipseButton) {
        self.ellipseButton.image = [NSImage imageNamed:@"ScreenCapture_toolbar_ellipse_effect"];
    }
    else if (sender == self.arrowButton) {
        self.arrowButton.image = [NSImage imageNamed:@"ScreenCapture_toolbar_arrow_effect"];
    }
    else if (sender == self.textButton) {
        self.textButton.image = [NSImage imageNamed:@"ScreenCapture_toolbar_text_effect"];
    }
    else if (sender == self.penButton) {
        self.penButton.image = [NSImage imageNamed:@"ScreenCapture_toolbar_pen_effect"];
    }
    if (self.toolClick) {
        self.toolClick([sender tag]);
    }
}

- (void)mouseDown:(NSEvent *)theEvent
{
}

@end
