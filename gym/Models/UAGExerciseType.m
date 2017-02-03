//
//  UAGExerciseType.m
//  gym
//
//  Created by Artem Ustimov on 11/10/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import "UAGExerciseType.h"

@implementation UAGExerciseType

+ (NSString *)primaryKey {
    return @"id";
}

- (instancetype)initWithName:(NSString *)name id:(long)id {
    self = [super init];
    if (self) {
        _name = name;
        _id = id;
    }
    return self;
}

- (instancetype)init {
    return [self initWithName:@"Exercise name is not set" id:0];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToType:other];
}

- (BOOL)isEqualToType:(UAGExerciseType *)type {
    if (self == type)
        return YES;
    if (type == nil)
        return NO;
    if (self.id != type.id)
        return NO;
    if (self.name != type.name && ![self.name isEqualToString:type.name])
        return NO;
    if (self.exercises != type.exercises && [self.exercises count] != [type.exercises count])
        return NO;
    for (int i = 0; i < [self.exercises count]; i++) {
        if (![self.exercises[i] isEqual:type.exercises[i]]) {
            return NO;
        }
    }
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.id;
    hash = hash * 31u + [self.name hash];
    hash = hash * 31u + [self.exercises hash];
    return hash;
}


@end
