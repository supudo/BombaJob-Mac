//
//  OfferDetails.m
//  BombaJob
//
//  Created by supudo on 3/26/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "OfferDetails.h"
#import "oManagedDBContext.h"
#import "dbJobOffer.h"

@interface OfferDetails ()
@end

@implementation OfferDetails

@synthesize currentOffer;
@synthesize txtCategory, txtTitle, txtDate;
@synthesize txtPositivLabel, txtPositiv, txtNegativLabel, txtNegativ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didShow {
    [txtCategory setStringValue:currentOffer.categoryTitle];
    [txtTitle setStringValue:currentOffer.title];
    [txtPositiv setStringValue:currentOffer.positivism];
    [txtNegativ setStringValue:currentOffer.negativism];
    if ([self.currentOffer.humanYn boolValue]) {
        [txtPositivLabel setStringValue:NSLocalizedString(@"Offer_Human_Positiv", @"Offer_Human_Positiv")];
        [txtNegativLabel setStringValue:NSLocalizedString(@"Offer_Human_Negativ", @"Offer_Human_Negativ")];
    }
    else {
        [txtPositivLabel setStringValue:NSLocalizedString(@"Offer_Company_Positiv", @"Offer_Company_Positiv")];
        [txtNegativLabel setStringValue:NSLocalizedString(@"Offer_Company_Negativ", @"Offer_Company_Negativ")];
    }
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"bg"]];
    [df setDateFormat:@"HH:mm, dd MMM yyyy"];
    [txtDate setStringValue:[df stringFromDate:self.currentOffer.publishDate]];
}

- (void)gotoNewerOffer {
    [[oSettings sharedoSettings] LogThis:@"Toolbar Next offer..."];
    NSPredicate *pred;
    switch (((AppDelegate *)[NSApp delegate]).bmAppController.previousScreen) {
        case BMScreenJobs:
            pred = [NSPredicate predicateWithFormat:@"humanYn = 0 && offerID > %i", [self.currentOffer.offerID intValue]];
            break;
        case BMScreenPeople:
            pred = [NSPredicate predicateWithFormat:@"humanYn = 1 && offerID > %i", [self.currentOffer.offerID intValue]];
            break;
        default:
            pred = [NSPredicate predicateWithFormat:@"offerID > %i", [self.currentOffer.offerID intValue]];
            break;
    }
    dbJobOffer *ent = (dbJobOffer *)[[oManagedDBContext sharedoManagedDBContext] getNewerOffer:pred];
    if (ent != nil)
        [((AppDelegate *)[NSApp delegate]).bmAppController scrOfferDetails:ent.title inSection:2 withObject:ent];
}

- (void)gotoOlderOffer {
    [[oSettings sharedoSettings] LogThis:@"Toolbar Previous offer..."];
    NSPredicate *pred;
    switch (((AppDelegate *)[NSApp delegate]).bmAppController.previousScreen) {
        case BMScreenJobs:
            pred = [NSPredicate predicateWithFormat:@"humanYn = 0 && offerID < %i", [self.currentOffer.offerID intValue]];
            break;
        case BMScreenPeople:
            pred = [NSPredicate predicateWithFormat:@"humanYn = 1 && offerID < %i", [self.currentOffer.offerID intValue]];
            break;
        default:
            pred = [NSPredicate predicateWithFormat:@"offerID < %i", [self.currentOffer.offerID intValue]];
            break;
    }
    dbJobOffer *ent = (dbJobOffer *)[[oManagedDBContext sharedoManagedDBContext] getOlderOffer:pred];
    if (ent != nil)
        [((AppDelegate *)[NSApp delegate]).bmAppController scrOfferDetails:ent.title inSection:2 withObject:ent];
}

@end
