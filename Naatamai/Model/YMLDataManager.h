//
//  YMLDataManager.h
//  Naatamai
//
//  Created by Ramsundar Shandilya on 04/04/14.
//  Copyright (c) 2014 Ramsundar Shandilya. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailureBlock)(NSError *err);

@interface YMLDataManager : NSObject

@property (nonatomic, strong) NSString *userName;

+ (instancetype)sharedManager;
-(void)getBeaconDetails : (NSDictionary * )params success  :(SuccessBlock) sucess Failure :(FailureBlock )failure;

@end
