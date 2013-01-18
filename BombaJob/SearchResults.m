//
//  SearchResults.m
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "SearchResults.h"

@interface SearchResults ()

@end

@implementation SearchResults

@synthesize searchTitle = _searchTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didShow {
    [[oSettings sharedoSettings] LogThis:@"Results .... %@", [oSettings sharedoSettings].lastSearchQuery];
    self.searchTitle.stringValue = [NSString stringWithFormat:@"Results for ... %@", [oSettings sharedoSettings].lastSearchQuery];
}

@end
