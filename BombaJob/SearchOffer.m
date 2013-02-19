//
//  SearchOffer.m
//  BombaJob
//
//  Created by supudo on 7/28/11.
//  Copyright 2011 BombaJob.bg. All rights reserved.
//

#import "SearchOffer.h"

@implementation SearchOffer

@synthesize OfferID, CategoryID, gLatitude, gLongitude, HumanYn, FreelanceYn, ReadYn, SentMessageYn;
@synthesize Title, Email, Positivism, Negativism, CategoryTitle, PublishDate;

- (id) init {
	if (self = [super init]) {
		self.OfferID = 0;
		self.CategoryID = 0;
		self.gLatitude = 0;
		self.gLongitude = 0;
		self.HumanYn = TRUE;
		self.FreelanceYn = FALSE;
		self.ReadYn = FALSE;
		self.SentMessageYn = FALSE;
		self.Title = @"";
		self.Email = @"";
		self.Positivism = @"";
		self.Negativism = @"";
		self.CategoryTitle = @"";
		self.PublishDate = nil;
	}
	return self;
}

@end
