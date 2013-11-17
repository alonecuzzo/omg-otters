//
//  NYTInspectableArticleCommunicator.m
//  MartianNewsReader
//
//  Created by Jabari on 11/16/13.
//  Copyright (c) 2013 The New York Times Company. All rights reserved.
//

#import "NYTInspectableArticleCommunicator.h"

@implementation NYTInspectableArticleCommunicator

- (NSURL *)URLToFetch
{
    return _fetchingURL;
}

@end
