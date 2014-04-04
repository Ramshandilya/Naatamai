//
//  YMLWorkOutViewController.m
//  Naatamai
//
//  Created by Ramsundar Shandilya on 04/04/14.
//  Copyright (c) 2014 Ramsundar Shandilya. All rights reserved.
//

#import "YMLWorkOutViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "mediaCustomCell.h"
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
    
    [self setupNavigationBar];
    
    [self.beaconDetailCollectionView registerNib:[UINib nibWithNibName:@"mediaCustomCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"mediaCellIdentifier"];
    ThumbImageArr =[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"", nil];
    beaconEquipName = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"", nil];
    
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

- (mediaCustomCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"mediaCellIdentifier";
    mediaCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"mediaCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell.ThumbImage setImage:[UIImage imageNamed:@"media_default_circle.png"]];
    cell.nameLabel.text = @"Excersize";
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YMLEquipmentDetailViewController *workoutViewController = [[YMLEquipmentDetailViewController alloc] initWithNibName:@"YMLEquipmentDetailViewController" bundle:nil];
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
                NSDictionary *param =@{@"uuid": foundBeacon.proximityUUID,
                                       @"major":foundBeacon.major,
                                       @"minor":foundBeacon.minor};
                [[YMLDataManager sharedManager] getBeaconDetails:param success:^(id responseObject) {
                    NSLog(@"res %@",responseObject);
                } Failure:^(NSError *err) {
                    NSLog(@"failed");
                }];
//                [self sendLocalNotification];
            }
        }
        
    }
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    isShowingMessage = NO;
}

#pragma mark - Selectors

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
