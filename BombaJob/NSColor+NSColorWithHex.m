//
//  NSColor+NSColorWithHex.m
//  BombaJob
//
//  Created by supudo on 3/22/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "NSColor+NSColorWithHex.h"

@implementation NSColor (NSColorWithHex)

// @"#123456"
+ (NSColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr + 1, NULL, 16);
    return [NSColor colorWithHex:(int)x];
}

// 0x123456
+ (NSColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [NSColor colorWithSRGBRed:(float)r / 255.0f green:(float)g / 255.0f blue:(float)b / 255.0f alpha:1];
}

@end
