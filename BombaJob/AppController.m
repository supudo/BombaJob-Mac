//
//  AppController.m
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "AppController.h"
#import "OffersList.h"
#import "Newest.h"
#import "People.h"
#import "Jobs.h"
#import "Settings.h"
#import "SearchResults.h"
#import "OfferDetails.h"

@interface AppController ()
@property (strong) id passedObject;
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
    BMScreen tagPrev = -1;

    if ([self.bmViewController isKindOfClass:[Newest class]])
        tagPrev = BMScreenNewest;
    else if ([self.bmViewController isKindOfClass:[Jobs class]])
        tagPrev = BMScreenJobs;
    else if ([self.bmViewController isKindOfClass:[People class]])
        tagPrev = BMScreenPeople;
    else if ([self.bmViewController isKindOfClass:[Settings class]])
        tagPrev = BMScreenSettings;
    else if ([self.bmViewController isKindOfClass:[SearchResults class]])
        tagPrev = BMScreenSearchResults;
    else if ([self.bmViewController isKindOfClass:[OfferDetails class]])
        tagPrev = BMScreenOfferDetails;
    else
        tagPrev = -1;

    if (tag != tagPrev || tagPrev == -1) {
        switch (tag) {
            case BMScreenOffersList:
                self.bmViewController = [[OffersList alloc] initWithNibName:@"OffersList" bundle:nil];
                break;
            case BMScreenNewest:
                self.bmViewController = [[Newest alloc] initWithNibName:@"Newest" bundle:nil];
                break;
            case BMScreenJobs:
                self.bmViewController = [[Jobs alloc] initWithNibName:@"Jobs" bundle:nil];
                break;
            case BMScreenPeople:
                self.bmViewController = [[People alloc] initWithNibName:@"People" bundle:nil];
                break;
            case BMScreenSettings:
                self.bmViewController = [[Settings alloc] initWithNibName:@"Settings" bundle:nil];
                break;
            case BMScreenSearchResults:
                self.bmViewController = [[SearchResults alloc] initWithNibName:@"SearchResults" bundle:nil];
                break;
            case BMScreenOfferDetails:
                self.bmViewController = [[OfferDetails alloc] initWithNibName:@"OfferDetails" bundle:nil];
                [self.bmViewController setValue:self.passedObject forKey:@"currentOffer"];
                break;
        }

        if (tagPrev < tag || tagPrev == -1)
            [self push:self.bmViewController];
        else if (tagPrev > tag)
            [self pop];

        [[_bmViewController view] setFrame:[_holderView bounds]];
        [[_bmViewController view] setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
        if ([self.bmViewController respondsToSelector:@selector(didShow)])
            [self.bmViewController performSelector:@selector(didShow)];
    }
}

@end
