//
//  MNDurationDescriptionLabel.h
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/4/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNDurationDescriptionLabel : UILabel

- (void)setTotalDuration:(NSNumber *)totalDuration;
- (void)setTotalDuration:(NSNumber *)totalDuration withTransfersCount:(NSInteger)transfersCount;

@end
