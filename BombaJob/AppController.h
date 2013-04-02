//
//  AppController.h
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMToolbar.h"
#import "M3NavigationView.h"
#import "BMPathbar.h"

@interface AppController : NSObject

@property (weak) IBOutlet BMToolbar *bmToolbar;
@property (weak) IBOutlet M3NavigationView *holderView;
@property (assign) IBOutlet BMPathbar *bmPathbar;
@property (strong) NSViewController<M3NavigationViewControllerProtocol> *bmViewController;
@property BMScreen previousScreen, currentScreen;

- (void)popFromOfferDetails;
- (IBAction)iboNewest:(id)sender;
- (IBAction)iboJobs:(id)sender;
- (IBAction)iboPeople:(id)sender;
- (IBAction)iboSettings:(id)sender;
- (IBAction)iboSearch:(id)sender;
- (void)scrOfferDetails:(NSString *)title inSection:(int)section withObject:(id)entity;
- (void)gotoOlderOffer;
- (void)gotoNewerOffer;

@end
