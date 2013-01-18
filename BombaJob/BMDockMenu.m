//
//  BMDockMenu.m
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "BMDockMenu.h"

@implementation BMDockMenu

#pragma mark -
#pragma mark Init

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)initDockMenu {
    [self.itemNewest setTitle:NSLocalizedString(@"StatusBar.Newest", @"StatusBar.Newest")];
    [self.itemJobs setTitle:NSLocalizedString(@"StatusBar.Jobs", @"StatusBar.Jobs")];
    [self.itemPeople setTitle:NSLocalizedString(@"StatusBar.People", @"StatusBar.People")];
    [self.itemSettings setTitle:NSLocalizedString(@"StatusBar.Settings", @"StatusBar.Settings")];
}

@end
