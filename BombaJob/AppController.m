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

@implementation AppController

@synthesize holderView = _holderView;
@synthesize bmViewController = _bmViewController;

- (IBAction)iboNewest:(id)sender {
    [self changeViewController:BMScreenNewest];
}

- (IBAction)iboJobs:(id)sender {
    [self changeViewController:BMScreenJobs];
}

- (IBAction)iboPeople:(id)sender {
    [self changeViewController:BMScreenPeople];
}

- (IBAction)iboSettings:(id)sender {
    [self changeViewController:BMScreenSettings];
}

- (void)changeViewController:(BMScreen)tag {
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
    }
    [_holderView addSubview:[_bmViewController view]];
    [[_bmViewController view] setFrame:[_holderView bounds]];
    [[_bmViewController view] setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
}

@end
