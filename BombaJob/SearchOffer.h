//
//  SearchOffer.h
//  BombaJob
//
//  Created by supudo on 7/28/11.
//  Copyright 2011 BombaJob.bg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchOffer : NSObject {
	int OfferID, CategoryID;
	float gLatitude, gLongitude;
	BOOL HumanYn, FreelanceYn, ReadYn, SentMessageYn;
	NSString *Title, *Email, *Positivism, *Negativism, *CategoryTitle;
	NSDate *PublishDate;
}

@property int OfferID, CategoryID;
@property float gLatitude, gLongitude;
@property BOOL HumanYn, FreelanceYn, ReadYn, SentMessageYn;
@property (nonatomic, retain) NSString *Title, *Email, *Positivism, *Negativism, *CategoryTitle;
@property (nonatomic, retain) NSDate *PublishDate;

@end