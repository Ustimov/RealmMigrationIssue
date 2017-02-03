//
//  UAGTraining.m
//  gym
//
//  Created by Artem Ustimov on 11/12/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAGTraining.h"

@implementation UAGTraining

+ (NSString *)primaryKey {
    return @"id";
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (instancetype)init {
    return [self initWithName:@"Training name not set"];
}

- (void)addExerciseContainer:(UAGExerciseContainer *)exerciseContainer {
    RLMRealm * realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [self.exerciseContainers addObject:exerciseContainer];
    [realm commitWriteTransaction];
}

- (UAGExerciseContainer *)getExerciseContainer:(NSInteger)position {
    [self checkForOutOfRange:position];
    return self.exerciseContainers[position];
}

- (void)removeExerciseContainer:(NSInteger)position {
    [self checkForOutOfRange:position];
    RLMRealm * realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [self.exerciseContainers removeObjectAtIndex:position];
    [realm commitWriteTransaction];
}

- (void)checkForOutOfRange:(NSInteger)position {
    if ([self.exerciseContainers count] >= position) {
        NSLog(@"[UAGTraining] Exercises out of range");
    }
}

- (void)moveExerciseContainerAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    UAGExerciseContainer * exerciseContainer = self.exerciseContainers[fromIndex];
    [self.exerciseContainers removeObjectAtIndex:fromIndex];
    [self.exerciseContainers insertObject:exerciseContainer atIndex:toIndex];
}

- (id)copyWithZone:(NSZone *)zone {
    UAGTraining * training = [[UAGTraining alloc] initWithName:[self.name copy]];
    training.selected = self.isSelected;
    training.order = self.order;
    training.favouriteOrder = self.favouriteOrder;
    training.id = self.id;
    training.deleted = self.deleted;
    for (id exerciseContainer in self.exerciseContainers) {
        [training addExerciseContainer:[exerciseContainer copy]];
    }
    
    return training;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToTraining:other];
}

- (BOOL)isEqualToTraining:(UAGTraining *)training {
    if (self == training)
        return YES;
    if (training == nil)
        return NO;
    if (self.id != training.id)
        return NO;
    if (self.name != training.name && ![self.name isEqualToString:training.name])
        return NO;
    if (self.journaled != training.journaled)
        return NO;
    if (self.deleted != training.deleted)
        return NO;
    if (self.exerciseContainers != training.exerciseContainers && [self.exerciseContainers count] != [training.exerciseContainers count])
        return NO;
    for (int i = 0; i < [self.exerciseContainers count]; i++) {
        if (![self.exerciseContainers[i] isEqual:training.exerciseContainers[i]]) {
            return NO;
        }
    }
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.id;
    hash = hash * 31u + [self.name hash];
    hash = hash * 31u + self.journaled;
    hash = hash * 31u + [self.exerciseContainers hash];
    return hash;
}

@end
