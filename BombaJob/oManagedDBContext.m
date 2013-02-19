//
//  oManagedDBContext.m
//  BombaJob
//
//  Created by supudo on 2/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "oManagedDBContext.h"

@implementation oManagedDBContext

SYNTHESIZE_SINGLETON_FOR_CLASS(oManagedDBContext);

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark -
#pragma mark Public methods

- (BOOL)save {
    BOOL result = YES;
    NSError *error = nil;

    if (![self.managedObjectContext commitEditing]) {
        result = NO;
        [[oSettings sharedoSettings] LogThis:@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd)];
    }
    
    if (![self.managedObjectContext save:&error]) {
        result = NO;
        [[NSApplication sharedApplication] presentError:error];
    }

    return result;
}

- (BOOL)deleteAllObjects: (NSString *) entityName  {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext]];
    NSError *error = nil;
    NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	
    for (NSManagedObject *managedObject in items)
        [self.managedObjectContext deleteObject:managedObject];
    
    if (![self.managedObjectContext save:&error])
		return FALSE;
	return TRUE;
}

- (BOOL)deleteObjects: (NSString *) entityName predicate: (NSPredicate *) predicate  {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext]];
	[fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	
	for (NSManagedObject *managedObject in items)
		[self.managedObjectContext deleteObject:managedObject];
	
    if (![self.managedObjectContext save:&error])
		return FALSE;
	return TRUE;
}

- (NSManagedObject *)getEntity:(NSString *)entityName predicateString:(NSString *)predicateString {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext]];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	[fetchRequest setPredicate:predicate];
	NSError *error = nil;
	NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	if ([items count] > 0)
		return [items objectAtIndex:0];
	else
		return nil;
}

- (NSManagedObject *)getEntity:(NSString *)entityName predicate:(NSPredicate *)predicate {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext]];
	[fetchRequest setPredicate:predicate];
	NSError *error = nil;
	NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	if ([items count] > 0)
		return [items objectAtIndex:0];
	else
		return nil;
}

#pragma mark -
#pragma mark CoreData

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
    return [self.managedObjectContext undoManager];
}

@end
