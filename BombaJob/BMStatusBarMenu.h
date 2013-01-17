//
//  BMStatusBarMenu.h
//  BombaJob
//
//  Created by supudo on 1/17/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMStatusBarMenu : NSObject

@property (nonatomic) NSStatusItem *statusItem;
@property (assign) IBOutlet NSMenu *statusMenu;

@property (assign) IBOutlet NSMenuItem *itemShowHide, *itemNewest, *itemPeople, *itemOffers;
@property (assign) IBOutlet NSMenuItem *itemSettings, *itemRefresh, *itemAbout, *itemExit;

- (void)initStatusbarMenu;

- (IBAction)iboShow:(id)sender;
- (IBAction)iboNewest:(id)sender;
- (IBAction)iboPeople:(id)sender;
- (IBAction)iboOffers:(id)sender;
- (IBAction)iboSettings:(id)sender;
- (IBAction)iboRefresh:(id)sender;
- (IBAction)iboAbout:(id)sender;
- (IBAction)iboExit:(id)sender;

@end
