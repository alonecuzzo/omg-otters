//
//  NYTCommunicatorTests.m
//  MartianNewsReader
//
//  Created by Jabari on 11/17/13.
//  Copyright (c) 2013 The New York Times Company. All rights reserved.
//

#import "NYTCommunicatorTests.h"
#import "NYTInspectableArticleCommunicator.h"

@interface NYTCommunicatorTests()

@property(nonatomic) NYTInspectableArticleCommunicator *communicator;

@end

@implementation NYTCommunicatorTests

- (void)setUp
{
    [super setUp];

    _communicator = [[NYTInspectableArticleCommunicator alloc] init];

}

- (void)tearDown
{
    _communicator = nil;

   [super tearDown];
}

- (void)testSearchingForArticleDataOnNYTimesAPI
{
   [_communicator retrieveArticles];
    XCTAssertEqualObjects([[_communicator URLToFetch] absoluteString], @"http://mobile.public.ec2.nytimes.com.s3-website-us-east-1.amazonaws.com/candidates/content/v1/articles.plist", @"Communicator URL should equal the provided plist URL.");
}

- (void)testSearchingForArticleDataOpensURLConnection
{
    [_communicator retrieveArticles];
    XCTAssertNotNil([_communicator currentURLConnection], @"Communicator should create NSURLConnection when retrieving articles.");
}


@end
