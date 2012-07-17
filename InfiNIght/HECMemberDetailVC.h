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

- (IBAction)composeMail:(id)sender;
- (IBAction) back: (id) sender;

@end
