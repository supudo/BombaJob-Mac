//
//  OffersList.h
//  BombaJob
//
//  Created by supudo on 3/26/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M3NavigationViewControllerProtocol.h"
#import "oManagedDBContext.h"

@interface OffersList : NSViewController <M3NavigationViewControllerProtocol> {
@private
    CGFloat _tableColumnWidth;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak) IBOutlet NSTableView *tblOffers;
@property (weak) IBOutlet NSArrayController *dataController;

- (void)didShow;
- (IBAction)iboViewOffer:(id)sender;

@end
