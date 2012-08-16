//
//  HECMemberDetailVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HECMemberDetailVC.h"

@interface HECMemberDetailVC ()

@end

@implementation HECMemberDetailVC
@synthesize memberInfo=_memberInfo;
@synthesize name=_name;
@synthesize position=_position;
@synthesize age= _age;
@synthesize dj=_dj;
@synthesize drink=_drink;
@synthesize moment=_moment;
@synthesize partyDestination=_partyDestination;
@synthesize imageView = _imageView;
@synthesize surnom=_surnom;
@synthesize scrollView = _scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//
//    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 370);
//    self.scrollView.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeMail:)];

//    
//    _name.text = [_memberInfo valueForKey:@"name"];
//    _position.text = [_memberInfo valueForKey:@"position"];
//    _age.text = [_memberInfo valueForKey:@"age"];
//    _school.text = [_memberInfo valueForKey:@"school"];   
//    _job.text = [_memberInfo valueForKey:@"job"];
//    _paragraph.text = [_memberInfo valueForKey:@"paragraph"];
//    self.imageView.image = [UIImage imageNamed:[_memberInfo valueForKey:@"detailPic"]];
    
    //sets where the labels and image are. if retina display, everything is doubled
    int yImage = 55;
    
    if([self iPhoneRetina]) {
        yImage = yImage * 2;
    }

    
    
    //scroll view for the profile
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 535);
    self.scrollView.delegate = self;
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 535)];
    background.image = [UIImage imageNamed:@"TESTPROFILEDETAIL.png"];
    [self.scrollView addSubview:background];
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.bounces = YES;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AnnieLeclerc.png"]];
    [self.imageView setFrame:CGRectMake(0, yImage, self.view.frame.size.width, self.imageView.image.size.height)];
    
  

    [self.scrollView addSubview:self.imageView];
    
}
-(BOOL)iPhoneRetina{
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))?1:0;
}

- (void)viewDidUnload
{
    [self setName:nil];
    [self setPosition:nil];
    [self setAge:nil];
    [self setImageView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}


- (IBAction)composeMail:(id)sender {
    
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
//	[[mail navigationBar] setTintColor:];
	mail.mailComposeDelegate = self;
	if ( [MFMailComposeViewController canSendMail] ) {
		//Setting up the Subject, recipients, and message body.
		[mail setToRecipients:[NSArray arrayWithObject:[_memberInfo valueForKey:@"email"]]];
		
					[mail setMessageBody:@"Email envoyé par l'application Promo INFINight." isHTML:NO];
		[mail setSubject:@"Promo INFINight"];
		[self presentModalViewController:mail animated:YES];
    }
}
- (IBAction) back: (id) sender {
	[self dismissModalViewControllerAnimated:YES];
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            //NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mesage envoyé" message:@"Votre message a été envoyé avec succès." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }
            break;
        case MFMailComposeResultFailed:
            //NSLog(@"Result: failed");
            break;
        default:
            //NSLog(@"Result: not sent");
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

@end
