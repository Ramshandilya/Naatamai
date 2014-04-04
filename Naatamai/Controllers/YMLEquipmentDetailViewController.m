//
//  YMLEquipmentDetailViewController.m
//  Naatamai
//
//  Created by Ramsundar Shandilya on 04/04/14.
//  Copyright (c) 2014 Ramsundar Shandilya. All rights reserved.
//

#import "YMLEquipmentDetailViewController.h"
#import "YMLrepsSetsView.h"
#define BACK_ICON [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back_button_blue" ofType:@"png"]]
@interface YMLEquipmentDetailViewController ()
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) YMLrepsSetsView *SetsAndRepsView;
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
-(void)setupNavigationBar{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitleColor:[UIColor colorWithRed:42.0/256.0 green:176.0/256.0 blue:238.0/256.0 alpha:1] forState:UIControlStateNormal];
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [backButton setFrame:CGRectMake(0, 0, BACK_ICON.size.width + 5 + [backButton.titleLabel.text sizeWithFont:backButton.titleLabel.font].width,BACK_ICON.size.height)];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    
    UIImageView *backButtonimgv = [[UIImageView alloc]initWithImage:BACK_ICON];
    [backButton addSubview:backButtonimgv];
    
    UIBarButtonItem *barButtonBack = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:barButtonBack];
    
    
    [self.navigationItem setTitle:@"Excersize"];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    for (int i =0; i<3; i++)
    {
        self.SetsAndRepsView  =[[YMLrepsSetsView alloc]initWithFrame:CGRectMake(16+(i*100), 457, 90, 90)];
        [self.scrollView addSubview:self.SetsAndRepsView];
        self.SetsAndRepsView.repsCount.text =@"20";
        int x = i+1;
        self.SetsAndRepsView.setsCount.text = [NSString stringWithFormat:@"SET %d",x];
    }
    
//    self.DetailsTextview = @""
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
