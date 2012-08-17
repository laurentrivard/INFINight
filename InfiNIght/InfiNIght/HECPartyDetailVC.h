//
//  HECPartyDetailVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface HECPartyDetailVC : UIViewController


@property (strong, nonatomic) NSDictionary *eventInfo;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic)  UILabel *dateLbl;
@property (strong, nonatomic)  UILabel *locationLbl;
@property (strong, nonatomic)  UITextView *descriptionTF;
@property (strong, nonatomic)  UIImageView *imagePhoto;
@property (strong, nonatomic)  UIActivityIndicatorView *actInd;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end
