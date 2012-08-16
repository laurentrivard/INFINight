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
@property (strong, nonatomic)  UILabel      *name;
@property (strong, nonatomic)  UILabel      *position;
@property (strong, nonatomic)  UILabel      *age;
@property (strong, nonatomic)  UILabel      *drink;
@property (strong, nonatomic)  UILabel      *dj;
@property (strong, nonatomic)  UILabel      *partyDestination;
@property (strong, nonatomic)  UILabel      *moment;
@property (strong, nonatomic)  UILabel      *surnom;
@property (strong, nonatomic)  UIImageView  *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)composeMail:(id)sender;
- (IBAction) back: (id) sender;

@end
