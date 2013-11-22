//
//  AFAnimalController.h
//  AnimalFacts
//
//  Created by Ryan Johnson on 11/18/13.
//  Copyright (c) 2013 Jacob Good. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFAnimal;

@interface AFAnimalController : NSObject

+ (instancetype) sharedController;

- (void) addAnimal:(AFAnimal*)animal;
@property (nonatomic, readonly, strong) NSArray *animals;

@end
