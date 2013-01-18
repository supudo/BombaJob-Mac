//
//  AppController.h
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppController : NSObject

@property (weak) IBOutlet NSView *holderView;
@property (strong) NSViewController *bmViewController;

- (IBAction)iboNewest:(id)sender;
- (IBAction)iboJobs:(id)sender;
- (IBAction)iboPeople:(id)sender;
- (IBAction)iboSettings:(id)sender;
- (IBAction)iboSearch:(id)sender;

- (void)changeViewController:(BMScreen)tag;

@end
