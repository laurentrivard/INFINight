//
//  ReadQRCodeVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReadQRCodeVC.h"
#import "ZBarSDK.h"
@interface ReadQRCodeVC ()

@end

@implementation ReadQRCodeVC

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

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    [self showSuccess];
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    
    //look to give confirmation on the screen instead of dismissing everytime
    NSLog(@"symbol data: %@", symbol.data);    

    
    // [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD symbol.data to their list for the night which will be updated to the server at 3 AM ?
    //could do it everytime, could do it at 3AM, could do it every hour...
    
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
}
- (IBAction)launchScanner:(UIButton *)sender {
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    
    [self presentModalViewController: reader
                            animated: YES];
}
-(void) showSuccess {
    //make the iphone vibrate? 
    
//    _confirmation = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    _confirmation.backgroundColor = [UIColor greenColor];
//    _confirmation.alpha = 1;
//    
//    UIImageView *successImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    UIImage *successImage = [UIImage imageNamed:@"ScanSuccess.png"];
//    successImageView.image = successImage;
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:1.0];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    _confirmation.frame = CGRectMake(0,-50,320,50);
//  //  _confirmation.frame = CGRectMake(0,0,320,35);
//    [UIView commitAnimations];
//
//    [_confirmation addSubview:successImageView];
//    [self.view addSubview:_confirmation];
//    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//    _progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]]; 
//    _progressHUD.mode = MBProgressHUDModeCustomView;
//	
//	_progressHUD.delegate = self;
//	
//	[_progressHUD show:YES];
//	[_progressHUD hide:YES afterDelay:3];
//    _progressHUD.labelText = @"Succès";
//    [self.view addSubview:_progressHUD];
//
//    [_progressHUD hide:YES afterDelay:1];
//     _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireTimer:) userInfo:nil repeats:NO];   
    
}


//-(void) fireTimer: (NSTimer *) timer {
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:2.0];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    _confirmation.frame = CGRectMake(0,0,320,35);
//    _confirmation.frame = CGRectMake(0,-110,320,20);
//    [UIView commitAnimations];
//    NSLog(@"suppp");
//}
@end
