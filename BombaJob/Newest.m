//
//  Newest.m
//  BombaJob
//
//  Created by supudo on 1/18/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "Newest.h"

@interface Newest ()
@end

@implementation Newest

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didShow {
    self.managedObjectContext = [oManagedDBContext sharedoManagedDBContext].managedObjectContext;
}

@end
