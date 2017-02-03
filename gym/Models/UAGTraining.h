//
//  UAGTraining.h
//  gym
//
//  Created by Artem Ustimov on 11/12/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "UAGExerciseContainer.h"

@interface UAGTraining : RLMObject <NSCopying>

@property (nonatomic) int id;

@property (nonatomic) NSString * name;

@property (nonatomic, getter=isJournaled) BOOL journaled;

@property (nonatomic) RLMArray<UAGExerciseContainer *><UAGExerciseContainer> * exerciseContainers;

@property (nonatomic, getter=isSelected) BOOL selected;

@property (nonatomic) double order;

@property (nonatomic) double favouriteOrder;

@property (nonatomic, getter=isDeleted) BOOL deleted;

- (instancetype)initWithName:(NSString *)name;

- (void)addExerciseContainer:(UAGExerciseContainer *)exerciseContainer;

- (UAGExerciseContainer *)getExerciseContainer:(NSInteger)position;

- (void)removeExerciseContainer:(NSInteger)position;

- (void)moveExerciseContainerAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToTraining:(UAGTraining *)training;

- (NSUInteger)hash;

@end
