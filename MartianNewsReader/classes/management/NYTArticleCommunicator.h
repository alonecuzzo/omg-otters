//
// Created by Jabari on 11/16/13.
// Copyright (c) 2013 The New York Times Company. All rights reserved.
//


#import <Foundation/Foundation.h>

@class RACSignal;


@interface NYTArticleCommunicator : NSObject
{
@protected
    NSURL *_fetchingURL;
}

- (RACSignal *)retrieveArticles;

@end