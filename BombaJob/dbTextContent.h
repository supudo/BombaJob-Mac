//
//  dbTextContent.h
//  BombaJob
//
//  Created by supudo on 1/11/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface dbTextContent : NSManagedObject

@property (nonatomic, retain) NSNumber * cID;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * title;

@end
