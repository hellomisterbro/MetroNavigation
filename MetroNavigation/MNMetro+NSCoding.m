//
//  MNMetro+NSCoding.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/3/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNMetro+NSCoding.h"

@implementation MNMetro (NSCoding)

#pragma mark - NSCodying

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.stations = [aDecoder decodeObjectForKey:@"stations"];
        self.edges = [aDecoder decodeObjectForKey:@"edges"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.stations forKey:@"stations"];
    [aCoder encodeObject:self.edges forKey:@"edges"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
}



@end
