//
//  SearchResults.h
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M3NavigationViewControllerProtocol.h"

@interface SearchResults : NSViewController <M3NavigationViewControllerProtocol> 

@property (assign) IBOutlet NSTextField *searchTitle;

- (void)didShow;

@end
