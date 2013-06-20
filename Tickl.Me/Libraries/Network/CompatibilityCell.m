//
//  CompatibilityCell.m
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 6/17/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "CompatibilityCell.h"
#import "Constants.h"

@implementation CompatibilityCell

@synthesize nameLabel = _nameLabel;
@synthesize similaritiesLabel = _similaritiesLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    // set alignment of friend's picture to top left of the table cell
    self.imageView.frame = CGRectMake(COMPATIBILITYPICMARGIN,
                                      COMPATIBILITYPICMARGIN,
                                      COMPATIBILITYPICWIDTH,
                                      COMPATIBILITYPICHEIGHT);
    
    self.nameLabel.frame = CGRectMake(COMPATIBILITYPICWIDTH + 2*COMPATIBILITYPICMARGIN,
                                      COMPATIBILITYPICMARGIN,
                                      COMPATIBILITYTEXTWIDTH,
                                      self.nameLabel.frame.size.height);
    
    self.similaritiesLabel.frame = CGRectMake(COMPATIBILITYPICWIDTH + 2*COMPATIBILITYPICMARGIN,
                                              3*COMPATIBILITYPICMARGIN,
                                              COMPATIBILITYTEXTWIDTH,
                                              self.similaritiesLabel.frame.size.height);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
