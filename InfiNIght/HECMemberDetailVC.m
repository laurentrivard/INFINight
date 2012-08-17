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
    
//    NSLog(@"member info : %@", _memberInfo);
//     _moment = [_memberInfo valueForKey:@"moment"];
//     _partyDestination = [_memberInfo valueForKey:@"partyDestination"];

    
    //sets where the labels and image are. if retina display, everything is doubled
    int yImage = 55;
    int yFirstLabel = 230;
    int yLabelHeight = 30;
    int yLabelSpacing = 43;     //  profileDetail3
//    int yLabelSpacing = 40;
    
//    if([self iPhoneRetina]) {
//        yImage = yImage * 2;
//        yFirstLabel = yFirstLabel * 2;
//        yLabelHeight = yLabelHeight * 2;
//    }

    
    
    //scroll view for the profile
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 535);
    self.scrollView.delegate = self;
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 535)];
    background.image = [UIImage imageNamed:@"ProfileDetail4.png"];
    [self.scrollView addSubview:background];
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.bounces = YES;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_memberInfo valueForKey:@"detailPic"]]];
    [self.imageView setFrame:CGRectMake(0, yImage, self.view.frame.size.width, self.imageView.image.size.height)];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, yImage)];
    _name.backgroundColor = [UIColor clearColor];
    _name.textColor = [UIColor whiteColor];
    _name.textAlignment = UITextAlignmentCenter;
    if ([[_memberInfo valueForKey:@"name"] isEqualToString:@"Geneviève Higgins-Desbiens"])
        _name.font = [UIFont fontWithName:@"Papyrus" size:23.0f];
    else
    _name.font = [UIFont fontWithName:@"Papyrus" size:24.0f];
    _name.text = [_memberInfo valueForKey:@"name"];
    
    
    _surnom = [[UILabel alloc] initWithFrame:CGRectMake(15, yFirstLabel, self.scrollView.frame.size.width, yLabelHeight)];
    _surnom.backgroundColor = [UIColor clearColor];
    _surnom .textColor = [UIColor whiteColor];
    //_name.textAlignment = UITextAlignmentCenter;
    _surnom.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
    _surnom.text =[NSString stringWithFormat:@"Surnom : %@", [_memberInfo valueForKey:@"surnom"]];
    
    _age = [[UILabel alloc] initWithFrame:CGRectMake(15, yFirstLabel + yLabelSpacing, self.scrollView.frame.size.width , yLabelHeight)];
    _age.backgroundColor = [UIColor clearColor];
    _age .textColor = [UIColor whiteColor];
    _age.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
    _age.text =[NSString stringWithFormat:@"Âge : %@", [_memberInfo valueForKey:@"age"]];

    _position = [[UILabel alloc] initWithFrame:CGRectMake(15, yFirstLabel +  2 * yLabelSpacing, self.scrollView.frame.size.width, yLabelHeight)];
    _position.backgroundColor = [UIColor clearColor];
    _position .textColor = [UIColor whiteColor];
    _position.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
    _position.text =[NSString stringWithFormat:@"Poste : %@", [_memberInfo valueForKey:@"position"]];
    
    _drink = [[UILabel alloc] initWithFrame:CGRectMake(15, yFirstLabel +  3 * yLabelSpacing, self.scrollView.frame.size.width, yLabelHeight)];
    _drink.backgroundColor = [UIColor clearColor];
    _drink .textColor = [UIColor whiteColor];
    _drink.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
    _drink.text =[NSString stringWithFormat:@"Drink : %@", [_memberInfo valueForKey:@"drink"]];

    _dj = [[UILabel alloc] initWithFrame:CGRectMake(15, yFirstLabel + 4 * yLabelSpacing, self.scrollView.frame.size.width, yLabelHeight)];
    _dj.backgroundColor = [UIColor clearColor];
    _dj .textColor = [UIColor whiteColor];
    _dj.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
    _dj.text =[NSString stringWithFormat:@"Dj préféré : %@", [_memberInfo valueForKey:@"dj"]];

    _partyDestination = [[UILabel alloc] initWithFrame:CGRectMake(15, yFirstLabel + 5 * yLabelSpacing, self.scrollView.frame.size.width, yLabelHeight)];
    _partyDestination.backgroundColor = [UIColor clearColor];
    _partyDestination .textColor = [UIColor whiteColor];
    _partyDestination.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
    _partyDestination.text =[NSString stringWithFormat:@"Party destination : %@", [_memberInfo valueForKey:@"partyDestination"]];

    _moment = [[UILabel alloc] initWithFrame:CGRectMake(15, yFirstLabel + 6 * yLabelSpacing, self.scrollView.frame.size.width - 15, yLabelHeight)];
    _moment.backgroundColor = [UIColor clearColor];
    _moment .textColor = [UIColor whiteColor];
    _moment.text =[NSString stringWithFormat:@"Moment mémorable : %@", [_memberInfo valueForKey:@"moment"]];
    if([[_memberInfo valueForKey:@"name"] isEqualToString:@"Stéphanie Gravel-Bédard"] )
            _moment.font = [UIFont fontWithName:@"Helvetica" size:14.5f];
    else if ([[_memberInfo valueForKey:@"name"] isEqualToString:@"Annie Leclerc"])
        _moment.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    else if ([[_memberInfo valueForKey:@"name"] isEqualToString:@"Gab B. Harris"])
        _moment.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    else if ([[_memberInfo valueForKey:@"name"] isEqualToString:@"Geneviève Higgins-Desbiens"])
        _moment.font = [UIFont fontWithName:@"Helvetica" size:14.5f];
    else
        _moment.font = [UIFont fontWithName:@"Helvetica" size:16.0f];



    _moment.lineBreakMode = UILineBreakModeWordWrap;
     
    [self.scrollView addSubview:self.imageView];
    [self.scrollView addSubview:_name];
    [self.scrollView addSubview:_surnom];
    [self.scrollView addSubview:_age];
    [self.scrollView addSubview:_position];
    [self.scrollView addSubview:_drink];
    [self.scrollView addSubview:_dj];
    [self.scrollView addSubview:_moment];
    [self.scrollView addSubview:_partyDestination];
    
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
