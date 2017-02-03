//
//  UAGApproach.m
//  gym
//
//  Created by Artem Ustimov on 11/18/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import "UAGApproach.h"

@implementation UAGApproach

- (instancetype)initWithApproaches:(NSInteger)approaches repeats:(NSInteger)repeats weight:(NSInteger)weight {
    self = [super init];
    if (self) {
        self.approaches = approaches;
        self.repeats = repeats;
        self.weight = weight;
    }
    return self;
}

- (instancetype)init {
    return [self initWithApproaches:0 repeats:0 weight:0];
}

- (id)copyWithZone:(NSZone *)zone {
    UAGApproach * approach = [[UAGApproach alloc] initWithApproaches:self.approaches repeats:self.repeats weight:self.weight];
    return approach;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToApproach:other];
}

- (BOOL)isEqualToApproach:(UAGApproach *)approach {
    if (self == approach)
        return YES;
    if (approach == nil)
        return NO;
    if (self.approaches != approach.approaches)
        return NO;
    if (self.repeats != approach.repeats)
        return NO;
    if (self.weight != approach.weight)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.approaches;
    hash = hash * 31u + self.repeats;
    hash = hash * 31u + self.weight;
    return hash;
}


@end
