//
//  MNEdge+NSCoding.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/3/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNEdge+NSCoding.h"
#import "MNEdge.h"

@implementation MNEdge (NSCoding)

#pragma mark - NSCodying

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.firstStation = [aDecoder decodeObjectForKey:@"firstStation"];
        self.secondStation = [aDecoder decodeObjectForKey:@"secondStation"];
        self.duration = [aDecoder decodeObjectForKey:@"duration"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.firstStation forKey:@"firstStation"];
    [aCoder encodeObject:self.secondStation forKey:@"secondStation"];
    [aCoder encodeObject:self.duration forKey:@"duration"];
}


@end
