//
//  UAGExerciseContainer.h
//  gym
//
//  Created by Artem Ustimov on 11/22/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "UAGExercise.h"
#import "UAGApproach.h"

@interface UAGExerciseContainer : RLMObject <NSCopying>

@property (nonatomic) UAGExercise * exercise;

@property (nonatomic) RLMArray<UAGApproach *><UAGApproach> * approaches;

@property (nonatomic) BOOL completed;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToContainer:(UAGExerciseContainer *)container;

- (NSUInteger)hash;

@end

RLM_ARRAY_TYPE(UAGExerciseContainer)
