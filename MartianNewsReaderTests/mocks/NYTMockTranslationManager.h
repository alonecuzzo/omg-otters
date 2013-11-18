//
//  NYTMockTranslationManager.h
//  MartianNewsReader
//
//  Created by Jabari on 11/18/13.
//  Copyright (c) 2013 The New York Times Company. All rights reserved.
//

#import "NYTTranslationManager.h"

@interface NYTMockTranslationManager : NYTTranslationManager

- (NSString*)translateText:(NSString*)text withArticlesArray:(NSArray*)articles atIndex:(uint)index andLabelType:(NYTLabelType)labelType;

@end
