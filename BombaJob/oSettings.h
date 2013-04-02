//
//  oSettings.h
//  BombaJob
//
//  Created by supudo on 1/16/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@interface oSettings : NSObject {
    BOOL inDebugMode, syncLog, currentPostOfferResult, forceSync;
    int totalOffersCount;
    NSString *lastSearchQuery, *ServicesURL, *currentPostOfferResponse, *dateFormatList;
    NSColor *orangeColor;
}

@property BOOL inDebugMode, syncLog, currentPostOfferResult, forceSync;
@property int totalOffersCount;
@property (strong) NSString *lastSearchQuery, *ServicesURL, *currentPostOfferResponse, *dateFormatList;
@property (strong) NSColor *orangeColor;

typedef enum BMScreen {
    BMScreenSync = 0,
    BMScreenOffersList,
    BMScreenNewest,
    BMScreenJobs,
    BMScreenPeople,
    BMScreenSettings,
    BMScreenSearchResults,
    BMScreenOfferDetails
} BMScreen;

- (void)LogThis:(NSString *)log, ...;
- (BOOL)connectedToInternet;
- (BOOL)validEmail:(NSString *)email sitrictly:(BOOL)stricterFilter;
- (NSString *)stripHTMLtags:(NSString *)txt;

+ (oSettings *)sharedoSettings;

@end
