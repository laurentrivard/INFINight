//
//  HECPartyDetailVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HECPartyDetailVC : UIViewController


@property (strong, nonatomic) NSDictionary *eventInfo;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UILabel *locationLbl;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTF;
@end
