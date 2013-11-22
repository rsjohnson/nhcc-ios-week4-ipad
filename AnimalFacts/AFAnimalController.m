//
//  AFAnimalController.m
//  AnimalFacts
//
//  Created by Ryan Johnson on 11/18/13.
//  Copyright (c) 2013 Jacob Good. All rights reserved.
//

#import "AFAnimalController.h"

@interface AFAnimalController ()
{
    NSMutableArray * _animals;
}
@end

@implementation AFAnimalController

+ (instancetype) sharedController {
    static AFAnimalController * sharedController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[self alloc] init];
    });
    return sharedController;
}

- (id) init {
    self = [super init];
    if (self) {
        _animals = [NSMutableArray array];
    }
    return self;
}

- (NSArray*) animals {
    return [NSArray arrayWithArray:_animals];
}

- (void) addAnimal:(AFAnimal *)animal {
    [self willChange:NSKeyValueChangeInsertion
     valuesAtIndexes:[NSIndexSet indexSetWithIndex:_animals.count] forKey:@"animals"];
    [_animals addObject:animal];
    [_animals sortedArrayUsingSelector:@selector(compare:)];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:[NSIndexSet indexSetWithIndex:_animals.count -1] forKey:@"animals"];
}


@end
