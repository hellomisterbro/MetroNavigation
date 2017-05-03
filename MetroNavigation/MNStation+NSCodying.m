//
//  MNStation+NSCodying.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/3/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNStation+NSCodying.h"

@implementation MNStation (NSCodying) 


#pragma mark - NSCodying

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.identifier = [aDecoder decodeObjectForKey:@"identifier"];
        self.posX = [aDecoder decodeObjectForKey:@"posX"];
        self.posY = [aDecoder decodeObjectForKey:@"posY"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
    [aCoder encodeObject:self.posX forKey:@"posX"];
    [aCoder encodeObject:self.posY forKey:@"posY"];
}

@end
