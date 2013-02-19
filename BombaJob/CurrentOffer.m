//
//  CurrentOffer.m
//  BombaJob
//
//  Created by supudo on 7/14/11.
//  Copyright 2011 BombaJob.bg. All rights reserved.
//

#import "CurrentOffer.h"

@implementation CurrentOffer

@synthesize OfferID, CategoryID, HumanYn, FreelanceYn;
@synthesize Title, Email, Positivism, Negativism, CategoryTitle, PublishDate;

- (id) init {
	if (self = [super init]) {
		self.OfferID = 0;
		self.CategoryID = 0;
		self.HumanYn = TRUE;
		self.FreelanceYn = FALSE;
		self.Title = @"";
		self.Email = @"";
		self.Positivism = @"";
		self.Negativism = @"";
		self.CategoryTitle = @"";
		self.PublishDate = nil;
	}
	return self;
}

- (void)clearAll {
	self.OfferID = 0;
	self.CategoryID = 0;
	self.HumanYn = TRUE;
	self.FreelanceYn = FALSE;
	self.Title = @"";
	self.Email = @"";
	self.Positivism = @"";
	self.Negativism = @"";
	self.CategoryTitle = @"";
	self.PublishDate = nil;
}

@end
