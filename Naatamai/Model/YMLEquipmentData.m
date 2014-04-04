//
//  YMLEquipmentData.m
//  Naatamai
//
//  Created by Ramsundar Shandilya on 05/04/14.
//  Copyright (c) 2014 Ramsundar Shandilya. All rights reserved.
//

#import "YMLEquipmentData.h"

@implementation YMLEquipmentData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _reps = [[NSArray alloc] init];
    }
    return self;
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"Name : %@,\nDetails : %@,\nVideoURL : %@,\nReps : %@", _equipmentName, _equipmentDetails, _videoURLString, _reps];
}

@end
