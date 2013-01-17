//
//  dbJobOffer.h
//  BombaJob
//
//  Created by supudo on 1/11/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class dbCategory;

@interface dbJobOffer : NSManagedObject

@property (nonatomic, retain) NSNumber * CategoryID;
@property (nonatomic, retain) NSString * CategoryTitle;
@property (nonatomic, retain) NSString * Email;
@property (nonatomic, retain) NSNumber * FreelanceYn;
@property (nonatomic, retain) NSNumber * HumanYn;
@property (nonatomic, retain) NSString * Negativism;
@property (nonatomic, retain) NSNumber * OfferID;
@property (nonatomic, retain) NSString * Positivism;
@property (nonatomic, retain) NSDate * PublishDate;
@property (nonatomic, retain) NSNumber * ReadYn;
@property (nonatomic, retain) NSNumber * SentMessageYn;
@property (nonatomic, retain) NSString * Title;
@property (nonatomic, retain) dbCategory *category;

@end
