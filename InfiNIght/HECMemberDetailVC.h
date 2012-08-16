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

@interface HECMemberDetailVC : UIViewController <MFMailComposeViewControllerDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) NSDictionary  *memberInfo;
@property (strong, nonatomic) IBOutlet UILabel      *name;
@property (strong, nonatomic) IBOutlet UILabel      *position;
@property (strong, nonatomic) IBOutlet UILabel      *age;
@property (strong, nonatomic) IBOutlet UILabel      *drink;
@property (strong, nonatomic) IBOutlet UILabel      *dj;
@property (strong, nonatomic) IBOutlet UILabel      *partyDestination;
@property (strong, nonatomic) IBOutlet UILabel      *moment;
@property (strong, nonatomic) IBOutlet UILabel      *surnom;
@property (strong, nonatomic) IBOutlet UIImageView  *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)composeMail:(id)sender;
- (IBAction) back: (id) sender;

@end
