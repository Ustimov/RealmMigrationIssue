//
//  UAGExerciseContainer.m
//  gym
//
//  Created by Artem Ustimov on 11/22/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import "UAGExerciseContainer.h"

@implementation UAGExerciseContainer

- (instancetype)init {
    self = [super init];
    if (self) {
        // Do nothing
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    UAGExerciseContainer * exerciseContainer = [[UAGExerciseContainer alloc] init];
    exerciseContainer.completed = self.completed;
    exerciseContainer.exercise = [self.exercise copy];
    
    for (id approach in self.approaches) {
        [exerciseContainer.approaches addObject:[approach copy]];
    }
        
    return exerciseContainer;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToContainer:other];
}

- (BOOL)isEqualToContainer:(UAGExerciseContainer *)container {
    if (self == container)
        return YES;
    if (container == nil)
        return NO;
    if (self.exercise != container.exercise && ![self.exercise isEqualToExercise:container.exercise])
        return NO;
    if (self.approaches != container.approaches && [self.approaches count] != [container.approaches count])
        return NO;
    if (self.completed != container.completed)
        return NO;
    for (int i = 0; i < [self.approaches count]; i++) {
        if (![self.approaches[i] isEqual:container.approaches[i]]) {
            return NO;
        }
    }
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.exercise hash];
    hash = hash * 31u + [self.approaches hash];
    hash = hash * 31u + self.completed;
    return hash;
}

@end
