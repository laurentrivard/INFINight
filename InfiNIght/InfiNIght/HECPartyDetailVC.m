//
//  HECPartyDetailVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HECPartyDetailVC.h"

@interface HECPartyDetailVC ()

@end

@implementation HECPartyDetailVC
@synthesize eventInfo;
@synthesize titleLbl;
@synthesize dateLbl;
@synthesize locationLbl;
@synthesize descriptionTF;

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
    NSLog(@"%@", self.eventInfo);
    
    self.titleLbl.text = [self.eventInfo objectForKey:@"event_title"];
    self.descriptionTF.text = [self.eventInfo objectForKey:@"event_description"];
    self.dateLbl.text = [self.eventInfo objectForKey:@"event_date_string"];
    self.locationLbl.text = [self.eventInfo objectForKey:@"event_location"];
}

- (void)viewDidUnload
{
    [self setTitleLbl:nil];
    [self setDateLbl:nil];
    [self setLocationLbl:nil];
    [self setDescriptionTF:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
