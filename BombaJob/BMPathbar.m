//
//  BMPathbar.m
//  BombaJob
//
//  Created by supudo on 1/17/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "BMPathbar.h"

@interface BMPathbar ()
- (void)removeLastItem;
- (void)addItem:(NSString *)title;
@end

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

- (void)addItem:(NSString *)title {
    /*
    [self removeLastItem];
    if ([self.pathbar itemsCount] == 0)
        [self.pathbar addItemWithTitle:NSLocalizedString(@"MainNavTitle", @"MainNavTitle")];
     */
    [self.pathbar removeAllItems];
    [self.pathbar addItemWithTitle:NSLocalizedString(@"MainNavTitle", @"MainNavTitle")];
    [self.pathbar addItemWithTitle:title];
}

#pragma mark -
#pragma mark Menu items

- (void)addSync {
    [self addItem:NSLocalizedString(@"SyncInProgress", @"SyncInProgress")];
}

- (void)addNewestOffers {
    [self addItem:NSLocalizedString(@"StatusBar.Newest", @"StatusBar.Newest")];
}

- (void)addJobs {
    [self addItem:NSLocalizedString(@"StatusBar.Jobs", @"StatusBar.Jobs")];
}

- (void)addPeople {
    [self addItem:NSLocalizedString(@"StatusBar.People", @"StatusBar.People")];
}

- (void)addSettings {
    [self addItem:NSLocalizedString(@"StatusBar.Settings", @"StatusBar.Settings")];
}

- (void)addOfferDetails:(NSString *)title inSection:(int)section {
    [self.pathbar removeAllItems];
    [self.pathbar addItemWithTitle:NSLocalizedString(@"MainNavTitle", @"MainNavTitle")];
    switch (section) {
        case 1:
            [self.pathbar addItemWithTitle:NSLocalizedString(@"StatusBar.Newest", @"StatusBar.Newest")];
            break;
        case 2:
            [self.pathbar addItemWithTitle:NSLocalizedString(@"StatusBar.Jobs", @"StatusBar.Jobs")];
            break;
        case 3:
            [self.pathbar addItemWithTitle:NSLocalizedString(@"StatusBar.People", @"StatusBar.People")];
            break;
        case 4:
            [self.pathbar addItemWithTitle:NSLocalizedString(@"StatusBar.Search", @"StatusBar.Search")];
            break;
        default:
            break;
    }
    [self.pathbar addItemWithTitle:title];
}

#pragma mark -
#pragma mark Actions

- (IBAction)pathbarAction:(id)sender {
    [[oSettings sharedoSettings] LogThis:@"%@ clicked", [(ITPathbar *)sender clickedPathComponentCell]];
}

@end
