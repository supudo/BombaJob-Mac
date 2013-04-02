//
//  BMToolbar.m
//  BombaJob
//
//  Created by supudo on 1/16/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "BMToolbar.h"

@implementation BMToolbar

#pragma mark -
#pragma mark Init

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)initToolbarLabels {
    self.tbPrev.label = NSLocalizedString(@"Toolbar.Previous", @"Toolbar.Previous");
    self.tbPrev.toolTip = NSLocalizedString(@"Toolbar.Previous.Tooltip", @"Toolbar.Previous.Tooltip");
    self.tbNext.label = NSLocalizedString(@"Toolbar.Next", @"Toolbar.Next");
    self.tbNext.toolTip = NSLocalizedString(@"Toolbar.Next.Tooltip", @"Toolbar.Next.Tooltip");
    self.tbRefresh.label = NSLocalizedString(@"Toolbar.Refresh", @"Toolbar.Refresh");
    self.tbRefresh.toolTip = NSLocalizedString(@"Toolbar.Refresh.Tooltip", @"Toolbar.Refresh.Tooltip");
    
    self.tbNewest.label = NSLocalizedString(@"Toolbar.Newest", @"Toolbar.Newest");
    self.tbNewest.toolTip = NSLocalizedString(@"Toolbar.Newest.Tooltip", @"Toolbar.Newest.Tooltip");
    self.tbJobs.label = NSLocalizedString(@"Toolbar.Jobs", @"Toolbar.Jobs");
    self.tbJobs.toolTip = NSLocalizedString(@"Toolbar.Jobs.Tooltip", @"Toolbar.Jobs.Tooltip");
    self.tbPeople.label = NSLocalizedString(@"Toolbar.People", @"Toolbar.People");
    self.tbPeople.toolTip = NSLocalizedString(@"Toolbar.People.Tooltip", @"Toolbar.People.Tooltip");
    self.tbSettings.label = NSLocalizedString(@"Toolbar.Settings", @"Toolbar.Settings");
    self.tbSettings.toolTip = NSLocalizedString(@"Toolbar.Settings.Tooltip", @"Toolbar.Settings.Tooltip");
    
    [self.sfSearch.cell setPlaceholderString:NSLocalizedString(@"Toolbar.Search", @"Toolbar.Search")];
    self.sfSearch.toolTip = NSLocalizedString(@"Toolbar.Search.Tooltip", @"Toolbar.Search.Tooltip");
}

#pragma mark -
#pragma mark Actions

- (IBAction)iboTbPrevious:(id)sender {
    [((AppDelegate *)[NSApp delegate]).bmAppController gotoOlderOffer];
}

- (IBAction)iboTbNext:(id)sender {
    [((AppDelegate *)[NSApp delegate]).bmAppController gotoNewerOffer];
}

- (IBAction)iboTbRefresh:(id)sender {
    [[oSettings sharedoSettings] LogThis:@"Toolbar Refresh..."];
    [((AppDelegate *)[NSApp delegate]) startSynchronizationFull];
}

#pragma mark -
#pragma mark Publics

- (void)disableAll {
    [self.tbPrev setEnabled:NO];
    [self.tbNext setEnabled:NO];
    [self.tbRefresh setEnabled:NO];

    [self.tbNewest setEnabled:NO];
    [self.tbJobs setEnabled:NO];
    [self.tbPeople setEnabled:NO];
    [self.tbSettings setEnabled:NO];

    [self.sfSearch setEnabled:NO];
}

- (void)enableAll {
    [self.tbPrev setEnabled:YES];
    [self.tbNext setEnabled:YES];
    [self.tbRefresh setEnabled:YES];
    
    [self.tbNewest setEnabled:YES];
    [self.tbJobs setEnabled:YES];
    [self.tbPeople setEnabled:YES];
    [self.tbSettings setEnabled:YES];
    
    [self.sfSearch setEnabled:YES];
}

#pragma mark -
#pragma mark Toolbar delegates

- (BOOL)validateToolbarItem:(NSToolbarItem *)theItem {
    return [theItem isEnabled];
}

@end
