//
//  MembersVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MembersVC.h"

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
    
    UIImageView *admin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MemberField.png"]];
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
    
//    [self.scrollView addGestureRecognizer:singleTap];
    
    
    
//    [frank addGestureRecognizer:singleTap];
//    [karl addGestureRecognizer:singleTap];
//    [annie addGestureRecognizer:singleTap];
//    [stephanie addGestureRecognizer:singleTap];
//    [nicolas addGestureRecognizer:singleTap];
//    [genevieve addGestureRecognizer:singleTap];
//    [catherine addGestureRecognizer:singleTap];
//    [gabrielle addGestureRecognizer:singleTap];
//    [samuel addGestureRecognizer:singleTap];
//    [admin addGestureRecognizer:singleTap];

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
  //  NSLog(@"sender: %d", sender.tag);
    NSLog(@"hello...");
    NSLog(@"sender: %d", sender.view.tag);
}

@end
