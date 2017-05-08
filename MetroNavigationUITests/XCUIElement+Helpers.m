//
//  XCUIElement+Helpers.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/8/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "XCUIElement+Helpers.h"

@implementation XCUIElement (Helpers)

- (void)tapAtPointX:(CGFloat)aX y:(CGFloat)aY {
    
    XCUICoordinate *normalaziedCoordinate = [self coordinateWithNormalizedOffset:CGVectorMake(0, 0)];
    XCUICoordinate *coordinate = [normalaziedCoordinate coordinateWithOffset:CGVectorMake(aX, aY)];
    
    [coordinate tap];
}

@end
