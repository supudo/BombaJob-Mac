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
    [self.pathbar setAction:@selector(pathbarAction:)];
    [self.pathbar setTarget:self];
    [self.pathbar addItemWithTitle:NSLocalizedString(@"MainNavTitle", @"MainNavTitle")];
}

#pragma mark -
#pragma mark System

- (void)removeLastItem {
    [self.pathbar removeLastItem];
}

#pragma mark -
#pragma mark Menu items

- (void)addSync {
    [self.pathbar addItemWithTitle:NSLocalizedString(@"SyncInProgress", @"SyncInProgress")];
}

- (void)addNewestOffers {
    [self.pathbar addItemWithTitle:NSLocalizedString(@"NewOffers", @"NewOffers")];
}

#pragma mark -
#pragma mark Actions

- (IBAction)pathbarAction:(id)sender {
    [[oSettings sharedoSettings] LogThis:@"%@ clicked", [(ITPathbar *)sender clickedPathComponentCell]];
}

@end
