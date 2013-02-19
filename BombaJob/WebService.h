//
//  WebService.h
//  BombaJob
//
//  Created by supudo on 6/29/11.
//  Copyright 2011 bombajob.bg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLReader.h"
#import "dbCategory.h"
#import "dbJobOffer.h"
#import "dbTextContent.h"
#import "SearchOffer.h"
#import "CurrentOffer.h"

@protocol WebServiceDelegate <NSObject>
@optional
- (void)serviceError:(id)sender error:(NSString *)errorMessage;
- (void)postJobFinished:(id)sender;
- (void)postMessageFinished:(id)sender;
- (void)getCategoriesFinished:(id)sender;
- (void)getNewJobsFinished:(id)sender;
- (void)getJobsHumanFinished:(id)sender;
- (void)getJobsCompanyFinished:(id)sender;
- (void)getTextContentFinished:(id)sender;
- (void)searchOffersFinished:(id)sender results:(NSMutableArray *)offers;
- (void)geoSearchOffersFinished:(id)sender results:(NSMutableArray *)offers;
- (void)sendEmailMessageFinished:(id)sender;
- (void)configFinshed:(id)sender;
@end

@interface WebService : NSObject <NSXMLParserDelegate, URLReaderDelegate> {
	id<WebServiceDelegate> delegate;
	URLReader *urlReader;
	NSString *currentElement;
	int OperationID;
	dbCategory *entCategory;
	dbJobOffer *entOffer;
	dbTextContent *entTextContent;
	SearchOffer *searchSingle;
	NSMutableArray *searchResults;
}

@property (assign) id<WebServiceDelegate> delegate;
@property (strong) URLReader *urlReader;
@property int OperationID;
@property (strong) dbCategory *entCategory;
@property (strong) dbJobOffer *entOffer;
@property (strong) dbTextContent *entTextContent;
@property (strong) SearchOffer *searchSingle;
@property (strong) NSMutableArray *searchResults;

typedef enum NLServiceOperations {
	NLOperationPostJob = 0,
	NLOperationPostMessage,
	NLOperationGetCategories,
	NLOperationGetNewJobs,
	NLOperationGetJobsHuman,
	NLOperationGetJobsCompany,
	NLOperationGetTextContents,
	NLOperationSearch,
	NLOperationSearchGeo,
	NLOperationSendEmail
} NLServiceOperations;

- (id<WebServiceDelegate>)delegate;
- (void)setDelegate:(id<WebServiceDelegate>)newDelegate;
- (void)postNewJob:(CurrentOffer *)offer;
- (void)postMessage:(int)offerID message:(NSString *)msg;
- (void)getCategories:(BOOL)doFullSync;
- (void)getNewJobs:(BOOL)doFullSync;
- (void)searchJobs:(BOOL)doFullSync;
- (void)searchPeople:(BOOL)doFullSync;
- (void)getTextContent;
- (void)searchOffers:(NSString *)searchTerm freelance:(BOOL)frl;
- (void)geoSearchOffers:(NSString *)searchTerm freelance:(BOOL)frl latitude:(float)lat longitude:(float)lon;
- (void)sendEmailMessage:(int)offerID toEmail:(NSString *)toEmail fromEmail:(NSString *)fromEmail;

@end