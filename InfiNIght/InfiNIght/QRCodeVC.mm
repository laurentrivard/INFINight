//
//  QRCodeVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QRCodeVC.h"
#import "QREncoder.h"
#import "AFNetworking.h"
#import "AppDelegate.h"


@interface QRCodeVC ()

@end

@implementation QRCodeVC
@synthesize QRCode;

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
    NSLog(@"name: %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"name"]);
    NSLog(@"matricule: %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"matricule"]);
    NSLog(@"groupe: %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"groupe"]);
    NSLog(@"year: %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"year"]);
    NSLog(@"Device token: %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"device_token"]);
    
    //nav bar
    [self.navigationController setNavigationBarHidden:YES];
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
//    self.navigationItem.title = @"Code QR";
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self generateQRCode];
}

- (void)viewDidUnload
{
    [self setQRCode:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) generateQRCode {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //the qrcode is square. now we make it 250 pixels wide
    int qrcodeImageDimension = 200;
    
    //the string can be very long
    NSString* codeString = [NSString stringWithFormat: @"%@#%@#%@#%@", [defaults stringForKey:@"name"], [defaults stringForKey:@"device_token"], [defaults stringForKey:@"groupe"],[defaults stringForKey:@"school"]];
    
    NSLog(@"code string: %@", codeString);
    
    //first encode the string into a matrix of bools, TRUE for black dot and FALSE for white. Let the encoder decide the error correction level and version
    DataMatrix* qrMatrix = [QREncoder encodeWithECLevel:QR_ECLEVEL_AUTO version:QR_VERSION_AUTO string:codeString];
    
    //then render the matrix
    UIImage* qrcodeImage = [QREncoder renderDataMatrix:qrMatrix imageDimension:qrcodeImageDimension];
    
    
    //set the image as the QR Code
    QRCode.image = qrcodeImage;

}
- (IBAction)join:(id)sender {
    NSLog(@"join tapped");
    
    NSURL *url = [NSURL URLWithString:@"http://50.116.56.171/api/get/get_events"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
 //   [request setValue:[NSString stringWithFormat:@"application/json"] forHTTPHeaderField:@"Accept"];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Public Timeline: %@", JSON);
    } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON){
        NSLog(@"Failed: %@",[error localizedDescription]);        
    }];
    [operation start];
}
@end
