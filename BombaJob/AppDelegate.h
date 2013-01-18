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

@interface AppDelegate : NSObject <NSApplicationDelegate>

/*
    Properties
 */

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTextField *cbOfferCount;

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

/*
    Methods
 */

// Database
- (IBAction)saveAction:(id)sender;

// Synchronization
- (void)startSynchronization;
- (void)stopSynchronization;
- (void)updateOffersCount;

@end
