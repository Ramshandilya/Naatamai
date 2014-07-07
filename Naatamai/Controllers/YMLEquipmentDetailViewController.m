//
//  YMLEquipmentDetailViewController.m
//  Naatamai
//
//  Created by Ramsundar Shandilya on 04/04/14.
//  Copyright (c) 2014 Ramsundar Shandilya. All rights reserved.
//

#import "YMLEquipmentDetailViewController.h"
#import "YMLRepsSetsView.h"
#import "UIView+LoadNIb.h"
#import <MediaPlayer/MediaPlayer.h>


@interface YMLEquipmentDetailViewController ()
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) YMLRepsSetsView *SetsAndRepsView;
@property (nonatomic, weak) IBOutlet UITextView *DetailsTextview;
@property (nonatomic, weak) IBOutlet UIImageView *videoAvatarImageView;
@property (nonatomic,weak) IBOutlet UIButton *playBtn;
@property (nonatomic ,weak) IBOutlet UILabel *excerszieNameLbl, *setsRepsLabel;
@end

@implementation YMLEquipmentDetailViewController

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
    
    [self.excerszieNameLbl setFont:[UIFont fontWithName:BEBAS_NEUE_REGULAR size:20.f]];
    [self.setsRepsLabel setFont:[UIFont fontWithName:BEBAS_NEUE_REGULAR size:20.f]];
    
    for (int i =0; i<3; i++)
    {
        self.SetsAndRepsView  = [YMLRepsSetsView loadInstanceFromNibWithOwner:self];
        [self.SetsAndRepsView setFrame:CGRectMake(16+(i*100), 400, 90, 90)];
        [self.scrollView addSubview:self.SetsAndRepsView];
        self.SetsAndRepsView.repsCount.text =@"20";
        int x = i+1;
        self.SetsAndRepsView.setsCount.text = [NSString stringWithFormat:@"SET %d",x];
    }
    
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods

-(void)setupNavigationBar{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 25, 25)];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
    
    UIBarButtonItem *barButtonBack = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:barButtonBack];

}

#pragma mark - Selectors

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)playVideoTapped:(id)sender {
    NSURL *movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sample" ofType:@"mov"]];
    MPMoviePlayerViewController *movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
    [self presentMoviePlayerViewControllerAnimated:movieController];
    [movieController.moviePlayer play];
}
@end
