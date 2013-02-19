//
//  AppDelegate.h
//  BombaJob
//
//  Created by supudo on 1/11/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "oManagedDBContext.h"
#import "BMStatusBarMenu.h"
#import "BMToolbar.h"
#import "BMPathbar.h"
#import "BMDockMenu.h"
#import "AppController.h"
#import "PatternView.h"
#import "Sync.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, SyncDelegate>

// ================================================

@property (assign) IBOutlet NSWindow *window;

// Properties - UI
@property (assign) IBOutlet BMStatusBarMenu *bmStatusbarMenu;
@property (assign) IBOutlet BMToolbar *bmToolbar;
@property (assign) IBOutlet BMPathbar *bmPathbar;
@property (assign) IBOutlet BMDockMenu *bmDockMenu;
@property (assign) IBOutlet AppController *bmAppController;

@property (strong) IBOutlet PatternView *bottomBar;
@property (assign) IBOutlet NSTextField *txtOfferCount;
@property (strong) IBOutlet NSTextField *txtLoading;
@property (assign) IBOutlet NSProgressIndicator *progressIndicator;
@property (strong) NSView *vLoadingOverlay;

@property (strong) Sync *syncer;

// ================================================

// Synchronization
- (void)startSynchronization;
- (void)stopSynchronization;
- (void)updateOffersCount;
- (void)loadingShow;
- (void)loadingHide;

@end
