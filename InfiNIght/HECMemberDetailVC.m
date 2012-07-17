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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Annie" message:@"Ici, on voit le profil d'Annie. Donnez moi vos suggestions sur la face dont vous voulez presenter l'info" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)composeMail:(id)sender {
    
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
//	[[mail navigationBar] setTintColor:];
	mail.mailComposeDelegate = self;
	if ( [MFMailComposeViewController canSendMail] ) {
		//Setting up the Subject, recipients, and message body.
		[mail setToRecipients:[NSArray arrayWithObjects:@"annie.leclerc@hec.ca",nil]];
		
					[mail setMessageBody:@"l'adresse changerais pour chaque personne évidemment" isHTML:NO];
		[mail setSubject:@"Bonjour a tous!"];
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Result" message:@"Mail Sent Successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
