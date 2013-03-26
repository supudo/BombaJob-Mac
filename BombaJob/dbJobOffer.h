//
//  dbJobOffer.h
//  BombaJob
//
//  Created by supudo on 1/11/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ImageToDataTransformer.h"

@class dbCategory;

@interface dbJobOffer : NSManagedObject

@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSString * categoryTitle;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * freelanceYn;
@property (nonatomic, retain) NSNumber * humanYn;
@property (nonatomic, retain) NSString * negativism;
@property (nonatomic, retain) NSNumber * offerID;
@property (nonatomic, retain) NSString * positivism;
@property (nonatomic, retain) NSDate * publishDate;
@property (nonatomic, retain) NSNumber * readYn;
@property (nonatomic, retain) NSNumber * sentMessageYn;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) ImageToDataTransformer * offerIcon;
@property (nonatomic, retain) dbCategory *category;

@end
