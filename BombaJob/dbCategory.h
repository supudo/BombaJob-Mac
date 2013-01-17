//
//  dbCategory.h
//  BombaJob
//
//  Created by supudo on 1/11/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class dbJobOffer;

@interface dbCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * CategoryID;
@property (nonatomic, retain) NSString * CategoryTitle;
@property (nonatomic, retain) NSNumber * OffersCount;
@property (nonatomic, retain) NSSet *offers;
@end

@interface dbCategory (CoreDataGeneratedAccessors)

- (void)addOffersObject:(dbJobOffer *)value;
- (void)removeOffersObject:(dbJobOffer *)value;
- (void)addOffers:(NSSet *)values;
- (void)removeOffers:(NSSet *)values;

@end
