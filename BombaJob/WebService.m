//
//  WebService.m
//  bombajob.bg
//
//  Created by supudo on 6/29/11.
//  Copyright 2011 bombajob.bg. All rights reserved.
//

#import "WebService.h"
#import "oManagedDBContext.h"

@implementation WebService

@synthesize delegate = _delegate;
@synthesize urlReader, OperationID;
@synthesize entCategory, entOffer, entTextContent, searchSingle, searchResults;

#pragma mark -
#pragma mark Services

- (void)postNewJob:(CurrentOffer *)offer {
	self.OperationID = NLOperationPostJob;
	[[oSettings sharedoSettings] LogThis:@"postNewJob URL call = %@?%@", [oSettings sharedoSettings].ServicesURL, @"action=postNewJob"];
	if (urlReader == nil)
		urlReader = [[URLReader alloc] init];
	[urlReader setDelegate:self];
	
	NSMutableString *postData = [[NSMutableString alloc] init];
	[postData setString:@""];
	[postData appendFormat:@"oid=0"];
	[postData appendFormat:@"&cid=%i", offer.CategoryID];
	[postData appendFormat:@"&h=%@", ((offer.HumanYn) ? @"1" : @"0")];
	[postData appendFormat:@"&fr=%@", ((offer.FreelanceYn) ? @"1" : @"0")];
	[postData appendFormat:@"&tt=%@", offer.Title];
	[postData appendFormat:@"&em=%@", offer.Email];
	[postData appendFormat:@"&pos=%@", offer.Positivism];
	[postData appendFormat:@"&neg=%@", offer.Negativism];
	
	NSString *xmlData = [urlReader getFromURL:[NSString stringWithFormat:@"%@?%@", [oSettings sharedoSettings].ServicesURL, @"action=postNewJob"] postData:postData postMethod:@"POST"];
    if ([oSettings sharedoSettings].syncLog)
        [[oSettings sharedoSettings] LogThis:@"postNewJob response = %@", xmlData];
	if (xmlData.length > 0) {
		NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:[xmlData dataUsingEncoding:NSUTF8StringEncoding]];
		[myParser setDelegate:self];
		[myParser setShouldProcessNamespaces:NO];
		[myParser setShouldReportNamespacePrefixes:NO];
		[myParser setShouldResolveExternalEntities:NO];
		[myParser parse];
	}
	else if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(postJobFinished:)])
		[delegate postJobFinished:self];
}

- (void)postMessage:(int)offerID message:(NSString *)msg {
	self.OperationID = NLOperationPostMessage;
	[[oSettings sharedoSettings] LogThis:@"postMessage URL call = %@?%@", [oSettings sharedoSettings].ServicesURL, @"action=postMessage"];
	if (urlReader == nil)
		urlReader = [[URLReader alloc] init];
	[urlReader setDelegate:self];

	NSMutableString *postData = [[NSMutableString alloc] init];
	[postData setString:@""];
	[postData appendFormat:@"oid=%i", offerID];
	[postData appendFormat:@"&message=%@", msg];

	NSString *xmlData = [urlReader getFromURL:[NSString stringWithFormat:@"%@?%@", [oSettings sharedoSettings].ServicesURL, @"action=postMessage"] postData:postData postMethod:@"POST"];
    if ([oSettings sharedoSettings].syncLog)
        [[oSettings sharedoSettings] LogThis:@"postMessage response = %@", xmlData];
	if (xmlData.length > 0) {
		NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:[xmlData dataUsingEncoding:NSUTF8StringEncoding]];
		[myParser setDelegate:self];
		[myParser setShouldProcessNamespaces:NO];
		[myParser setShouldReportNamespacePrefixes:NO];
		[myParser setShouldResolveExternalEntities:NO];
		[myParser parse];
	}
	else if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(postMessageFinished:)])
		[delegate postMessageFinished:self];
}

