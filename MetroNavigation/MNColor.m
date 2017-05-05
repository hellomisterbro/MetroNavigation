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

- (id)copyWithZone:(NSZone *)zone {
    
    MNColor *color = [MNColor new];
    
    color.red = self.red;
    color.green = self.green;
    color.blue = self.red;
    
    return color;
}

@end
