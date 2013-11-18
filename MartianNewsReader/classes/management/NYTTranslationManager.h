//
//  NYTTranslationManager.h
//  MartianNewsReader
//
//  Created by Jabari on 11/17/13.
//  Copyright (c) 2013 The New York Times Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYTArticleManager.h"

typedef enum : u_int8_t {
    NYTLabelTypeTitle = 0,
    NYTLabelTypeBody
} NYTLabelType;

@interface NYTTranslationManager : NSObject

@property(assign) BOOL isMartian;
@property(nonatomic) NYTArticleManager *articleManager;

+ (id)sharedInstance;
- (void)toggleMartianTranslation;
- (NSString*)translateText:(NSString*)text forIndex:(uint)index andType:(NYTLabelType)labelType;

@end
