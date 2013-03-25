//
//  Jobs.m
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "Jobs.h"
#import "OfferCell.h"
#import "dbJobOffer.h"

@interface Jobs ()
@end

@implementation Jobs

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
    [dataController setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"PublishDate" ascending:NO]]];
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

@end
