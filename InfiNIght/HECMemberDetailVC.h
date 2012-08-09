//
//  HECMemberDetailVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface HECMemberDetailVC : UIViewController <MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) NSDictionary *memberInfo;
@property (strong, nonatomic) IBOutlet UITextView *name;
@property (strong, nonatomic) IBOutlet UITextView *position;
@property (strong, nonatomic) IBOutlet UITextView *age;
@property (strong, nonatomic) IBOutlet UITextView *school;
@property (strong, nonatomic) IBOutlet UITextView *job;
@property (strong, nonatomic) IBOutlet UITextView *paragraph;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)composeMail:(id)sender;
- (IBAction) back: (id) sender;

@end
