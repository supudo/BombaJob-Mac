//
//  People.h
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M3NavigationViewControllerProtocol.h"
#import "oManagedDBContext.h"

@interface People : NSViewController <M3NavigationViewControllerProtocol>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak) IBOutlet NSTableView *tblOffers;
@property (weak) IBOutlet NSArrayController *dataController;
@property (weak) IBOutlet NSDateFormatter *dtFormatter;

- (void)didShow;

@end
