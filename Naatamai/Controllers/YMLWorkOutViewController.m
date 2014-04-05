//
//  YMLWorkOutViewController.m
//  Naatamai
//
//  Created by Ramsundar Shandilya on 04/04/14.
//  Copyright (c) 2014 Ramsundar Shandilya. All rights reserved.
//

#import "YMLWorkOutViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "YMLWorkoutCell.h"
#import "YMLEquipmentDetailViewController.h"
#import "YMLDataManager.h"
@interface YMLWorkOutViewController ()<CLLocationManagerDelegate, UIAlertViewDelegate>
{
    NSMutableArray *ThumbImageArr,*beaconEquipName;
}

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;

@end

@implementation YMLWorkOutViewController
{
    BOOL isProcessing;
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
    
    [self setupNavigationBar];
    
    [self.beaconDetailCollectionView registerNib:[UINib nibWithNibName:@"YMLWorkoutCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"mediaCellIdentifier"];
    ThumbImageArr =[[NSMutableArray alloc]initWithObjects:@"workout_1",@"workout_2",@"workout_3",@"workout_4",@"workout_4",@"workout_5",@"workout_3", nil];
    beaconEquipName = [[NSMutableArray alloc]initWithObjects:@"DUMBELL LIFT",@"INCLINED PRESS",@"FRONT PULL",@"LAT PULL DOWN",@"DUMBELL LIFT",@"INCLINED PRESS", nil];
    
    //BEACON SETUP
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UICOLLECTIONVIEW Delegate & Datasource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (YMLWorkoutCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"mediaCellIdentifier";
    YMLWorkoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YMLWorkoutCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell.ThumbImage setImage:[UIImage imageNamed:ThumbImageArr[indexPath.row]]];
    cell.nameLabel.text = beaconEquipName[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YMLEquipmentDetailViewController *workoutViewController = [[YMLEquipmentDetailViewController alloc] initWithNibName:@"YMLEquipmentDetailViewController" bundle:nil];
    workoutViewController.title = [beaconEquipName[indexPath.row] uppercaseString];
    [self.navigationController pushViewController:workoutViewController animated:YES];
}

#pragma mark - Custom Methods

-(void)setupNavigationBar{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 25, 25)];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
    
    UIBarButtonItem *barButtonBack = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:barButtonBack];
    
    self.title = @"CHEST & BACK";
}

-(void)sendLocalNotification:(NSString *)info{
    
    UILocalNotification * localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = @"HI";
    localNotification.alertAction = @"OK";
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:0.0];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        if ([info isEqualToString:@"INCLINED BENCH PRESS"]) {
            YMLWorkoutCell *cell = (YMLWorkoutCell *)[self.beaconDetailCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [cell glow];
        }
        if ([info isEqualToString:@"DUMBBELL LIFT"]) {
            YMLWorkoutCell *cell = (YMLWorkoutCell *)[self.beaconDetailCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [cell glow];
        }
    }
    
    isProcessing = NO;
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
        
        
        if (foundBeacon.proximity == CLProximityImmediate) {
            if (!isProcessing) {
                isProcessing = YES;
                NSDictionary *param =@{@"uuid": foundBeacon.proximityUUID.UUIDString,
                                       @"major":foundBeacon.major,
                                       @"minor":foundBeacon.minor};
                [[YMLDataManager sharedManager] getBeaconDetails:param success:^(id responseObject) {
                    NSLog(@"res %@",responseObject);
                    [self sendLocalNotification:[[[responseObject objectForKey:@"data"] objectAtIndex:0] objectForKey:@"equipment_name"]];
                } Failure:^(NSError *err) {
                    NSLog(@"failed");
                }];
                
            }
        }
        
    }
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    isProcessing = NO;
}

#pragma mark - Selectors

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
