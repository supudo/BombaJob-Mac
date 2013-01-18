//
//  BMToolbar.h
//  BombaJob
//
//  Created by supudo on 1/16/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMToolbar : NSObject

@property (assign) IBOutlet NSToolbarItem *tbPrev, *tbNext, *tbRefresh;
@property (assign) IBOutlet NSToolbarItem *tbNewest, *tbJobs, *tbPeople, *tbSettings;
@property (assign) IBOutlet NSSearchField *sfSearch;

- (void)initToolbarLabels;
- (IBAction)iboTbPrevious:(id)sender;
- (IBAction)iboTbNext:(id)sender;
- (IBAction)iboTbRefresh:(id)sender;

@end
