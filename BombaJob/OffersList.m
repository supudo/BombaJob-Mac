//
//  OffersList.m
//  BombaJob
//
//  Created by supudo on 3/26/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "OffersList.h"
#import "OfferCell.h"
#import "dbJobOffer.h"

@interface OffersList ()
@end

@implementation OffersList

@synthesize tblOffers, dataController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.managedObjectContext = [oManagedDBContext sharedoManagedDBContext].managedObjectContext;
        NSTableColumn *column = [[tblOffers tableColumns] objectAtIndex:0];
        OfferCell *cell = [OfferCell new];
        [column setDataCell:cell];
    }
    return self;
}

- (void)didShow {
    [dataController setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"publishDate" ascending:NO]]];
    switch (((AppDelegate *)[NSApp delegate]).bmAppController.currentScreen) {
        case BMScreenJobs:
            [dataController setFetchPredicate:[NSPredicate predicateWithFormat:@"humanYn = 0"]];
            break;
        case BMScreenPeople:
            [dataController setFetchPredicate:[NSPredicate predicateWithFormat:@"humanYn = 1"]];
            break;
        default:
            break;
    }
}

- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    [((OfferCell *)cell) setJobOffer:(dbJobOffer *)[[dataController arrangedObjects] objectAtIndex:row]];
}

- (void)tableViewColumnDidResize:(NSNotification *)notification {
    _tableColumnWidth = [[[tblOffers tableColumns] objectAtIndex:0] width];
    [tblOffers noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tblOffers.numberOfRows)]];
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    NSCell *cell = [tableView preparedCellAtColumn:0 row:row];
    NSRect constrainedBounds = NSMakeRect(0, 0, _tableColumnWidth, CGFLOAT_MAX);
    NSSize naturalSize = [cell cellSizeForBounds:constrainedBounds];
    naturalSize.height += 10;
    if (naturalSize.height > [tblOffers rowHeight])
        return naturalSize.height;
    else
        return [tblOffers rowHeight];
}

- (IBAction)iboViewOffer:(id)sender {
    NSInteger selectedRow = [tblOffers selectedRow];
    if (selectedRow != -1) {
        dbJobOffer *ent = (dbJobOffer *)[self.dataController.arrangedObjects objectAtIndex:selectedRow];
        [((AppDelegate *)[NSApp delegate]).bmAppController scrOfferDetails:ent.title inSection:2 withObject:ent];
    }
}

@end