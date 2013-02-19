//
//  AppDelegate.m
//  BombaJob
//
//  Created by supudo on 1/11/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppDelegate
@synthesize vLoadingOverlay = _vLoadingOverlay;
@synthesize syncer = _syncer;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.vLoadingOverlay = [[NSView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
    [self.vLoadingOverlay setWantsLayer:YES];
    self.vLoadingOverlay.layer.backgroundColor = [[NSColor blackColor] CGColor];
    self.vLoadingOverlay.layer.opacity = 0.7f;

    self.bottomBar.backgroundImage = [NSImage imageNamed:@"ITPathbar-fill.png"];
    [self.bottomBar drawRect:self.bottomBar.frame];
    
    [self.progressIndicator startAnimation:nil];
    [self.bmStatusbarMenu initStatusbarMenu];
    [self.bmToolbar initToolbarLabels];
    [self.bmPathbar initPathbar];

    [self updateOffersCount];
    [self startSynchronization];
}

#pragma mark -
#pragma mark Synchronization

- (void)startSynchronization {
    [self loadingShow];
    [self.bmPathbar addSync];
    if (self.syncer == nil)
        self.syncer = [[Sync alloc] init];
    [self.syncer setDelegate:self];
    [self.syncer startSync:NO];
}

- (void)syncFinished:(id)sender {
	[self stopSynchronization];
}

- (void)syncError:(id)sender error:(NSString *) errorMessage {
    [[oSettings sharedoSettings] LogThis:@"Sync error - %@", errorMessage];
}

- (void)stopSynchronization {
    [self updateOffersCount];
    [self.bmPathbar removeLastItem];
    [self.bmPathbar addNewestOffers];
    [self.bmAppController iboNewest:nil];
    [self.progressIndicator stopAnimation:nil];
    [self.progressIndicator setHidden:YES];
    [self loadingHide];
}

#pragma mark -
#pragma mark DB

- (void)updateOffersCount {
    //[[[NSApplication sharedApplication] dockTile] setBadgeLabel:[NSString stringWithFormat:@"%i", [oSettings sharedoSettings].totalOffersCount]];

    if ([oSettings sharedoSettings].totalOffersCount == 0)
        self.txtOfferCount.stringValue = NSLocalizedString(@"UI.NoOffers", @"UI.NoOffers");
    else if ([oSettings sharedoSettings].totalOffersCount == 1)
        self.txtOfferCount.stringValue = [NSString stringWithFormat:@"%i %@", [oSettings sharedoSettings].totalOffersCount, NSLocalizedString(@"UI.OfferSmall", @"UI.OfferSmall")];
    else
        self.txtOfferCount.stringValue = [NSString stringWithFormat:@"%i %@", [oSettings sharedoSettings].totalOffersCount, NSLocalizedString(@"UI.OffersSmall", @"UI.OffersSmall")];
}

- (void)loadingShow {
    [self.bmToolbar disableAll];
    [self.window.contentView addSubview:self.vLoadingOverlay];
    [self.txtLoading setHidden:NO];
    [self.txtLoading setStringValue:NSLocalizedString(@"SyncInProgress", @"SyncInProgress")];
    [self.txtLoading setFrameOrigin:NSMakePoint(0, 0)];
    [self.vLoadingOverlay addSubview:self.txtLoading];
}

- (void)loadingHide {
    [self.bmToolbar enableAll];
    [self.txtLoading setHidden:YES];
    [self.vLoadingOverlay removeFromSuperview];
}

#pragma mark -
#pragma mark Dock menu

- (NSMenu *)applicationDockMenu:(NSApplication *)sender {
    return self.bmDockMenu.dockMenu;
}

#pragma mark -
#pragma mark NSApp specifics

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    if (![[oManagedDBContext sharedoManagedDBContext] managedObjectContext])
        return NSTerminateNow;
    
    if (![[[oManagedDBContext sharedoManagedDBContext] managedObjectContext] commitEditing]) {
        [[oSettings sharedoSettings] LogThis:@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd)];
        return NSTerminateCancel;
    }
    
    if (![[[oManagedDBContext sharedoManagedDBContext] managedObjectContext] hasChanges])
        return NSTerminateNow;
    
    NSError *error = nil;
    if (![[[oManagedDBContext sharedoManagedDBContext] managedObjectContext] save:&error]) {
        
        BOOL result = [sender presentError:error];
        if (result)
            return NSTerminateCancel;
        
        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];
        
        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn)
            return NSTerminateCancel;
    }
    
    return NSTerminateNow;
}

@end
