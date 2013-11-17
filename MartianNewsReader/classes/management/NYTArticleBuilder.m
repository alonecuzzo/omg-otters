//
// Created by Jabari on 11/17/13.
// Copyright (c) 2013 The New York Times Company. All rights reserved.
//


#import "NYTArticleBuilder.h"
#import "NYTArticle.h"
#import "NYTArticleImage.h"


@implementation NYTArticleBuilder

- (NSArray *)buildArticles:(NSArray *)articles
{
    NYTArticle *article = [[NYTArticle alloc] init];
    NSMutableArray *articlesToReturn = [NSMutableArray array];
    for (NSDictionary *dict in articles) {
        NYTArticle *artcpy = [article mutableCopy];
        artcpy.body = [dict objectForKey:@"body"];
        artcpy.title = [dict objectForKey:@"title"];
        NYTArticleImage *image = [[NYTArticleImage alloc] init];

        for(NSDictionary *imgDict in [dict objectForKey:@"images"]) {
            if ([imgDict objectForKey:@"top_image"]) {
                image.size = CGSizeMake([[imgDict objectForKey:@"width"] floatValue],[[imgDict objectForKey:@"height"] floatValue]);

                image.url = [NSURL URLWithString:
                [imgDict objectForKey:@"url"]];
            }
        }

        artcpy.image = image;
        [articlesToReturn addObject:artcpy];
    }
    return articlesToReturn;
}

@end