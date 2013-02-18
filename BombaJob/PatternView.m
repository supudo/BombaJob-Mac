//
//  PatternView.m
//  BombaJob
//
//  Created by supudo on 2/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "PatternView.h"

@implementation PatternView

@synthesize backgroundImage;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    if (self.backgroundImage != nil) {
        NSSize size = [self bounds].size;
        NSImage *bigImage = [[NSImage alloc] initWithSize:size];
        [bigImage lockFocus];
        
        NSColor *backgroundColor = [NSColor colorWithPatternImage:self.backgroundImage];
        [backgroundColor set];
        NSRectFill([self bounds]);
        
        [bigImage unlockFocus];
        [bigImage drawInRect:[self bounds] fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0f];
    }
}

@end
