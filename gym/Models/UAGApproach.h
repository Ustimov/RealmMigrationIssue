//
//  UAGApproach.h
//  gym
//
//  Created by Artem Ustimov on 11/18/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface UAGApproach : RLMObject <NSCopying>

@property (nonatomic) NSInteger approaches;

@property (nonatomic) NSInteger repeats;

@property (nonatomic) NSInteger weight;

- (instancetype)initWithApproaches:(NSInteger)approaches repeats:(NSInteger)repeats weight:(NSInteger)weight;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToApproach:(UAGApproach *)approach;

- (NSUInteger)hash;

@end

RLM_ARRAY_TYPE(UAGApproach)
