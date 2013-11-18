//
//  NYTTranslationManager.m
//  MartianNewsReader
//
//  Created by Jabari on 11/17/13.
//  Copyright (c) 2013 The New York Times Company. All rights reserved.
//

#import "NYTTranslationManager.h"

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

- (NSString*)translateText:(NSString*)text
{
    NSString *returnText = text;
    if (![[NYTTranslationManager sharedInstance] isMartian]) {
       returnText = @"LOLZ";
    } else {
        
    }
    return returnText;
}

@end
