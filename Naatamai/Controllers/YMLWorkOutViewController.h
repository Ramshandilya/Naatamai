//
//  YMLWorkOutViewController.h
//  Naatamai
//
//  Created by Ramsundar Shandilya on 04/04/14.
//  Copyright (c) 2014 Ramsundar Shandilya. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMLWorkoutCell;
@interface YMLWorkOutViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    
}
@property (nonatomic,weak)IBOutlet UICollectionView *beaconDetailCollectionView;

@property(nonatomic,strong)NSString *selectedbeaconID;
@end
