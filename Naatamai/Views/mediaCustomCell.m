//
//  mediaCustomCell.m
//  Vigor
//
//  Created by manikandan on 23/10/13.
//  Copyright (c) 2013 Darshan Sonde. All rights reserved.
//

#import "mediaCustomCell.h"

#import <QuartzCore/QuartzCore.h>
@implementation mediaCustomCell

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
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
