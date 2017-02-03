//
//  UAGExercise.h
//  gym
//
//  Created by Artem Ustimov on 11/10/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class UAGExerciseType;

@interface UAGExercise : RLMObject <NSCopying>

@property (nonatomic) long id;

@property (nonatomic) NSString * name;

@property (nonatomic) NSString * shortDescription;

@property (nonatomic) NSString * image;

@property (nonatomic) UAGExerciseType * type; // UAGExerciseType ID

- (instancetype)initWithName:(NSString *)name
            shortDescription:(NSString *)shortDescription
                        type:(UAGExerciseType *)type
                       image:(NSString *)image
                          id:(long)id;

- (instancetype)initWithName:(NSString *)name shortDescription:(NSString *)shortDescription;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToExercise:(UAGExercise *)exercise;

- (NSUInteger)hash;

@end

RLM_ARRAY_TYPE(UAGExercise)
