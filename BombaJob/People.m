//
//  People.m
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "People.h"
#import "dbJobOffer.h"
#import "OfferCell2.h"

@interface People ()

@end

@implementation People

@synthesize tblOffers, dataController, dtFormatter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.managedObjectContext = [oManagedDBContext sharedoManagedDBContext].managedObjectContext;
    }
    return self;
}

- (void)didShow {
    [dtFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"bg-BG"]];
    [dataController setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"PublishDate" ascending:NO]]];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.dataController.arrangedObjects count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    dbJobOffer *ent = [self.dataController.arrangedObjects objectAtIndex:row];
    cell.imageView.image = (NSImage *)ent.offerIcon;
    cell.textField.stringValue = ent.title;
    return cell;
}

@end
