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
@property (assign) IBOutlet NSToolbarItem *tbNewest, *tbPeople, *tbOffers, *tbSettings;

- (void)initToolbarLabels;
- (IBAction)iboTbPrevious:(id)sender;
- (IBAction)iboTbNext:(id)sender;
- (IBAction)iboTbRefresh:(id)sender;
- (IBAction)iboTbNewest:(id)sender;
- (IBAction)iboTbPeople:(id)sender;
- (IBAction)iboTbOffers:(id)sender;
- (IBAction)iboTbSettings:(id)sender;

@end
