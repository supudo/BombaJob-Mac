//
//  Jobs.h
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M3NavigationViewControllerProtocol.h"
#import "oManagedDBContext.h"

@interface Jobs : NSViewController <M3NavigationViewControllerProtocol> {
@private
    CGFloat _tableColumnWidth;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak) IBOutlet NSTableView *tblOffers;
@property (weak) IBOutlet NSArrayController *dataController;

- (void)didShow;

@end
