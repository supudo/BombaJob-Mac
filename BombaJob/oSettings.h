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
    BOOL inDebugMode;
    int totalOffersCount;
    NSString *lastSearchQuery;
}

@property BOOL inDebugMode;
@property int totalOffersCount;
@property (strong) NSString *lastSearchQuery;

typedef enum BMScreen {
    BMScreenNewest = 0,
    BMScreenJobs,
    BMScreenPeople,
    BMScreenSettings,
    BMScreenSearchResults
} BMScreen;

- (void)LogThis:(NSString *)log, ...;
- (BOOL)connectedToInternet;
- (BOOL)validEmail:(NSString *)email sitrictly:(BOOL)stricterFilter;
- (NSString *)stripHTMLtags:(NSString *)txt;

+ (oSettings *)sharedoSettings;

@end
