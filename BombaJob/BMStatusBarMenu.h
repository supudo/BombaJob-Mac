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

@property (assign) IBOutlet NSMenuItem *itemShowHide, *itemNewest, *itemJobs, *itemPeople;
@property (assign) IBOutlet NSMenuItem *itemSettings, *itemRefresh, *itemAbout, *itemExit;

- (void)initStatusbarMenu;

- (IBAction)iboShow:(id)sender;
- (IBAction)iboAbout:(id)sender;
- (IBAction)iboExit:(id)sender;

@end
