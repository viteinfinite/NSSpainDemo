//
// Created by Simone Civetta on 17/09/14.
// Copyright (c) 2014 SimoneCivetta. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDLoveGenerator : NSObject
- (instancetype)initWithLoveCount:(NSInteger)repetitionCount;

- (NSString *)giveMeSomeLove;

+ (instancetype)generatorWithRepetitionCount:(NSInteger)repetitionCount;


@end