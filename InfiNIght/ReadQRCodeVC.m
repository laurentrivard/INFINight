//
//  ReadQRCodeVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReadQRCodeVC.h"
#import "ZBarSDK.h"
#import "AFNetworking.h"

@interface ReadQRCodeVC ()

@end

@implementation ReadQRCodeVC
@synthesize nameLbl = _nameLbl;
@synthesize matriculeLbl = _matriculeLbl;
@synthesize groupLbl = _groupLbl;
@synthesize yearLbl = _yearLbl;


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
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        NSLog(@"Cancel");
        
    }
    else
    {
        [self launchScanner];
    }
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    //make phone vibrate when scan succeeds
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    
    //parse the stupid string
    NSRange nameRange = [symbol.data rangeOfCharacterFromSet:[NSCharacterSet  characterSetWithCharactersInString:@"#"]];
    NSString *name = [symbol.data substringToIndex:nameRange.location];  //name
    NSString *remaining = [symbol.data  substringFromIndex:nameRange.location + 1];
    NSRange matriculeRange = [remaining rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    NSString *matricule = [remaining substringToIndex:matriculeRange.location]; //matricule
    remaining = [remaining substringFromIndex:matriculeRange.location + 1];
    NSRange groupRange = [remaining rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    NSString *group = [remaining substringToIndex:groupRange.location];
    NSString *year = [remaining substringFromIndex:groupRange.location + 1];
    
    self.nameLbl.text = name;
    self.matriculeLbl.text = matricule;
    self.groupLbl.text = group;
    self.yearLbl.text = year;

    [self updatePoints: group];
    

    // [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD symbol.data to their list for the night which will be updated to the server at 3 AM ?
    //could do it everytime, could do it at 3AM, could do every hour...
    
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
}
- (void)launchScanner {
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

-(void) updatePoints: (NSString *) group {
    
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"http://10.11.1.59:8888"];
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:baseUrl];
    [httpClient defaultValueForHeader:@"Accept"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:@"updateRankings" forKey:@"cmd"];
    [params setObject:group forKey:@"group"];
    
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api.php" parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [operation responseString];
        NSLog(@"response: [%@]",response);
        NSLog(@"responseobject: %@", responseObject);
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [operation error]);        
    }];
    
    [operation start];
}
- (IBAction)launchScanner:(id)sender {
    [self launchScanner];
}
- (void)viewDidUnload {

    [self setYearLbl:nil];
    [self setGroupLbl:nil];
    [self setMatriculeLbl:nil];
    [self setNameLbl:nil];
    [super viewDidUnload];
}
@end
