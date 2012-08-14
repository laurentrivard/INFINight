//
//  HECEventImageDetailVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 8/2/12.
//
//

#import <UIKit/UIKit.h>

@interface HECEventImageDetailVC : UIViewController {
}
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *actInd;

@end
