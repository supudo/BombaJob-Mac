//
//  OfferCell2.m
//  BombaJob
//
//  Created by supudo on 3/25/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "OfferCell2.h"

@implementation OfferCell2

- (void)setObjectValue:(id)objectValue {
	[super setObjectValue:objectValue];
	[self layoutViews];
}

- (void)setBackgroundStyle:(NSBackgroundStyle)backgroundStyle {
	NSColor *textColor = (backgroundStyle == NSBackgroundStyleDark) ? [NSColor windowBackgroundColor] : [NSColor controlShadowColor];
	self.detailTextField.textColor = textColor;
	[super setBackgroundStyle:backgroundStyle];
}

- (void)layoutViews {
	CGFloat iconSize = 31.0f;
	NSRect iconFrame = NSMakeRect(2.0f, 2.0f, iconSize, iconSize);
	
	CGFloat nameLeft = iconFrame.origin.x + iconFrame.size.width + 5.0f;
	CGFloat nameBottom = iconFrame.origin.y + iconFrame.size.height - 18.0f;
	CGFloat nameWidth = self.bounds.size.width - nameLeft - 2.0f;
	CGFloat nameHeight = 16.0f;
	NSRect nameFrame = NSMakeRect(nameLeft, nameBottom, nameWidth, nameHeight);
	
	CGFloat detailLeft = nameLeft;
	CGFloat detailBottom = nameFrame.origin.y + nameFrame.size.height + 10.0f;
	CGFloat detailWidth = nameWidth;
	CGFloat detailHeight = nameHeight;
	NSRect detailFrame = NSMakeRect(detailLeft, detailBottom, detailWidth, detailHeight);
    
    NSLog(@"CELL ((%1.2f x %1.2f)) = (%1.2f x %1.2f) (%1.2f x %1.2f) - (%1.2f x %1.2f) (%1.2f x %1.2f)",
          self.bounds.size.width, self.bounds.size.height,
          nameLeft, nameBottom, nameWidth, nameHeight,
          detailLeft, detailBottom, detailWidth, detailHeight);

    [[self.imageView animator] setFrame:iconFrame];
    [[self.textField animator] setFrame:nameFrame];
    [[self.detailTextField animator] setFrame:detailFrame];
}

@end
