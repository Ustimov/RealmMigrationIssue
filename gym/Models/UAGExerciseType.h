//
//  UAGExerciseType.h
//  gym
//
//  Created by Artem Ustimov on 11/10/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "UAGExercise.h"

@interface UAGExerciseType : RLMObject <NSCopying>

@property (nonatomic) long id;

@property (nonatomic) NSString * name;

@property (nonatomic) RLMArray<UAGExercise *><UAGExercise> * exercises;

- (instancetype)initWithName:(NSString *)name id:(long)id;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToType:(UAGExerciseType *)type;

- (NSUInteger)hash;

@end
