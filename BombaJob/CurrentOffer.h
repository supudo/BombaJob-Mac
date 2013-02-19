//
//  CurrentOffer.h
//  BombaJob
//
//  Created by supudo on 7/14/11.
//  Copyright 2011 BombaJob.bg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentOffer : NSObject {
	int OfferID, CategoryID;
	BOOL HumanYn, FreelanceYn;
	NSString *Title, *Email, *Positivism, *Negativism, *CategoryTitle;
	NSDate *PublishDate;
}

@property int OfferID, CategoryID;
@property BOOL HumanYn, FreelanceYn;
@property (nonatomic, retain) NSString *Title, *Email, *Positivism, *Negativism, *CategoryTitle;
@property (nonatomic, retain) NSDate *PublishDate;

- (void)clearAll;

@end
