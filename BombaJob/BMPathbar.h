//
//  BMPathbar.h
//  BombaJob
//
//  Created by supudo on 1/17/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "ITPathbar.h"

@interface BMPathbar : NSObject

@property (assign) IBOutlet ITPathbar *pathbar;

- (void)initPathbar;

- (void)addSync;
- (void)addNewestOffers;
- (void)addJobs;
- (void)addPeople;
- (void)addSettings;

- (IBAction)pathbarAction:(id)sender;

@end
