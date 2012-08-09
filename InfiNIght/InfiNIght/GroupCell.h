//
//  GroupCell.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *groupName;
@property (strong, nonatomic) IBOutlet UILabel *groupPoints;
@property (strong, nonatomic) IBOutlet UILabel *position;
@property (strong, nonatomic) IBOutlet UIImageView *arrowIV;

@end
