//
//  MNDurationDescriptionLabel.m
//  MetroNavigation
//
//  Created by Nikita Kirichek on 5/4/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

#import "MNDurationDescriptionLabel.h"
#import <tgmath.h>

@implementation MNDurationDescriptionLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textColor = [UIColor grayColor];
}

- (void)setTotalDuration:(NSNumber *)totalDuration {
    self.text = [self timeDescriptionFromDuration:totalDuration];
}

- (void)setTotalDuration:(NSNumber *)totalDuration withTransfersCount:(NSInteger)transfersCount {

    self.text = [[self timeDescriptionFromDuration:totalDuration]
                 stringByAppendingString:[self transferDescriptionFromTransfersCount:transfersCount]];
    
}

- (NSString *)timeDescriptionFromDuration:(NSNumber *)totalDuration {
    
    NSInteger minutes = fmod([totalDuration doubleValue], 60.0);
    NSInteger hours = fmod([totalDuration doubleValue] / 60.0, 60.0);
    NSInteger days = [totalDuration doubleValue] / (60.0 * 24.0);
    
    NSString *timeDescription;
    
    if (days > 0) {
        timeDescription = [NSString stringWithFormat:@"~Approx. %li days, %li hours, %li minutes", (long)days, (long)hours, (long)minutes];
    } else if (hours > 0) {
        timeDescription = [NSString stringWithFormat:@"~Approx. %li hours, %li minutes", (long)hours, (long)minutes];
    } else if (minutes > 0) {
        timeDescription = [NSString stringWithFormat:@"~Approx. %li minutes", (long)minutes];
    } else {
        timeDescription = @"Immediately";
    }
    
    return timeDescription;
}

- (NSString *)transferDescriptionFromTransfersCount:(NSInteger)transfersCount {
    NSString *transfersDescription;
    
    if (transfersCount == 0) {
        transfersDescription = @", no transfers";
    } else {
        transfersDescription = [NSString stringWithFormat:@", %li transfers.", (long)transfersCount];
    }
    return transfersDescription;
}



@end
