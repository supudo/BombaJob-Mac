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
	
	CGFloat detailLeft = nameFrame.origin.x + nameFrame.size.width + 5.0f;
	CGFloat detailBottom = nameFrame.origin.y + nameFrame.size.height - 18.0f;
	CGFloat detailWidth = self.bounds.size.width - detailLeft - 2.0f;
	CGFloat detailHeight = 16.0f;
	NSRect detailFrame = NSMakeRect(detailLeft, detailBottom, detailWidth, detailHeight);
	
    [[self.detailTextField animator] setAlphaValue:1];
    [[self.imageView animator] setFrame:iconFrame];
    [[self.textField animator] setFrame:nameFrame];
    [[self.detailTextField animator] setFrame:detailFrame];
}

@end
