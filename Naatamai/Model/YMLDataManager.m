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

-(void)getBeaconDetails : (NSDictionary * )params success  :(SuccessBlock) sucess Failure :(FailureBlock )failure
{
    NSString *urlStr =[NSString stringWithFormat:@"http://192.168.1.29/gymapp/index.php/gym/getEquipmentInfo?uuid=%@&major=%@&minor=%@",[params objectForKey:@"uuid"],[params objectForKey:@"major"],[params objectForKey:@"minor"]];
    NSURL  *url =[NSURL URLWithString:urlStr];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (data) {
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                sucess(responseDict);
            }
            else{
                failure([NSError errorWithDomain:@"" code:11 userInfo:nil]);
            }
            
        });
    }];
}
@end