- (void)getCategories:(BOOL)doFullSync {
	self.OperationID = NLOperationGetCategories;
	if (doFullSync)
		[[oManagedDBContext sharedoManagedDBContext] deleteAllObjects:@"Category"];
	[[oSettings sharedoSettings] LogThis:@"getCategories URL call = %@?%@", [oSettings sharedoSettings].ServicesURL, @"action=getCategories"];
	if (urlReader == nil)
		urlReader = [[URLReader alloc] init];
	[urlReader setDelegate:self];
	NSString *xmlData = [urlReader getFromURL:[NSString stringWithFormat:@"%@?%@", [oSettings sharedoSettings].ServicesURL, @"action=getCategories"] postData:@"" postMethod:@"GET"];
    if ([oSettings sharedoSettings].syncLog)
        [[oSettings sharedoSettings] LogThis:@"getCategories response = %@", xmlData];
	if (xmlData.length > 0) {
		NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:[xmlData dataUsingEncoding:NSUTF8StringEncoding]];
		[myParser setDelegate:self];
		[myParser setShouldProcessNamespaces:NO];
		[myParser setShouldReportNamespacePrefixes:NO];
		[myParser setShouldResolveExternalEntities:NO];
		[myParser parse];
	}
	else if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(getCategoriesFinished:)])
		[delegate getCategoriesFinished:self];
}

- (void)getNewJobs:(BOOL)doFullSync {
	self.OperationID = NLOperationGetNewJobs;
	if (doFullSync)
		[[oManagedDBContext sharedoManagedDBContext] deleteAllObjects:@"JobOffer"];
	[[oSettings sharedoSettings] LogThis:@"getNewJobs URL call = %@?%@", [oSettings sharedoSettings].ServicesURL, @"action=getNewJobs"];
	if (urlReader == nil)
		urlReader = [[URLReader alloc] init];
	[urlReader setDelegate:self];
	NSString *xmlData = [urlReader getFromURL:[NSString stringWithFormat:@"%@?%@", [oSettings sharedoSettings].ServicesURL, @"action=getNewJobs"] postData:@"" postMethod:@"GET"];
    if ([oSettings sharedoSettings].syncLog)
        [[oSettings sharedoSettings] LogThis:@"getNewJobs response = %@", xmlData];
	if (xmlData.length > 0) {
		NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:[xmlData dataUsingEncoding:NSUTF8StringEncoding]];
		[myParser setDelegate:self];
		[myParser setShouldProcessNamespaces:NO];
		[myParser setShouldReportNamespacePrefixes:NO];
		[myParser setShouldResolveExternalEntities:NO];
		[myParser parse];
	}
	else if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(getNewJobsFinished:)])
		[delegate getNewJobsFinished:self];
}

- (void)searchJobs:(BOOL)doFullSync {
	self.OperationID = NLOperationGetJobsHuman;
	if (doFullSync)
		[[oManagedDBContext sharedoManagedDBContext] deleteObjects:@"JobOffer" predicate:[NSPredicate predicateWithFormat:@"HumanYn = 0"]];
	[[oSettings sharedoSettings] LogThis:@"searchJobs URL call = %@?%@", [oSettings sharedoSettings].ServicesURL, @"action=searchJobs"];
	if (urlReader == nil)
		urlReader = [[URLReader alloc] init];
	[urlReader setDelegate:self];
	NSString *xmlData = [urlReader getFromURL:[NSString stringWithFormat:@"%@?%@", [oSettings sharedoSettings].ServicesURL, @"action=searchJobs"] postData:@"" postMethod:@"GET"];
    if ([oSettings sharedoSettings].syncLog)
        [[oSettings sharedoSettings] LogThis:@"searchJobs response = %@", xmlData];
	if (xmlData.length > 0) {
		NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:[xmlData dataUsingEncoding:NSUTF8StringEncoding]];
		[myParser setDelegate:self];
		[myParser setShouldProcessNamespaces:NO];
		[myParser setShouldReportNamespacePrefixes:NO];
		[myParser setShouldResolveExternalEntities:NO];
		[myParser parse];
	}
	else if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(getJobsHumanFinished:)])
		[delegate getJobsHumanFinished:self];
}

