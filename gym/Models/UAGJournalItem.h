//
//  UAGJournalTraining.h
//  gym
//
//  Created by Artem Ustimov on 11/23/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import "UAGTraining.h"

@interface UAGJournalItem : RLMObject <NSCopying>

@property (nonatomic) NSString * name;

@property (nonatomic) NSDate * date;

@property (nonatomic) UAGTraining * training;

@property (nonatomic) NSString * image;

@property (nonatomic, getter=isPhoto) BOOL photo;

@property (nonatomic) double order;

@property (nonatomic) int rotationAngle;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToItem:(UAGJournalItem *)item;

- (NSUInteger)hash;

@end
