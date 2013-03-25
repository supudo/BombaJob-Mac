//
//  Newest.m
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "Newest.h"

@interface Newest ()
@end

@implementation Newest

@synthesize tblOffers, dtFormatter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.managedObjectContext = [oManagedDBContext sharedoManagedDBContext].managedObjectContext;
        [[[tblOffers.tableColumns objectAtIndex:0] headerCell] setStringValue:@".."];
        [[[tblOffers.tableColumns objectAtIndex:1] headerCell] setStringValue:@".."];
        [[[tblOffers.tableColumns objectAtIndex:2] headerCell] setStringValue:@".."];
    }
    return self;
}

- (void)didShow {
    [dtFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"bg-BG"]];
    [tblOffers setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"PublishDate" ascending:NO]]];
}

#pragma mark -
#pragma mark NSTable delegates

- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if (tableColumn == nil)
        return nil;
    
    NSString *colName = [tableColumn identifier];
    if ([colName isEqualToString:@"HumanYn"]) {
        NSCell *hcell = [[NSCell alloc] initImageCell:[NSImage imageNamed:@"icon_company"]];
        return hcell;
    }
    return nil;
}

/*
- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if ([tableColumn.identifier isEqualToString:@"HumanYn"]) {
        NSTextFieldCell *c = (NSTextFieldCell *)cell;
        int h = [c.title intValue];
        if (h == 0)
            [c setTitle:NSLocalizedString(@"Offer_IShort_Human", @"Offer_IShort_Human")];
        else
            [c setTitle:NSLocalizedString(@"Offer_IShort_Company", @"Offer_IShort_Company")];
    }
}
*/

@end
