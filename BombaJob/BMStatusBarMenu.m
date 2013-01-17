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
}

#pragma mark -
#pragma mark Actions

- (IBAction)iboShow:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [[NSApp keyWindow] makeKeyAndOrderFront:nil];
}

- (IBAction)iboExit:(id)sender {
    [NSApp terminate:self];
}

- (IBAction)iboNewest:(id)sender {
}

- (IBAction)iboPeople:(id)sender {
}

- (IBAction)iboOffers:(id)sender {
}

- (IBAction)iboSettings:(id)sender {
}

- (IBAction)iboRefresh:(id)sender {
}

@end
