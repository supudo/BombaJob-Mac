//
//  AppController.m
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "AppController.h"
#import "Newest.h"
#import "People.h"
#import "Jobs.h"
#import "Settings.h"
#import "SearchResults.h"

@implementation AppController

@synthesize bmToolbar = _bmToolbar;
@synthesize holderView = _holderView;
@synthesize bmViewController = _bmViewController;

- (void)push {
	//SampleViewController *sample = [[SampleViewController alloc] initWithNumber:count];
	//[self.holderView pushViewController:sample];
}

- (void)pop {
	//[self.holderView popViewController];
}

- (IBAction)iboNewest:(id)sender {
    [self.bmToolbar.toolbar setSelectedItemIdentifier:@"Newest"];
    [self changeViewController:BMScreenNewest];
}

- (IBAction)iboJobs:(id)sender {
    [self.bmToolbar.toolbar setSelectedItemIdentifier:@"Jobs"];
    [self changeViewController:BMScreenJobs];
}

- (IBAction)iboPeople:(id)sender {
    [self.bmToolbar.toolbar setSelectedItemIdentifier:@"People"];
    [self changeViewController:BMScreenPeople];
}

- (IBAction)iboSettings:(id)sender {
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
    else
        tagPrev = -1;

    if (tag != tagPrev || tagPrev == -1) {
        switch (tag) {
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
        }

        if (tagPrev < tag || tagPrev == -1)
            [self.holderView pushViewController:self.bmViewController];
        else if (tagPrev > tag)
            [self.holderView popViewController];

        [[_bmViewController view] setFrame:[_holderView bounds]];
        [[_bmViewController view] setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
        if ([self.bmViewController respondsToSelector:@selector(didShow)])
            [self.bmViewController performSelector:@selector(didShow)];
    }

    /*
    [[_bmViewController view] removeFromSuperview];
    switch (tag) {
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
    }
    [_holderView addSubview:[_bmViewController view]];
    [[_bmViewController view] setFrame:[_holderView bounds]];
    [[_bmViewController view] setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    if ([self.bmViewController respondsToSelector:@selector(didShow)])
        [self.bmViewController performSelector:@selector(didShow)];
     */
}

@end
