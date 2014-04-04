//
//  YMLrepsSetsView.m
//  Naatamai
//
//  Created by manikandan on 05/04/14.
//  Copyright (c) 2014 Ramsundar Shandilya. All rights reserved.
//

#import "YMLRepsSetsView.h"

@implementation YMLRepsSetsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self.repsCount setFont:[UIFont fontWithName:BEBAS_NEUE_BOLD size:40.f]];
    [self.repsLabel setFont:[UIFont fontWithName:BEBAS_NEUE_BOLD size:16.f]];
    [self.setsCount setFont:[UIFont fontWithName:BEBAS_NEUE_BOLD size:10.f]];
    
    
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
