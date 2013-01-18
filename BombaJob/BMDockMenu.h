//
//  BMDockMenu.h
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMDockMenu : NSObject

@property (assign) IBOutlet NSMenu *dockMenu;
@property (assign) IBOutlet NSMenuItem *itemNewest, *itemJobs, *itemPeople, *itemSettings;

- (void)initDockMenu;

@end