- (void)searchPeople:(BOOL)doFullSync {
	self.OperationID = NLOperationGetJobsCompany;
	if (doFullSync)
		[[oManagedDBContext sharedoManagedDBContext] deleteObjects:@"JobOffer" predicate:[NSPredicate predicateWithFormat:@"HumanYn = 1"]];
	[[oSettings sharedoSettings] LogThis:@"searchPeople URL call = %@?%@", [oSettings sharedoSettings].ServicesURL, @"action=searchPeople"];
	if (urlReader == nil)
		urlReader = [[URLReader alloc] init];
	[urlReader setDelegate:self];
	NSString *xmlData = [urlReader getFromURL:[NSString stringWithFormat:@"%@?%@", [oSettings sharedoSettings].ServicesURL, @"action=searchPeople"] postData:@"" postMethod:@"GET"];
    if ([oSettings sharedoSettings].syncLog)
        [[oSettings sharedoSettings] LogThis:@"searchPeople response = %@", xmlData];
	if (xmlData.length > 0) {
		NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:[xmlData dataUsingEncoding:NSUTF8StringEncoding]];
		[myParser setDelegate:self];
		[myParser setShouldProcessNamespaces:NO];
		[myParser setShouldReportNamespacePrefixes:NO];
		[myParser setShouldResolveExternalEntities:NO];
		[myParser parse];
	}
	else if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(getJobsCompanyFinished:)])
		[delegate getJobsCompanyFinished:self];
}

- (void)getTextContent {
	self.OperationID = NLOperationGetTextContents;
	[[oManagedDBContext sharedoManagedDBContext] deleteAllObjects:@"TextContent"];
	[[oSettings sharedoSettings] LogThis:@"getTextContent URL call = %@?%@", [oSettings sharedoSettings].ServicesURL, @"action=getTextContent"];
	if (urlReader == nil)
		urlReader = [[URLReader alloc] init];
	[urlReader setDelegate:self];
	NSString *xmlData = [urlReader getFromURL:[NSString stringWithFormat:@"%@?%@", [oSettings sharedoSettings].ServicesURL, @"action=getTextContent"] postData:@"" postMethod:@"GET"];
    if ([oSettings sharedoSettings].syncLog)
        [[oSettings sharedoSettings] LogThis:@"getTextContent response = %@", xmlData];
	if (xmlData.length > 0) {
		NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:[xmlData dataUsingEncoding:NSUTF8StringEncoding]];
		[myParser setDelegate:self];
		[myParser setShouldProcessNamespaces:NO];
		[myParser setShouldReportNamespacePrefixes:NO];
		[myParser setShouldResolveExternalEntities:NO];
		[myParser parse];
	}
	else if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(getTextContentFinished:)])
		[delegate getTextContentFinished:self];
}

- (void)sendEmailMessage:(int)offerID toEmail:(NSString *)toEmail fromEmail:(NSString *)fromEmail {
	self.OperationID = NLOperationSendEmail;
	[[oSettings sharedoSettings] LogThis:@"sendEmailMessage URL call = %@?%@", [oSettings sharedoSettings].ServicesURL, @"action=sendEmailMessage"];
	if (urlReader == nil)
		urlReader = [[URLReader alloc] init];
	[urlReader setDelegate:self];
	
	NSMutableString *postData = [[NSMutableString alloc] init];
	[postData setString:@""];
	[postData appendFormat:@"oid=%i", offerID];
	[postData appendFormat:@"&toemail=%@", toEmail];
	[postData appendFormat:@"&fromemail=%@", fromEmail];
	
	NSString *xmlData = [urlReader getFromURL:[NSString stringWithFormat:@"%@?%@", [oSettings sharedoSettings].ServicesURL, @"action=sendEmailMessage"] postData:postData postMethod:@"POST"];
    if ([oSettings sharedoSettings].syncLog)
        [[oSettings sharedoSettings] LogThis:@"sendEmailMessage response = %@", xmlData];
	if (xmlData.length > 0) {
		NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:[xmlData dataUsingEncoding:NSUTF8StringEncoding]];
		[myParser setDelegate:self];
		[myParser setShouldProcessNamespaces:NO];
		[myParser setShouldReportNamespacePrefixes:NO];
		[myParser setShouldResolveExternalEntities:NO];
		[myParser parse];
	}
	else if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(sendEmailMessageFinished:)])
		[delegate sendEmailMessageFinished:self];
}

