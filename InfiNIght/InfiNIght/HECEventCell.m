//
//  HECEventCell.m
//  InfiNIght
//
//  Created by Laurent Rivard on 8/11/12.
//
//

#import "HECEventCell.h"

@implementation HECEventCell
@synthesize eventTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
