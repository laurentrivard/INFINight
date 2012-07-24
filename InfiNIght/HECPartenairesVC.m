//
//  HECPartenairesVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HECPartenairesVC.h"
#import "ReadQRCodeVC.h"

@interface HECPartenairesVC ()

@end

@implementation HECPartenairesVC

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
	// Do any additional setup after loading the view.

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)pushREAD:(id)sender {
    ReadQRCodeVC *read = [[ReadQRCodeVC alloc] initWithNibName:@"ReadQRCodeVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:read animated:YES];
}
@end
