//
// Created by Jabari on 11/16/13.
// Copyright (c) 2013 The New York Times Company. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NYTArticleCommunicator : NSObject
{
@protected
    NSURL *_fetchingURL;
    NSURLConnection *_fetchingConnection;
}

- (void)retrieveArticles;
- (NSURLConnection*)currentURLConnection;
- (void)cancelAndDiscardConnection;

@end