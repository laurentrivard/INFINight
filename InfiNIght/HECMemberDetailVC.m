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
@synthesize school= _school;
@synthesize job= _job;
@synthesize paragraph = _paragraph;
@synthesize imageView = _imageView;
@synthesize toolbar = _toolbar;

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
   

    _toolbar.tintColor = [UIColor blackColor];
    
    _name.text = [_memberInfo valueForKey:@"name"];
    _position.text = [_memberInfo valueForKey:@"position"];
    _age.text = [_memberInfo valueForKey:@"age"];
    _school.text = [_memberInfo valueForKey:@"school"];   
    _job.text = [_memberInfo valueForKey:@"job"];
    _paragraph.text = [_memberInfo valueForKey:@"paragraph"];
    
    
    self.imageView.image = [UIImage imageNamed:@"annieTEST.jpg"];

}

- (void)viewDidUnload
{
    [self setName:nil];
    [self setPosition:nil];
    [self setAge:nil];
    [self setSchool:nil];
    [self setJob:nil];
    [self setParagraph:nil];
    [self setImageView:nil];
    [self setToolbar:nil];
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