- (void)searchOffers:(NSString *)searchTerm freelance:(BOOL)frl {
	self.OperationID = NLOperationSearch;
	[[oSettings sharedoSettings] LogThis:@"searchOffers URL call = %@?%@", [oSettings sharedoSettings].ServicesURL, @"action=searchOffers"];
	if (urlReader == nil)
		urlReader = [[URLReader alloc] init];
	[urlReader setDelegate:self];
	
	NSMutableString *postData = [[NSMutableString alloc] init];
	[postData setString:@""];
	[postData appendFormat:@"keyword=%@", searchTerm];
	[postData appendFormat:@"&freelance=%@", ((frl) ? @"true" : @"false")];
	
	NSString *xmlData = [urlReader getFromURL:[NSString stringWithFormat:@"%@?%@", [oSettings sharedoSettings].ServicesURL, @"action=searchOffers"] postData:postData postMethod:@"POST"];
    if ([oSettings sharedoSettings].syncLog)
        [[oSettings sharedoSettings] LogThis:@"searchOffers response = %@", xmlData];
	if (xmlData.length > 0) {
		NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:[xmlData dataUsingEncoding:NSUTF8StringEncoding]];
		[myParser setDelegate:self];
		[myParser setShouldProcessNamespaces:NO];
		[myParser setShouldReportNamespacePrefixes:NO];
		[myParser setShouldResolveExternalEntities:NO];
		[myParser parse];
	}
	else if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(searchOffersFinished:results:)])
		[delegate searchOffersFinished:self results:searchResults];
}

- (void)geoSearchOffers:(NSString *)searchTerm freelance:(BOOL)frl latitude:(float)lat longitude:(float)lon {
	self.OperationID = NLOperationSearchGeo;
	[[oSettings sharedoSettings] LogThis:@"geoSearchOffers URL call = %@?%@", [oSettings sharedoSettings].ServicesURL, @"action=geoSearchOffers"];
	if (urlReader == nil)
		urlReader = [[URLReader alloc] init];
	[urlReader setDelegate:self];
	
	NSMutableString *postData = [[NSMutableString alloc] init];
	[postData setString:@""];
	[postData appendFormat:@"keyword=%@", searchTerm];
	[postData appendFormat:@"&freelance=%@", ((frl) ? @"true" : @"false")];
	[postData appendFormat:@"&x=%1.6f", lat];
	[postData appendFormat:@"&y=%1.6f", lon];
	
	NSString *xmlData = [urlReader getFromURL:[NSString stringWithFormat:@"%@?%@", [oSettings sharedoSettings].ServicesURL, @"action=geoSearchOffers"] postData:postData postMethod:@"POST"];
    if ([oSettings sharedoSettings].syncLog)
        [[oSettings sharedoSettings] LogThis:@"geoSearchOffers response = %@", xmlData];
	if (xmlData.length > 0) {
		NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:[xmlData dataUsingEncoding:NSUTF8StringEncoding]];
		[myParser setDelegate:self];
		[myParser setShouldProcessNamespaces:NO];
		[myParser setShouldReportNamespacePrefixes:NO];
		[myParser setShouldResolveExternalEntities:NO];
		[myParser parse];
	}
	else if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(geoSearchOffersFinished:results:)])
		[delegate geoSearchOffersFinished:self results:searchResults];
}

#pragma mark -
#pragma mark Events

