//
//  NYTArticleManager.m
//  MartianNewsReader
//

//  Copyright (c) 2012 The New York Times Company. All rights reserved.
//

#import "NYTArticleManager.h"
#import "NYTArticle.h"
#import "NYTArticleCommunicator.h"
#import "NYTArticleBuilder.h"

@interface NYTArticleManager()

@property(nonatomic) NSArray *articles;
@property(nonatomic) NYTArticleCommunicator *communicator;
@property(nonatomic) NYTArticleBuilder *builder;

@end


@implementation NYTArticleManager

- (id)initWithArticles:(NSArray *)someArticles
{
    //do nothing, we get our articles from the communicator
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        _communicator = [[NYTArticleCommunicator alloc] init];
        _builder = [[NYTArticleBuilder alloc] init];
    }
    return self;
}

- (RACSignal *)retrieveArticles
{
    RACSignal *communicatorSignal = [_communicator retrieveArticles];
    RACSignal *signalToReturn = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        [communicatorSignal subscribeNext:^(NSArray *data) {
            _articles = [_builder buildArticles:data];
        } error:^(NSError *error){
            [subscriber sendError:error];
        } completed:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    return signalToReturn;
}

- (NSInteger)articleCount
{
    return [_articles count];
}

- (NYTArticle *)articleAtIndex:(NSInteger)index
{
    return (NYTArticle *)[_articles objectAtIndex:index];
}

@end
