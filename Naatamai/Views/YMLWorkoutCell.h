//
//  mediaCustomCell.h
//  Vigor
//
//  Created by manikandan on 23/10/13.
//  Copyright (c) 2013 Darshan Sonde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMLWorkoutCell : UICollectionViewCell
{
    
}
@property(nonatomic,strong)IBOutlet UIImageView *ThumbImage;
@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *glowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;

- (void)glow;
- (void)done;

@end
