//
//  HECEventCell.h
//  InfiNIght
//
//  Created by Laurent Rivard on 8/11/12.
//
//

#import <UIKit/UIKit.h>

@interface HECEventCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *eventImage;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityInd;


@end
