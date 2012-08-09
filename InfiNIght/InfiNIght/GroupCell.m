//
//  GroupCell.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GroupCell.h"

@implementation GroupCell
@synthesize groupName;
@synthesize groupPoints;
@synthesize position;
@synthesize arrowIV;

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
