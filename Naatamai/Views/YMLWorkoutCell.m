//
//  mediaCustomCell.m
//  Vigor
//
//  Created by manikandan on 23/10/13.
//  Copyright (c) 2013 Darshan Sonde. All rights reserved.
//

#import "YMLWorkoutCell.h"

#import <QuartzCore/QuartzCore.h>
@implementation YMLWorkoutCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void) awakeFromNib{
    [super awakeFromNib];
    
    [self.ThumbImage.layer setCornerRadius:CGRectGetHeight(self.ThumbImage.bounds)/2];
    [self.nameLabel setFont:[UIFont fontWithName:BEBAS_NEUE_REGULAR size:16.f]];
}

- (void)glow
{
    [UIView animateWithDuration:0.6 animations:^{
        self.glowImageView.alpha = 1;
    }];
}

-(void)done
{
    self.checkImageView.alpha = 1;
}

@end
