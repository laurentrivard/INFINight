//
//  QRCodeVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QRCodeVC.h"
#import "QREncoder.h"


@interface QRCodeVC ()

@end

@implementation QRCodeVC
@synthesize QRCode;
@synthesize nameLbl;

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
    NSLog(@"asdfasdf%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"name"]);
    self.nameLbl.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    [self generateQRCode];
}

- (void)viewDidUnload
{
    [self setQRCode:nil];
    [self setNameLbl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) generateQRCode {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //the qrcode is square. now we make it 250 pixels wide
    int qrcodeImageDimension = 200;
    
    //the string can be very long
    NSString* codeString = [NSString stringWithFormat: @"%@#%@#%@#%@", [defaults stringForKey:@"name"], [defaults stringForKey:@"matricule"], [defaults stringForKey:@"groupe"],[defaults stringForKey:@"year"]];
    
    //first encode the string into a matrix of bools, TRUE for black dot and FALSE for white. Let the encoder decide the error correction level and version
    DataMatrix* qrMatrix = [QREncoder encodeWithECLevel:QR_ECLEVEL_AUTO version:QR_VERSION_AUTO string:codeString];
    
    //then render the matrix
    UIImage* qrcodeImage = [QREncoder renderDataMatrix:qrMatrix imageDimension:qrcodeImageDimension];
    
    
    //set the image as the QR Code
    QRCode.image = qrcodeImage;

}
@end
