//
//  URLReader.h
//  BombaJob
//
//  Created by supudo on 1/16/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol URLReaderDelegate <NSObject>
@optional
- (void)urlRequestError:(id)sender errorMessage:(NSString *)errorMessage;
@end

@interface URLReader : NSObject {
	id<URLReaderDelegate> delegate;
}

@property (assign) id<URLReaderDelegate> delegate;

- (NSString *)getFromURL:(NSString *)URL postData:(NSString *)pData postMethod:(NSString *)pMethod;
- (NSString *)urlCryptedEncode:(NSString *)stringToEncrypt;

@end
