//
//  YMLWelcomeViewController.m
//  Naatamai
//
//  Created by Ramsundar Shandilya on 04/04/14.
//  Copyright (c) 2014 Ramsundar Shandilya. All rights reserved.
//

#import "YMLWelcomeViewController.h"

@interface YMLWelcomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutLabel;
@property (weak, nonatomic) IBOutlet UIImageView *focusImageView;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelDetailsLabel;

@end

@implementation YMLWelcomeViewController


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
    
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    self.navigationController.navigationBar.translucent = YES;
    
    [self.welcomeLabel setFont:[UIFont fontWithName:BEBAS_NEUE_REGULAR size:20.f]];
    [self.nameLabel setFont:[UIFont fontWithName:BEBAS_NEUE_REGULAR size:40.f]];
    [self.todayLabel setFont:[UIFont fontWithName:BEBAS_NEUE_BOOK size:16.f]];
    [self.workoutLabel setFont:[UIFont fontWithName:BEBAS_NEUE_BOOK size:30.f]];
    [self.levelLabel setFont:[UIFont fontWithName:BEBAS_NEUE_BOOK size:16.f]];
    [self.levelDetailsLabel setFont:[UIFont fontWithName:BEBAS_NEUE_BOOK size:30.f]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beginWorkout:(id)sender {
}

@end
