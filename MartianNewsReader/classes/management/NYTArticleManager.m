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
#import "NYTModel.h"

@interface NYTArticleManager()

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
    NSMutableArray *tmpArray = [NSMutableArray array];
    RACSignal *communicatorSignal = [_communicator retrieveArticles];
    RACSignal *signalToReturn = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        [communicatorSignal subscribeNext:^(NSArray *data) {
            [tmpArray addObject:data];
        } error:^(NSError *error){
            [subscriber sendError:error];
        } completed:^{
            [[NYTModel sharedInstance] setArticles:[_builder buildArticles:tmpArray]];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    return [signalToReturn deliverOn:[RACScheduler scheduler]];
}

- (NSInteger)articleCount
{
    return ([self articles]) ? [[self articles] count] : 0;
}

- (NSArray *)articles
{
    return [[NYTModel sharedInstance] articles];
}

- (NYTArticle *)articleAtIndex:(NSUInteger)index
{
    return (NYTArticle *)[[self articles] objectAtIndex:index];
}

@end
