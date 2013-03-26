//
//  OfferCell.m
//  BombaJob
//
//  Created by supudo on 3/21/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "OfferCell.h"
#import "NSColor+NSColorWithHex.h"

#define BORDER_SIZE 8
#define ICON_SIZE_WIDTH 35
#define ICON_SIZE_HEIGHT 21

@implementation OfferCell

@synthesize jobOffer;

- (id)copyWithZone:(NSZone *)zone {
    OfferCell *cell = [super copyWithZone:zone];
    if (cell == nil)
        return nil;

    cell->jobOffer = nil;
    [cell setJobOffer:self.jobOffer];
    
    return cell;
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    self.title = jobOffer.title;

    NSRect iconRect = [self iconRectForBounds:cellFrame];
    NSImage *imgIcon = (NSImage *)jobOffer.offerIcon;
    [imgIcon drawInRect:iconRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];

    NSRect titleRect = [self titleRectForBounds:cellFrame];
    NSAttributedString *aTitle = [self attributedStringValue];
    if ([aTitle length] > 0)
        [aTitle drawInRect:titleRect];
    
    NSRect subtitleRect = [self subtitleRectForBounds:cellFrame forTitleBounds:titleRect];
    NSAttributedString *aSubtitle = [self attributedSubtitleValue];
    if ([aSubtitle length] > 0)
        [aSubtitle drawInRect:subtitleRect];
}

- (NSRect)iconRectForBounds:(NSRect)bounds {
    NSRect iconRect = bounds;
    iconRect.origin.x += BORDER_SIZE;
    iconRect.origin.y += BORDER_SIZE;
    iconRect.size.width = ICON_SIZE_WIDTH;
    iconRect.size.height = ICON_SIZE_HEIGHT;
    return iconRect;
}

- (NSRect)titleRectForBounds:(NSRect)bounds {
    NSRect titleRect = bounds;

    titleRect.origin.x += ICON_SIZE_WIDTH + (BORDER_SIZE * 2);
    titleRect.origin.y += BORDER_SIZE;
    
    NSAttributedString *title = [self attributedStringValue];
    if (title)
        titleRect.size = [title size];
    else
        titleRect.size = NSZeroSize;
    
    CGFloat maxX = NSMaxX(bounds);
    CGFloat maxWidth = maxX - NSMinX(titleRect);
    if (maxWidth < 0)
        maxWidth = 0;
    
    titleRect.size.width = MIN(NSWidth(titleRect), maxWidth);
    
    return titleRect;
}

- (NSRect)subtitleRectForBounds:(NSRect)bounds forTitleBounds:(NSRect)titleBounds {
    NSRect subtitleRect = bounds;
    
    subtitleRect.origin.x = NSMinX(titleBounds);
    subtitleRect.origin.y = NSMaxY(titleBounds) + BORDER_SIZE;
    
    CGFloat amountPast = NSMaxX(subtitleRect) - NSMaxX(bounds);
    if (amountPast > 0)
        subtitleRect.size.width -= amountPast;
    
    return subtitleRect;
}

- (NSAttributedString *)attributedSubtitleValue {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:[oSettings sharedoSettings].dateFormatList];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"bg-BG"]];
    NSString *publishDate = [df stringFromDate:jobOffer.publishDate];
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[oSettings sharedoSettings].orangeColor, NSForegroundColorAttributeName, nil];
    return [[NSAttributedString alloc] initWithString:publishDate attributes:attrs];
}

@end
