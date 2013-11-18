//
//  NYTMockTranslationManager.m
//  MartianNewsReader
//
//  Created by Jabari on 11/18/13.
//  Copyright (c) 2013 The New York Times Company. All rights reserved.
//

#import "NYTMockTranslationManager.h"
#import "NYTArticle.h"

@implementation NYTMockTranslationManager

- (NSString*)translateText:(NSString*)text withArticlesArray:(NSArray*)articles atIndex:(uint)index andLabelType:(NYTLabelType)labelType
{
    NSString *returnText;
    NYTArticle *article = (NYTArticle*)[articles objectAtIndex:index];
    switch (labelType) {
        case NYTLabelTypeTitle:
            returnText = article.title;
            break;
            
        case NYTLabelTypeBody:
            returnText = article.body;
            break;
            
        default:
            break;
    }
    return returnText;
}

@end
