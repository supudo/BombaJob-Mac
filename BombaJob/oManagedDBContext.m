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

#pragma mark -
#pragma mark Public methods

- (BOOL)save {
    BOOL result = YES;
    NSError *error = nil;

    if (![[[NSApp delegate] managedObjectContext] commitEditing]) {
        result = NO;
        [[oSettings sharedoSettings] LogThis:@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd)];
    }
    
    if (![[[NSApp delegate] managedObjectContext] save:&error]) {
        result = NO;
        [[NSApplication sharedApplication] presentError:error];
    }

    return result;
}

- (BOOL)deleteAllObjects: (NSString *) entityName  {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:[[NSApp delegate] managedObjectContext]]];
    NSError *error = nil;
    NSArray *items = [[[NSApp delegate] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
	
    for (NSManagedObject *managedObject in items)
        [[[NSApp delegate] managedObjectContext] deleteObject:managedObject];
    
    if (![[[NSApp delegate] managedObjectContext] save:&error])
		return FALSE;
	return TRUE;
}

- (BOOL)deleteObjects: (NSString *) entityName predicate: (NSPredicate *) predicate  {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:[[NSApp delegate] managedObjectContext]]];
	[fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *items = [[[NSApp delegate] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
	
	for (NSManagedObject *managedObject in items)
		[[[NSApp delegate] managedObjectContext] deleteObject:managedObject];
	
    if (![[[NSApp delegate] managedObjectContext] save:&error])
		return FALSE;
	return TRUE;
}

- (NSManagedObject *)getEntity:(NSString *)entityName predicateString:(NSString *)predicateString {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:[[NSApp delegate] managedObjectContext]]];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	[fetchRequest setPredicate:predicate];
	NSError *error = nil;
	NSArray *items = [[[NSApp delegate] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
	if ([items count] > 0)
		return [items objectAtIndex:0];
	else
		return nil;
}

- (NSManagedObject *)getEntity:(NSString *)entityName predicate:(NSPredicate *)predicate {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:[[NSApp delegate] managedObjectContext]]];
	[fetchRequest setPredicate:predicate];
	NSError *error = nil;
	NSArray *items = [[[NSApp delegate] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
	if ([items count] > 0)
		return [items objectAtIndex:0];
	else
		return nil;
}

@end
