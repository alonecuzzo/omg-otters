//
// Created by Jabari on 11/17/13.
// Copyright (c) 2013 The New York Times Company. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NYTArticle : NSObject<NSMutableCopying>

@property(nonatomic) NSString *title;
@property(nonatomic) NSString *body;
@property(nonatomic) NSArray *images;

@end