//
//  MNColor.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/5/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNColor.h"

@implementation MNColor

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
    
    if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToColor:other];
}

- (BOOL)isEqualToColor:(MNColor *)aColor {
    if (self == aColor)
        return YES;
    
    if (![self.red isEqualToNumber:aColor.red]) {
        return NO;
    }
    
    if (![self.green isEqualToNumber:aColor.green]) {
        return NO;
    }
    
    if (![self.blue isEqualToNumber:aColor.blue]) {
        return NO;
    }
    
    return YES;
}

// MARK: - NSCoping

- (id)copyWithZone:(NSZone *)zone {
    
    MNColor *color = [MNColor new];
    
    color.red = self.red;
    color.green = self.green;
    color.blue = self.red;
    
    return color;
}

// MARK: - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.red = [aDecoder decodeObjectForKey:@"red"];
        self.green = [aDecoder decodeObjectForKey:@"green"];
        self.blue = [aDecoder decodeObjectForKey:@"blue"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.red forKey:@"red"];
    [aCoder encodeObject:self.green forKey:@"green"];
    [aCoder encodeObject:self.blue forKey:@"blue"];
}

@end
