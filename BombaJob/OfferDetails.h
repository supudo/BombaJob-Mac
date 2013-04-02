//
//  OfferDetails.h
//  BombaJob
//
//  Created by supudo on 3/26/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M3NavigationViewControllerProtocol.h"
#import "dbJobOffer.h"

@interface OfferDetails : NSViewController <M3NavigationViewControllerProtocol>

@property (strong) dbJobOffer *currentOffer;
@property (assign) IBOutlet NSTextField *txtCategory, *txtTitle, *txtDate;
@property (assign) IBOutlet NSTextField *txtPositivLabel, *txtPositiv, *txtNegativLabel, *txtNegativ;

- (void)didShow;
- (void)gotoOlderOffer;
- (void)gotoNewerOffer;

@end
