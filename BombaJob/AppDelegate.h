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
@property (assign) IBOutlet BMPathbar *bmPathbar;
@property (assign) IBOutlet BMToolbar *bmToolbar;

/*
    Methods
 */

// Database
- (IBAction)saveAction:(id)sender;

// Synchronization
- (void)startSynchronization;
- (void)stopSynchronization;

@end
