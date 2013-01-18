//
//  BMStatusBarMenu.m
//  BombaJob
//
//  Created by supudo on 1/17/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "BMStatusBarMenu.h"

@implementation BMStatusBarMenu

@synthesize statusItem;

#pragma mark -
#pragma mark Init

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)initStatusbarMenu {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:self.statusMenu];
    [statusItem setHighlightMode:YES];
    [statusItem setImage:[NSImage imageNamed:@"statusbar"]];
    
    [self.itemShowHide setTitle:NSLocalizedString(@"StatusBar.Show", @"StatusBar.Show")];
    [self.itemNewest setTitle:NSLocalizedString(@"StatusBar.Newest", @"StatusBar.Newest")];
    [self.itemJobs setTitle:NSLocalizedString(@"StatusBar.Jobs", @"StatusBar.Jobs")];
    [self.itemPeople setTitle:NSLocalizedString(@"StatusBar.People", @"StatusBar.People")];
    [self.itemSettings setTitle:NSLocalizedString(@"StatusBar.Settings", @"StatusBar.Settings")];
    [self.itemRefresh setTitle:NSLocalizedString(@"StatusBar.Refresh", @"StatusBar.Refresh")];
    [self.itemAbout setTitle:NSLocalizedString(@"StatusBar.About", @"StatusBar.About")];
    [self.itemExit setTitle:NSLocalizedString(@"StatusBar.Quit", @"StatusBar.Quit")];
}

#pragma mark -
#pragma mark Actions

- (IBAction)iboShow:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [[NSApp keyWindow] makeKeyAndOrderFront:nil];
}

- (IBAction)iboAbout:(id)sender {
    [NSApp orderFrontStandardAboutPanel:nil];
}

- (IBAction)iboRefresh:(id)sender {
}

- (IBAction)iboExit:(id)sender {
    [NSApp terminate:self];
}

@end
