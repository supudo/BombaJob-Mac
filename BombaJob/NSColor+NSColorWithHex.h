//
//  NSColor+NSColorWithHex.h
//  BombaJob
//
//  Created by supudo on 3/22/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (NSColorWithHex)

+ (NSColor *)colorWithHex:(UInt32)col;
+ (NSColor *)colorWithHexString:(NSString *)str;

@end
