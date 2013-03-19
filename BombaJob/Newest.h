//
//  Newest.h
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M3NavigationViewControllerProtocol.h"
#import "oManagedDBContext.h"

@interface Newest : NSViewController <M3NavigationViewControllerProtocol>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)didShow;

@end