- (void)urlRequestError:(id)sender errorMessage:(NSString *)errorMessage {
	if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(serviceError:error:)])
		[delegate serviceError:self error:errorMessage];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(serviceError:error:)])
        [delegate serviceError:self error:NSLocalizedString(@"SyncError.XMLError", @"SyncError.XMLError")];
		//[delegate serviceError:self error:[parseError localizedDescription]];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	currentElement = elementName;
	if ([elementName isEqualToString:@"cat"]) {
		entCategory = (dbCategory *)[[oManagedDBContext sharedoManagedDBContext] getEntity:@"Category" predicateString:[NSString stringWithFormat:@"categoryID = %@", [attributeDict objectForKey:@"id"]]];
		if (entCategory == nil)
			entCategory = (dbCategory *)[NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:[[oManagedDBContext sharedoManagedDBContext] managedObjectContext]];
		[entCategory setCategoryID:[NSNumber numberWithInt:[[attributeDict objectForKey:@"id"] intValue]]];
		[entCategory setOffersCount:[NSNumber numberWithInt:[[attributeDict objectForKey:@"cnt"] intValue]]];
	}
	else if ([elementName isEqualToString:@"job"]) {
		entOffer = (dbJobOffer *)[[oManagedDBContext sharedoManagedDBContext] getEntity:@"JobOffer" predicateString:[NSString stringWithFormat:@"offerID = %@", [attributeDict objectForKey:@"id"]]];
		if (entOffer == nil) {
			entOffer = (dbJobOffer *)[NSEntityDescription insertNewObjectForEntityForName:@"JobOffer" inManagedObjectContext:[[oManagedDBContext sharedoManagedDBContext] managedObjectContext]];
			[entOffer setReadYn:[NSNumber numberWithInt:0]];
			[entOffer setSentMessageYn:[NSNumber numberWithInt:0]];
		}
		[entOffer setOfferID:[NSNumber numberWithInt:[[attributeDict objectForKey:@"id"] intValue]]];
		[entOffer setCategoryID:[NSNumber numberWithInt:[[attributeDict objectForKey:@"cid"] intValue]]];
        int h = [[attributeDict objectForKey:@"hm"] intValue];
		[entOffer setHumanYn:[NSNumber numberWithInt:h]];
        if (h == 0)
            [entOffer setOfferIcon:[NSImage imageNamed:@"icon_person"]];
        else
            [entOffer setOfferIcon:[NSImage imageNamed:@"icon_company"]];
		[entOffer setFreelanceYn:[NSNumber numberWithInt:[[attributeDict objectForKey:@"fyn"] intValue]]];
		dbCategory *tc = (dbCategory *)[[oManagedDBContext sharedoManagedDBContext] getEntity:@"Category" predicateString:[NSString stringWithFormat:@"categoryID = %@", [attributeDict objectForKey:@"cid"]]];
		[entOffer setCategory:tc];
	}
	else if ([elementName isEqualToString:@"tctxt"]) {
		entTextContent = (dbTextContent *)[NSEntityDescription insertNewObjectForEntityForName:@"TextContent" inManagedObjectContext:[[oManagedDBContext sharedoManagedDBContext] managedObjectContext]];
		[entTextContent setCID:[NSNumber numberWithInt:[[attributeDict objectForKey:@"id"] intValue]]];
	}
	else if ([elementName isEqualToString:@"sores"]) {
		searchSingle = [[SearchOffer alloc] init];
		searchSingle.OfferID = [[attributeDict objectForKey:@"id"] intValue];
		searchSingle.CategoryID = [[attributeDict objectForKey:@"cid"] intValue];
		searchSingle.HumanYn = [[attributeDict objectForKey:@"hm"] boolValue];
        searchSingle.FreelanceYn = [[attributeDict objectForKey:@"fyn"] boolValue];
		searchSingle.gLatitude = [[attributeDict objectForKey:@"glat"] floatValue];
		searchSingle.gLongitude = [[attributeDict objectForKey:@"glong"] floatValue];
		searchSingle.ReadYn = NO;
		searchSingle.SentMessageYn = NO;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"sores"]) {
		if (searchResults == nil)
			searchResults = [[NSMutableArray alloc] init];
		[searchResults addObject:searchSingle];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
		// Categories
		if ([currentElement isEqualToString:@"cttl"])
			[entCategory setCategoryTitle:string];
		// Job offers
		else if ([currentElement isEqualToString:@"jottl"])
			[entOffer setTitle:string];
		else if ([currentElement isEqualToString:@"jocat"])
			[entOffer setCategoryTitle:string];
		else if ([currentElement isEqualToString:@"jopos"])
			[entOffer setPositivism:string];
		else if ([currentElement isEqualToString:@"joneg"])
			[entOffer setNegativism:string];
		else if ([currentElement isEqualToString:@"joem"])
			[entOffer setEmail:string];
		else if ([currentElement isEqualToString:@"jodt"]) {
			NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
			[entOffer setPublishDate:[df dateFromString:string]];
		}
		// Post new job offer
		else if ([currentElement isEqualToString:@"postNewJob"]) {
			[oSettings sharedoSettings].currentPostOfferResult = [string boolValue];
			[oSettings sharedoSettings].currentPostOfferResponse = string;
		}
		// Text content
		else if ([currentElement isEqualToString:@"tctitle"])
			[entTextContent setTitle:string];
		else if ([currentElement isEqualToString:@"tccontent"])
			[entTextContent setContent:string];
		// Search
		else if ([currentElement isEqualToString:@"sottl"])
			searchSingle.Title = string;
		else if ([currentElement isEqualToString:@"socat"])
			searchSingle.CategoryTitle = string;
		else if ([currentElement isEqualToString:@"sopos"])
			searchSingle.Positivism = string;
		else if ([currentElement isEqualToString:@"soneg"])
			searchSingle.Negativism = string;
		else if ([currentElement isEqualToString:@"soem"])
			searchSingle.Email = string;
		else if ([currentElement isEqualToString:@"sodt"]) {
			NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
			searchSingle.PublishDate = [df dateFromString:string];
		}
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	if (self.OperationID != NLOperationPostJob &&
		self.OperationID != NLOperationPostMessage &&
		self.OperationID != NLOperationSearch &&
		self.OperationID != NLOperationSearchGeo &&
		self.OperationID != NLOperationSendEmail) {
		if (![[oManagedDBContext sharedoManagedDBContext] save])
			abort();
	}
	switch (self.OperationID) {
		case NLOperationPostJob: {
			if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(postJobFinished:)])
				[delegate postJobFinished:self];
			break;
		}
		case NLOperationPostMessage: {
			if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(postMessageFinished:)])
				[delegate postMessageFinished:self];
			break;
		}
		case NLOperationGetCategories: {
			if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(getCategoriesFinished:)])
				[delegate getCategoriesFinished:self];
			break;
		}
		case NLOperationGetNewJobs: {
			if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(getNewJobsFinished:)])
				[delegate getNewJobsFinished:self];
			break;
		}
		case NLOperationGetJobsHuman: {
			if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(getJobsHumanFinished:)])
				[delegate getJobsHumanFinished:self];
			break;
		}
		case NLOperationGetJobsCompany: {
			if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(getJobsCompanyFinished:)])
				[delegate getJobsCompanyFinished:self];
			break;
		}
		case NLOperationGetTextContents: {
			if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(getTextContentFinished:)])
				[delegate getTextContentFinished:self];
			break;
		}
		case NLOperationSearch: {
			if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(searchOffersFinished:results:)])
				[delegate searchOffersFinished:self results:searchResults];
			break;
		}
		case NLOperationSearchGeo: {
			if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(geoSearchOffersFinished:results:)])
				[delegate geoSearchOffersFinished:self results:searchResults];
			break;
		}
		case NLOperationSendEmail: {
			if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(sendEmailMessageFinished:)])
				[delegate sendEmailMessageFinished:self];
			break;
		}
		default:
			break;
	}
}

#pragma mark -
#pragma mark Delegates

- (id<WebServiceDelegate>)delegate {
    return delegate;
}

- (void)setDelegate:(id<WebServiceDelegate>)newDelegate {
    delegate = newDelegate;
}

@end