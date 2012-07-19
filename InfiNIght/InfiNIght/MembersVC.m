//
//  MembersVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MembersVC.h"
#import "HECMemberDetailVC.h"
#import "HECAdminVC.h"
#import "HECAddEventVC.h"

@interface MembersVC ()

@end

@implementation MembersVC
@synthesize scrollView;

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
    [self.navigationController setNavigationBarHidden:NO];

    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1048);   
    self.scrollView.delegate = self;
//    self.scrollView.pagingEnabled = ;

    
    
	// Do any additional setup after loading the view.
    UIImageView *frank = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frankProfileFinal.png"]];
    frank.frame = CGRectMake(8, 8, 148, 200);
    
    UIImageView *karl = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"karlProfileFinal.png"]];
    karl.frame = CGRectMake(164, 8, 148, 200);
    
    UIImageView *annie = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"annieProfileFinal.png"]];
    annie.frame = CGRectMake(8, 216, 148, 200);
    
    UIImageView *stephanie = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stephanieProfileFinal.png"]];
    stephanie.frame = CGRectMake(164, 216, 148, 200);
    
    UIImageView *nicolas = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nicolasProfileFinal.png"]];
    nicolas.frame = CGRectMake(8, 424, 148, 200);
    
    UIImageView *genevieve = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"genevieveProfileFinal.png"]];
    genevieve.frame = CGRectMake(164, 424, 148, 200);
    
    UIImageView *catherine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"catherineProfileFinal.png"]];
    catherine.frame = CGRectMake(8, 632, 148, 200);
    
    UIImageView *gabrielle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gabrielleProfileFinal.png"]];
    gabrielle.frame = CGRectMake(164, 632, 148, 200);
    
    UIImageView *samuel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"samuelProfileFinal.png"]];
    samuel.frame = CGRectMake(8, 840, 148, 200);
    
    UIImageView *admin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings.png"]];
    admin.frame = CGRectMake(164, 840, 148, 200);
    
    frank.tag = 0;
    karl.tag  = 1;
    annie.tag = 2;
    stephanie.tag = 3;
    nicolas.tag =4;
    genevieve.tag = 5;
    catherine.tag = 6;
    gabrielle.tag = 7;
    samuel.tag = 8;
    admin.tag = 9;
    
    //add all members to main view (scroll view)
    [self.scrollView addSubview:frank];
    [self.scrollView addSubview:karl];
    [self.scrollView addSubview:annie];
    [self.scrollView addSubview:stephanie];
    [self.scrollView addSubview:nicolas];
    [self.scrollView addSubview:genevieve];
    [self.scrollView addSubview:catherine];
    [self.scrollView addSubview:gabrielle];
    [self.scrollView addSubview:samuel];
    [self.scrollView addSubview:admin];

   
    
    frank.userInteractionEnabled = YES;
    karl.userInteractionEnabled = YES;
    annie.userInteractionEnabled = YES;
    stephanie.userInteractionEnabled = YES;
    nicolas.userInteractionEnabled = YES;
    genevieve.userInteractionEnabled = YES;
    catherine.userInteractionEnabled = YES;
    gabrielle.userInteractionEnabled = YES;
    samuel.userInteractionEnabled = YES;
    admin.userInteractionEnabled = YES;
    
    NSArray *allMembers = [[NSArray alloc] initWithObjects:frank,karl,annie,stephanie,nicolas,genevieve,catherine, gabrielle,samuel,admin, nil];
    
    for(UIImageView *spec in allMembers )
    {
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [spec addGestureRecognizer:singleTap];
    }
    

}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) handleSingleTap: (UIGestureRecognizer *) sender {

    //instantiate the profileDetailController
    HECMemberDetailVC *profileDetail = [[HECMemberDetailVC alloc] initWithNibName:@"HECMemberDetailVC" bundle:[NSBundle mainBundle]];
    switch (sender.view.tag) {
        case 0:
            //assign the data to the controller
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
        case 8:
            break;      
        case 9:
            break;
        default:
            //should never reach
            break;
    } 
    if(sender.view.tag < 9)
        [self presentModalViewController:profileDetail animated:YES];
    else {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Mot de passe" message:@"ici, il faudra rentrer un mot de passe pour pouvoir acceder a la prochaine page. Vous pourrez ajouter un evenement ou party dans cette page. " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
      
        [self.scrollView addSubview:myAlertView];
     //   [myAlertView show];
        
        HECAddEventVC *addEvent = [[HECAddEventVC alloc] initWithNibName:@"HECAddEventVC" bundle:[NSBundle mainBundle]];
        
        [self presentModalViewController:addEvent animated:YES];
        
    }

    //push the profileDetailController
}
- (void)willPresentAlertView:(UIAlertView *)alertView; 
{
    alertView.frame=CGRectMake(10, 150, 300 , 230);
}

@end
