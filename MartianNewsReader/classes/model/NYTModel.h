//
//  NYTModel.h
//  MartianNewsReader
//
//  Created by Jabari on 11/17/13.
//  Copyright (c) 2013 The New York Times Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYTModel : NSObject

@property(nonatomic, strong) NSArray *articles;

+ (id)sharedInstance;

@end
