//
// Created by Jabari on 11/16/13.
// Copyright (c) 2013 The New York Times Company. All rights reserved.
//


#import "NYTArticleCommunicator.h"
#import "RACSignal.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

NSString *const kURLtoRetrieve = @"http://mobile.public.ec2.nytimes.com.s3-website-us-east-1.amazonaws.com/candidates/content/v1/articles.plist";


@implementation NYTArticleCommunicator

- (RACSignal *)retrieveArticles
{
    _fetchingURL = [NSURL URLWithString:kURLtoRetrieve];
    NSArray *articlesArray = [NSArray arrayWithContentsOfURL:_fetchingURL];
    return [articlesArray.rac_sequence.signal deliverOn:[RACScheduler scheduler]];
}

@end