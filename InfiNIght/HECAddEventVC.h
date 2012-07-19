//
//  HECAddEventVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HECAddEventVC : UIViewController <UITextFieldDelegate, UIAlertViewDelegate> {
    CGFloat animatedDistance;
}

@property (strong, nonatomic) IBOutlet UITextField *titleTF;
@property (strong, nonatomic) IBOutlet UITextField *descriptionTF;
@property (strong, nonatomic) IBOutlet UITextField *dateTF;
@property (strong, nonatomic) IBOutlet UITextField *locationTF;

- (IBAction)addEvent:(id)sender;
-(IBAction)didCancelEvent:(id)sender;

@end
