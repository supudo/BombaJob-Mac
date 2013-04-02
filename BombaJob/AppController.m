//
//  AppController.m
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "AppController.h"
#import "OffersList.h"
#import "Settings.h"
#import "SearchResults.h"
#import "OfferDetails.h"

@interface AppController ()
@property (strong) id passedObject;
@property BOOL inOfferDetails;

- (void)changeViewController:(BMScreen)tag;
- (void)push:(NSViewController<M3NavigationViewControllerProtocol> *)cont;
- (void)pop;
@end

@implementation AppController

@synthesize bmToolbar = _bmToolbar;
@synthesize holderView = _holderView;
@synthesize bmViewController = _bmViewController;
@synthesize bmPathbar;
@synthesize passedObject;

#pragma mark -
#pragma mark Pop & Push

- (void)popFromOfferDetails {
    [self.bmPathbar removeLastItem];
    [self pop];
}

- (void)push:(NSViewController<M3NavigationViewControllerProtocol> *)cont {
	[self.holderView pushViewController:cont];
}

- (void)pop {
	[self.holderView popViewController];
}

#pragma mark -
#pragma mark Prev & Next offers

- (void)gotoOlderOffer {
    if (self.inOfferDetails && [self.bmViewController respondsToSelector:@selector(gotoOlderOffer)])
        [self.bmViewController performSelector:@selector(gotoOlderOffer)];
}

- (void)gotoNewerOffer {
    if (self.inOfferDetails && [self.bmViewController respondsToSelector:@selector(gotoNewerOffer)])
        [self.bmViewController performSelector:@selector(gotoNewerOffer)];
}

#pragma mark -
#pragma mark IBO

- (IBAction)iboNewest:(id)sender {
    [self.bmPathbar addNewestOffers];
    [self.bmToolbar.toolbar setSelectedItemIdentifier:@"Newest"];
    [self changeViewController:BMScreenNewest];
}

- (IBAction)iboJobs:(id)sender {
    [self.bmPathbar addJobs];
    [self.bmToolbar.toolbar setSelectedItemIdentifier:@"Jobs"];
    [self changeViewController:BMScreenJobs];
}

- (IBAction)iboPeople:(id)sender {
    [self.bmPathbar addPeople];
    [self.bmToolbar.toolbar setSelectedItemIdentifier:@"People"];
    [self changeViewController:BMScreenPeople];
}

- (IBAction)iboSettings:(id)sender {
    [self.bmPathbar addSettings];
    [self.bmToolbar.toolbar setSelectedItemIdentifier:@"Settings"];
    [self changeViewController:BMScreenSettings];
}

- (IBAction)iboSearch:(id)sender {
    NSSearchField *sf = (NSSearchField *)sender;
    NSString *searchQuery = sf.stringValue;
    [sf setStringValue:@""];
    if (![searchQuery isEqualTo:@""]) {
        [[oSettings sharedoSettings] LogThis:@"Toolbar Search ..."];
        [oSettings sharedoSettings].lastSearchQuery = searchQuery;
        [self changeViewController:BMScreenSearchResults];
    }
}

- (void)scrOfferDetails:(NSString *)title inSection:(int)section withObject:(id)entity {
    self.passedObject = entity;
    [self.bmPathbar addOfferDetails:title inSection:section];
    [self changeViewController:BMScreenOfferDetails];
}

#pragma mark -
#pragma mark System

- (void)changeViewController:(BMScreen)tag {
    BOOL shouldPush = NO;
    self.inOfferDetails = NO;

    if (tag == BMScreenNewest || tag == BMScreenJobs || tag == BMScreenPeople || tag == BMScreenSearchResults) {
        if (self.currentScreen != tag) {
            shouldPush = YES;
            self.bmViewController = [[OffersList alloc] initWithNibName:@"OffersList" bundle:nil];
        }
    }
    else if (tag == BMScreenSettings) {
        shouldPush = YES;
        self.bmViewController = [[Settings alloc] initWithNibName:@"Settings" bundle:nil];
    }
    else if (tag == BMScreenOfferDetails) {
        shouldPush = YES;
        self.inOfferDetails = YES;
        self.bmViewController = [[OfferDetails alloc] initWithNibName:@"OfferDetails" bundle:nil];
        [self.bmViewController setValue:self.passedObject forKey:@"currentOffer"];
    }

    if (shouldPush) {
        self.previousScreen = self.currentScreen;
        self.currentScreen = tag;
        [self push:self.bmViewController];
        [[_bmViewController view] setFrame:[_holderView bounds]];
        [[_bmViewController view] setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    }

    if ([self.bmViewController respondsToSelector:@selector(didShow)])
        [self.bmViewController performSelector:@selector(didShow)];
}

@end
