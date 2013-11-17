//
// Created by Jabari on 11/17/13.
// Copyright (c) 2013 The New York Times Company. All rights reserved.
//


#import "NYTArticle.h"
#import "NYTArticleImage.h"


@implementation NYTArticle

- (id)mutableCopyWithZone:(NSZone *)zone
{
    NYTArticle *article = [[[self class] allocWithZone:zone] init];
    return article;
}

@end