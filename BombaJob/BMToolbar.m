//
//  BMToolbar.m
//  BombaJob
//
//  Created by supudo on 1/16/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "BMToolbar.h"

@implementation BMToolbar

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
    self.tbPeople.label = NSLocalizedString(@"Toolbar.People", @"Toolbar.People");
    self.tbPeople.toolTip = NSLocalizedString(@"Toolbar.People.Tooltip", @"Toolbar.People.Tooltip");
    self.tbOffers.label = NSLocalizedString(@"Toolbar.Offers", @"Toolbar.Offers");
    self.tbOffers.toolTip = NSLocalizedString(@"Toolbar.Offers.Tooltip", @"Toolbar.Offers.Tooltip");
    self.tbSettings.label = NSLocalizedString(@"Toolbar.Settings", @"Toolbar.Settings");
    self.tbSettings.toolTip = NSLocalizedString(@"Toolbar.Settings.Tooltip", @"Toolbar.Settings.Tooltip");
}

- (IBAction)iboTbPrevious:(id)sender {
    [[oSettings sharedoSettings] LogThis:@"Toolbar Previous offer..."];
}

- (IBAction)iboTbNext:(id)sender {
    [[oSettings sharedoSettings] LogThis:@"Toolbar Next offer..."];
}

- (IBAction)iboTbRefresh:(id)sender {
    [[oSettings sharedoSettings] LogThis:@"Toolbar Refresh..."];
}

- (IBAction)iboTbNewest:(id)sender {
    [[oSettings sharedoSettings] LogThis:@"Toolbar Newest..."];
}

- (IBAction)iboTbPeople:(id)sender {
    [[oSettings sharedoSettings] LogThis:@"Toolbar People..."];
}

- (IBAction)iboTbOffers:(id)sender {
    [[oSettings sharedoSettings] LogThis:@"Toolbar Offers..."];
}

- (IBAction)iboTbSettings:(id)sender {
    [[oSettings sharedoSettings] LogThis:@"Toolbar Settings ..."];
}

@end
