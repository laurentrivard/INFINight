//
//  HECAddEventTimeVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HECAddEventTimeVC;
@protocol TimeProtocol <NSObject>

-(void) passDateBack: (HECAddEventTimeVC *) controller didFinish: (NSDictionary *) dateString;

@end

@interface HECAddEventTimeVC : UIViewController{
    NSString *dateString;
    NSDate *_eventDate;
    NSDictionary *_dic;
}

@property (weak, nonatomic) id <TimeProtocol> delegate;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

-(IBAction)didCancel:(id)sender;
-(IBAction)didSave:(id)sender;

@end
