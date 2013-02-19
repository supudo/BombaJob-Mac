//
//  oSettings.m
//  BombaJob
//
//  Created by supudo on 1/16/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "oSettings.h"

@implementation oSettings

@synthesize inDebugMode, currentPostOfferResult, totalOffersCount, lastSearchQuery, ServicesURL, currentPostOfferResponse;

SYNTHESIZE_SINGLETON_FOR_CLASS(oSettings);

- (void)LogThis:(NSString *)log, ... {
	if (self.inDebugMode) {
		NSString *output;
		va_list ap;
		va_start(ap, log);
		output = [[NSString alloc] initWithFormat:log arguments:ap];
		va_end(ap);
		NSLog(@"[_____BombaJob-DEBUG] : %@", output);
	}
}

- (BOOL)connectedToInternet {
    BOOL result = YES;
	return result;
}

- (id)init {
	if (self = [super init]) {
		self.inDebugMode = YES;
        self.currentPostOfferResult = NO;
        self.totalOffersCount = 0;
        self.lastSearchQuery = @"";
        self.ServicesURL = @"http://www.bombajob.bg/_mob_service.php";
        self.currentPostOfferResponse = @"";
    }
	return self;
}

- (BOOL)validEmail:(NSString *)email sitrictly:(BOOL)stricterFilter {
	// stricterFilter - Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
	NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
	NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:email];
}

- (NSString *)stripHTMLtags:(NSString *)txt {
	NSRange r;
	while ((r = [txt rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
		txt = [txt stringByReplacingCharactersInRange:r withString:@""];
	return txt;
}

@end
