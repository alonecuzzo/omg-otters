//
//  NYTArticleManager.h
//  MartianNewsReader
//

//  Copyright (c) 2012 The New York Times Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@class NYTArticle;

@interface NYTArticleManager : NSObject

// For testing
- (id)initWithArticles:(NSArray *)someArticles;

- (NSInteger)articleCount;
- (NSArray *)articles;
- (NYTArticle *)articleAtIndex:(NSUInteger)index;
- (RACSignal *)retrieveArticles;

@end
