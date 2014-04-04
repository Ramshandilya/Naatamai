//
//  YMLWelcomeViewController.m
//  Naatamai
//
//  Created by Ramsundar Shandilya on 04/04/14.
//  Copyright (c) 2014 Ramsundar Shandilya. All rights reserved.
//

#import "YMLWelcomeViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface YMLWelcomeViewController ()<CLLocationManagerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;

@end

@implementation YMLWelcomeViewController
{
    BOOL isShowingMessage;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Create a NSUUID with the same UUID as the broadcasting beacon
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    
    // Setup a new region with that UUID and same identifier as the broadcasting beacon
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:@"Estimote Region"];
    
    self.beaconRegion.notifyEntryStateOnDisplay = YES;
    // Tell location manager to start monitoring for the beacon region
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods

-(void)sendLocalNotification{
    
    UILocalNotification * localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = @"HI";
    localNotification.alertAction = @"OK";
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:0.0];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Gym Trainer" message:@"HI" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.delegate = self;
        [alertView show];
        isShowingMessage = YES;
    }
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    [self.locationManager requestStateForRegion:self.beaconRegion];
}

- (void) locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    switch (state) {
        case CLRegionStateInside:
            [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
            
            break;
        case CLRegionStateOutside:
        case CLRegionStateUnknown:
        default:
            // stop ranging beacons, etc
            NSLog(@"Region unknown");
    }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if ([beacons count] > 0) {
        // Handle your found beacons here
        
        CLBeacon *foundBeacon = [beacons firstObject];
        NSLog(@"Beacon Major - %@", foundBeacon.major);//64517
        NSLog(@"Beacon Minor - %@", foundBeacon.minor);//8889
        
        
        //TODO: SEND DATA TO API
        
        if (foundBeacon.proximity == CLProximityNear) {
            if (!isShowingMessage) {
                [self sendLocalNotification];
            }
        }
        
    }
    
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    isShowingMessage = NO;
}
@end
