//
//  AppDelegate.h
//  BombaJob
//
//  Created by supudo on 1/11/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BMStatusBarMenu.h"
#import "BMToolbar.h"
#import "BMPathbar.h"
#import "BMDockMenu.h"
#import "AppController.h"
#import "PatternView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

// ================================================

@property (assign) IBOutlet NSWindow *window;

// Properties - Database
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

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

// ================================================

// Database
- (IBAction)saveAction:(id)sender;

// Synchronization
- (void)startSynchronization;
- (void)stopSynchronization;
- (void)updateOffersCount;
- (void)loadingShow;
- (void)loadingHide;

@end
