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

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
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
#pragma mark CoreData

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (void)saveDatabase {
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing])
        [[oSettings sharedoSettings] LogThis:@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd)];
    
    if (![[self managedObjectContext] save:&error])
        [[NSApplication sharedApplication] presentError:error];
}

- (NSURL *)applicationFilesDirectory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"BombaJob"];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel)
        return _managedObjectModel;
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BombaJob" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator)
        return _persistentStoreCoordinator;
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        [[oSettings sharedoSettings] LogThis:@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd)];
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError)
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    else {
        if (![properties[NSURLIsDirectoryKey] boolValue]) {
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"BombaJob.storedata"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _persistentStoreCoordinator = coordinator;
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext)
        return _managedObjectContext;
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}

- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    return [[self managedObjectContext] undoManager];
}

#pragma mark -
#pragma mark NSApp specifics

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    if (!_managedObjectContext)
        return NSTerminateNow;
    
    if (![[self managedObjectContext] commitEditing]) {
        [[oSettings sharedoSettings] LogThis:@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd)];
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges])
        return NSTerminateNow;
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        
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
