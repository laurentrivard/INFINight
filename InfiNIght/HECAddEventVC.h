//
//  HECAddEventVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HECAddEventTimeVC.h"

@interface HECAddEventVC : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, TimeProtocol, UIScrollViewDelegate, UITextViewDelegate> {
    CGFloat animatedDistance;
    NSDate *_newEventDate;
    NSString *_dateString;
    CGRect _field;
}

@property (strong, nonatomic) IBOutlet UITextView *titleTF;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTF;
@property (strong, nonatomic) IBOutlet UITextView *locationTF;
@property (strong, nonatomic) IBOutlet UILabel *titleCharacterCount;
@property (strong, nonatomic) IBOutlet UILabel *descriptionCharacterCount;
@property (strong, nonatomic) IBOutlet UILabel *locationCharacterCount;

- (IBAction)addEvent:(id)sender;
-(IBAction)didCancelEvent:(id)sender;
-(IBAction) addEventTime:(id)sender;
@end
