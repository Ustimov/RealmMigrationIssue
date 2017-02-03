//
//  UAGJournalTraining.m
//  gym
//
//  Created by Artem Ustimov on 11/23/16.
//  Copyright © 2016 Artem Ustimov. All rights reserved.
//

#import "UAGJournalItem.h"

@implementation UAGJournalItem

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToItem:other];
}

- (BOOL)isEqualToItem:(UAGJournalItem *)item {
    if (self == item)
        return YES;
    if (item == nil)
        return NO;
    if (self.name != item.name && ![self.name isEqualToString:item.name])
        return NO;
    if (self.date != item.date && ![self.date isEqualToDate:item.date])
        return NO;
    if (self.training != item.training && ![self.training isEqualToTraining:item.training])
        return NO;
    if (self.image != item.image && ![self.image isEqualToString:item.image])
        return NO;
    if (self.photo != item.photo)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.name hash];
    hash = hash * 31u + [self.date hash];
    hash = hash * 31u + [self.training hash];
    hash = hash * 31u + [self.image hash];
    hash = hash * 31u + self.photo;
    return hash;
}

- (id)copyWithZone:(NSZone *)zone {
    UAGJournalItem * item = [[UAGJournalItem alloc] init];

    item.name = [self.name copy];
    item.date = [self.date copy];
    item.training = [self.training copy];
    item.image = [self.image copy];
    item.photo = self.photo;
    item.order = self.order;
    item.rotationAngle = self.rotationAngle;
    
    return item;
}

@end
