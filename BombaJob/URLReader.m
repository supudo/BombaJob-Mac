//
//  URLReader.m
//  BombaJob
//
//  Created by supudo on 1/16/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "URLReader.h"

@implementation URLReader

@synthesize delegate = _delegate;

- (NSString *)getFromURL:(NSString *)URL postData:(NSString *)pData postMethod:(NSString *)pMethod {
	NSData *postData = [pData dataUsingEncoding:NSASCIIStringEncoding];
	NSString *postLength = [NSString stringWithFormat:@"%ld", [postData length]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:URL]];
	[request setHTTPMethod:pMethod];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
	[request setHTTPBody:[pData dataUsingEncoding:NSUTF8StringEncoding]];
	[[oSettings sharedoSettings] LogThis:@"getFromURL method = %@, postData = %@", pMethod, pData];
	
	NSError *error = nil;
	NSURLResponse *response;
	NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString *data = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
	
	if (error != nil && [error localizedDescription] != nil) {
		data = @"";
		if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(urlRequestError:errorMessage:)])
			[delegate urlRequestError:self errorMessage:[error localizedFailureReason]];
	}

	return data;
}

- (NSString *)urlCryptedEncode:(NSString *)stringToEncrypt {
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                             NULL,
                                                                                             (__bridge CFStringRef)stringToEncrypt,
                                                                                             NULL,
                                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                             kCFStringEncodingUTF8);
	return result;
}

@end
