//
//  OfferCell.h
//  BombaJob
//
//  Created by supudo on 3/21/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "dbJobOffer.h"

@interface OfferCell : NSTextFieldCell {
@private
    dbJobOffer *jobOffer;
}

@property (readwrite, retain) dbJobOffer *jobOffer;

@end
