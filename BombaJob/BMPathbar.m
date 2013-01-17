//
//  BMPathbar.m
//  BombaJob
//
//  Created by supudo on 1/17/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "BMPathbar.h"

@implementation BMPathbar

#pragma mark -
#pragma mark Init

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)initPathbar {
    [pathbar setHidden:YES];
    [pathbar setAction:@selector(pathbarAction:)];
    [pathbar setTarget:self];
    [pathbar addItemWithTitle:NSLocalizedString(@"MainNavTitle", @"MainNavTitle")];
}

#pragma mark -
#pragma mark System

- (void)removeLastItem {
    [pathbar removeLastItem];
}

#pragma mark -
#pragma mark Menu items

- (void)addSync {
    [pathbar addItemWithTitle:NSLocalizedString(@"SyncInProgress", @"SyncInProgress")];
}

- (void)addNewestOffers {
    [pathbar addItemWithTitle:NSLocalizedString(@"NewOffers", @"NewOffers")];
}

#pragma mark -
#pragma mark Actions

- (IBAction)pathbarAction:(id)sender {
    [[oSettings sharedoSettings] LogThis:@"%@ clicked", [(ITPathbar *)sender clickedPathComponentCell]];
}

@end
