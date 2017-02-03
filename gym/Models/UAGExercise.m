//
//  UAGExercise.m
//  gym
//
//  Created by Artem Ustimov on 11/10/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import "UAGExercise.h"
#import "UAGExerciseType.h"

@implementation UAGExercise

+ (NSString *)primaryKey {
    return @"id";
}

- (instancetype)initWithName:(NSString *)name
            shortDescription:(NSString *)shortDescription
                        type:(UAGExerciseType *)type
                       image:(NSString *)image
                          id:(long)id {
    self = [super init];
    if (self) {
        _name = name;
        _shortDescription = shortDescription;
        _image = image;
        _type = type;
        _id = id;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name shortDescription:(NSString *)shortDescription {
    return [self initWithName:name shortDescription:shortDescription type:nil image:@"" id:0];
}

- (instancetype)init {
    return [self initWithName:@"" shortDescription:@"" type:nil image:@"" id:0];
}

- (NSString *)description {
    if ([self.shortDescription isEqualToString:@"stub"]) {
        return self.name;
    }
    return [NSString stringWithFormat:@"%@ - %@", self.type.name, self.name];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToExercise:other];
}

- (BOOL)isEqualToExercise:(UAGExercise *)exercise {
    if (self == exercise)
        return YES;
    if (exercise == nil)
        return NO;
    if (self.id != exercise.id)
        return NO;
    if (self.name != exercise.name && ![self.name isEqualToString:exercise.name])
        return NO;
    if (self.shortDescription != exercise.shortDescription && ![self.shortDescription isEqualToString:exercise.shortDescription])
        return NO;
    if (self.image != exercise.image && ![self.image isEqualToString:exercise.image])
        return NO;
    if (self.type != exercise.type && ![self.type isEqualToType:exercise.type])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.id;
    hash = hash * 31u + [self.name hash];
    hash = hash * 31u + [self.shortDescription hash];
    hash = hash * 31u + [self.image hash];
    hash = hash * 31u + [self.type hash];
    return hash;
}

@end
