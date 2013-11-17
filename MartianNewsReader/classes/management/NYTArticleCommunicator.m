//
// Created by Jabari on 11/16/13.
// Copyright (c) 2013 The New York Times Company. All rights reserved.
//


#import "NYTArticleCommunicator.h"

NSString *const kURLtoRetrieve = @"http://mobile.public.ec2.nytimes.com.s3-website-us-east-1.amazonaws.com/candidates/content/v1/articles.plist";


@implementation NYTArticleCommunicator

- (void)retrieveArticles
{
    _fetchingURL = [NSURL URLWithString:kURLtoRetrieve];
}

@end