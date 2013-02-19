//
//  oManagedDBContext.h
//  BombaJob
//
//  Created by supudo on 2/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SynthesizeSingleton.h"

@interface oManagedDBContext : NSObject

- (BOOL)save;

- (BOOL)deleteAllObjects:(NSString *)entityName;
- (BOOL)deleteObjects:(NSString *)entityName predicate:(NSPredicate *)predicate;

- (NSManagedObject *)getEntity:(NSString *)entityName predicateString:(NSString *)predicateString;
- (NSManagedObject *)getEntity:(NSString *)entityName predicate:(NSPredicate *)predicate;

+ (oManagedDBContext *)sharedoManagedDBContext;

@end
