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
- (void)removeLastItem;

- (void)addSync;
- (void)addNewestOffers;

- (IBAction)pathbarAction:(id)sender;

@end
