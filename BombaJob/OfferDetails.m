//
//  OfferDetails.m
//  BombaJob
//
//  Created by supudo on 3/26/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "OfferDetails.h"

@interface OfferDetails ()

@end

@implementation OfferDetails

@synthesize txtTitle, currentOffer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didShow {
    [txtTitle setStringValue:currentOffer.title];
}

@end
