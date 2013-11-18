//
//  NYTArticleListProviderTests.m
//  MartianNewsReader
//

//  Copyright (c) 2012 The New York Times Company. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NYTMockArticleManager.h"
#import "NYTMockTranslationManager.h"
#import "NYTArticle.h"
#import "NYTArticleImage.h"
#import "NYTModel.h"

@interface NYTArticleListProviderTests : XCTestCase

@property(nonatomic) NYTMockTranslationManager *translationManager;
@property(nonatomic) NYTMockArticleManager *articleManager;
@property(nonatomic) NYTArticle *articleToTranslate;

//- (void)assertArticle:(id)article hasMartianTitleText:(NSString *)expectedText;
//- (void)assertArticle:(id)article hasMartianBodyText:(NSString *)expectedText;

@end

@implementation NYTArticleListProviderTests

- (void)setUp
{
    [super setUp];
    
    _articleManager = [[NYTMockArticleManager alloc] init];
    _translationManager = [NYTMockTranslationManager sharedInstance];
    _translationManager.articleManager = _articleManager;
    
    _articleToTranslate = [[NYTArticle alloc] init];
    _articleToTranslate.title = @"Welcome to the Test!";
    _articleToTranslate.body = @"Or if you'd rather, check out The New York Times online.";
    _articleToTranslate.image = [[NYTArticleImage alloc] init];
    
    [_articleManager setArticlesArray:@[_articleToTranslate]];
}

- (void)tearDown
{
    _articleManager = nil;
    _translationManager = nil;
    [super tearDown];
}

#pragma mark - tessts!

- (void)testThatArticleTitleIsTranslatedIntoMartian
{
    [_translationManager setIsMartian:NO];
    NSString *martianTitleString = @"Boinga to the Boinga!";
    NSString *englishTitleString = _articleToTranslate.title;
    NSString *translatedEnglishString = [_translationManager translateText:englishTitleString forIndex:0 andType:NYTLabelTypeTitle];
    XCTAssertTrue([translatedEnglishString isEqualToString:martianTitleString], @"Should translate title properly.");
}

- (void)testThatArticleBodyIsTranslatedIntoMartian
{
    [_translationManager setIsMartian:NO];
    NSString *martianBodyString = @"Or if boinga boinga, boinga out The New Boinga Boinga boinga.";
    NSString *englishTitleString = _articleToTranslate.body;
    NSString *translatedEnglishString = [_translationManager translateText:englishTitleString forIndex:0 andType:NYTLabelTypeBody];
    XCTAssertTrue([translatedEnglishString isEqualToString:martianBodyString], @"Should translate body text properly.");
}

- (void)testThatArticleTitleIsTranslatedIntoEnglish
{
     NSString *englishTitleString = @"Welcome to the Test!";
     NSString *martianTitleString = @"Boinga to the Boinga!";
     NSString *translatedMartianString = [_translationManager translateText:martianTitleString withArticlesArray:[_articleManager articlesArray] atIndex:0 andLabelType:NYTLabelTypeTitle];
     XCTAssertTrue([translatedMartianString isEqualToString:englishTitleString], @"Title should be translated into English");
}

- (void)testThatArticleBodyIsTranslatedIntoEnglish
{
    NSString *englishTitleString = @"Or if you'd rather, check out The New York Times online.";
    NSString *martianTitleString = @"Or if boinga boinga, boinga out The New Boinga Boinga boinga.";
    NSString *translatedMartianString = [_translationManager translateText:martianTitleString withArticlesArray:[_articleManager articlesArray] atIndex:0 andLabelType:NYTLabelTypeBody];
    XCTAssertTrue([translatedMartianString isEqualToString:englishTitleString], @"Body should be translated into English");
}

//- (void)testArticleDataIsTranslated {
//    NSArray *articles =
//  @[
//    @{
//      @"title": @"Welcome to the Test!",
//      @"body": @"Or if you'd rather, check out The New York Times online.",
//      @"images":@[]
//    }
//  ];
//
//    NYTArticleManager *articleListProvider = [[NYTArticleManager alloc] initWithArticles:articles];
//    [self assertArticle:[articleListProvider articleAtIndex:0] hasMartianTitleText:@"Boinga to the Boinga!"];
//    [self assertArticle:[articleListProvider articleAtIndex:0] hasMartianBodyText:@"Or if boinga boinga, boinga out The New Boinga Boinga boinga."];
//}
//
//- (void)assertArticle:(id)article hasMartianTitleText:(NSString *)expectedText {
////    [NSException raise:@"NYTNotYetImplementedException" format:@""];
//}
//
//- (void)assertArticle:(id)article hasMartianBodyText:(NSString *)expectedText {
////    [NSException raise:@"NYTNotYetImplementedException" format:@""];
//}


@end
