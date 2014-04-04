//
//  YMLDataManager.m
//  Naatamai
//
//  Created by Ramsundar Shandilya on 04/04/14.
//  Copyright (c) 2014 Ramsundar Shandilya. All rights reserved.
//

#import "YMLDataManager.h"

@implementation YMLDataManager

+ (instancetype)sharedManager
{
    static YMLDataManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[YMLDataManager alloc] init];
        
    });
    
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
