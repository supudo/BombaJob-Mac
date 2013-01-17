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

- (void)initStatusbarMenu;

- (IBAction)iboShow:(id)sender;
- (IBAction)iboNewest:(id)sender;
- (IBAction)iboPeople:(id)sender;
- (IBAction)iboOffers:(id)sender;
- (IBAction)iboSettings:(id)sender;
- (IBAction)iboRefresh:(id)sender;
- (IBAction)iboExit:(id)sender;

@end
