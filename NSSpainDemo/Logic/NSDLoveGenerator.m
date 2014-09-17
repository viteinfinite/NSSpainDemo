//
// Created by Simone Civetta on 17/09/14.
// Copyright (c) 2014 SimoneCivetta. All rights reserved.
//

#import "NSDLoveGenerator.h"

@interface NSDLoveGenerator ()

@property (nonatomic, assign) NSInteger repetitionCount;

@end

@implementation NSDLoveGenerator

- (instancetype)initWithLoveCount:(NSInteger)repetitionCount
{
    self = [super init];
    if (self) {
        self.repetitionCount = repetitionCount;
    }

    return self;
}

+ (instancetype)generatorWithRepetitionCount:(NSInteger)repetitionCount
{
    return [[self alloc] initWithLoveCount:repetitionCount];
}

- (NSString *)giveMeSomeLove
{
    NSMutableString *string = [NSMutableString string];
    for (NSInteger idx = 0; idx < self.repetitionCount; idx++) {
        [string appendString:@"love"];
    }
    return string;
}

@end