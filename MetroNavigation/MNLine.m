//
//  MNLine.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/5/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNLine.h"


@implementation MNLine 

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
    
    if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToLine:other];
}

- (BOOL)isEqualToLine:(MNLine *)aLine {
    if (self == aLine)
        return YES;
    
    if (![self.color isEqual:aLine.color]) {
        return NO;
    }
    
    if (![self.name isEqual:aLine.name]) {
        return NO;
    }
    
    return YES;
}

// MARK: - NSCoping

- (id)copyWithZone:(NSZone *)zone {
    MNLine *line = [MNLine new];
    
    line.name = self.name;
    line.color = self.color;
    
    return line;
}

// MARK: - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.color = [aDecoder decodeObjectForKey:@"colors"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.color forKey:@"colors"];
}

@end
