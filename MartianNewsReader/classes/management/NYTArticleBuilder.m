//
// Created by Jabari on 11/17/13.
// Copyright (c) 2013 The New York Times Company. All rights reserved.
//


#import "NYTArticleBuilder.h"
#import "NYTArticle.h"


@implementation NYTArticleBuilder

- (NSArray *)buildArticles:(NSArray *)articles
{
    NYTArticle *article = [[NYTArticle alloc] init];
    NSMutableArray *articlesToReturn = [NSMutableArray array];
    for (NSDictionary *dict in articles) {
        NYTArticle *artcpy = [article mutableCopy];
        artcpy.body = [dict objectForKey:@"body"];
        artcpy.title = [dict objectForKey:@"title"];
        artcpy.images = [dict objectForKey:@"images"];
        [articlesToReturn addObject:artcpy];
    }
    return articlesToReturn;
}

@end