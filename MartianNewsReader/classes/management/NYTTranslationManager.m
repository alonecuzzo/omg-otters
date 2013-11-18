//
//  NYTTranslationManager.m
//  MartianNewsReader
//
//  Created by Jabari on 11/17/13.
//  Copyright (c) 2013 The New York Times Company. All rights reserved.
//

#import "NYTTranslationManager.h"
#import "NYTModel.h"
#import "NYTArticle.h"

NSString *const kIsMartianString = @"isMartian";

@implementation NYTTranslationManager

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if (![defaults boolForKey:kIsMartianString]) {
            [defaults setBool:NO forKey:kIsMartianString];
        }
        
        [sharedInstance setIsMartian:[defaults boolForKey:kIsMartianString]];
        [defaults synchronize];
    });
    return sharedInstance;
}

- (void)toggleMartianTranslation
{
    BOOL isMartian = [[NYTTranslationManager sharedInstance] isMartian];
    [[NYTTranslationManager sharedInstance] setIsMartian:!isMartian];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:!isMartian forKey:kIsMartianString];
    [defaults synchronize];
}

- (NSString*)translateText:(NSString*)text forIndex:(uint)index andType:(NYTLabelType)labelType
{
    NSString *returnText = text;
    if (![[NYTTranslationManager sharedInstance] isMartian]) {
        NSArray *explodedString = [text componentsSeparatedByString:@" "];
        NSMutableArray *newStringArray = [NSMutableArray array];
        for (NSString *str in explodedString) {
            if ([str length] > 3) {
                NSString *boingaString;
                if ([[str capitalizedString] isEqualToString:str]) {
                    boingaString = [NSMutableString stringWithString:@"Boinga"];
                } else if ([[str uppercaseString] isEqualToString:str]) {
                    boingaString = [NSMutableString stringWithString:@"BOINGA"];
                } else {
                    boingaString = [NSMutableString stringWithString:@"boinga"];
                }
                if ([[NSCharacterSet symbolCharacterSet] characterIsMember:[str characterAtIndex:0]]) {
                    boingaString = [NSString stringWithFormat:@"%c%@", [str characterAtIndex:0], boingaString];
                }
                if ([[NSCharacterSet punctuationCharacterSet] characterIsMember:[str characterAtIndex:[str length] - 1]]) {
                    boingaString = [NSString stringWithFormat:@"%@%c", boingaString, [str characterAtIndex:[str length] - 1]];
                }
                [newStringArray addObject:boingaString];
            } else {
                [newStringArray addObject:str];
            }
        }
        returnText = [newStringArray componentsJoinedByString:@" "];
    } else {
        NSArray *articles = [[[NYTTranslationManager sharedInstance] articleManager] articles];
        NYTArticle *article = (NYTArticle*)[articles objectAtIndex:index];
        switch (labelType) {
            case NYTLabelTypeTitle:
                returnText = article.title;
                break;
                
            case NYTLableTypeBody:
                returnText = article.body;
                break;
                
            default:
                break;
        }
    }
    return returnText;
}



@end
