//
//  ReadQRCodeVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScanQRVC.h"
#import "ZBarSDK.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface ScanQRVC ()

@end

@implementation ScanQRVC
@synthesize titleField = _titleField;
@synthesize nameLbl = _nameLbl;
@synthesize groupLbl = _groupLbl;
@synthesize successImage = _successImage;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.titleField.text = [self.eventInfo valueForKey:@"event_title"];
    
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
    NSString *school = [remaining substringFromIndex:groupRange.location + 1];
    
    
    NSLog(@"NAME : %@ --- DEVICE TOKEN : %@ -----  GROUP : %@   year: %@", name, matricule, group, school);
    
    __name = name;
    __deviceToken = matricule;
    __group = group;
    __school = school;
    
    
    self.nameLbl.text = name;
    self.groupLbl.text = group;
    
    [self updateUser];
    
    
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


-(void) updateUser {
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _progressHUD.dimBackground = YES;
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"http://50.116.56.171"];
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:baseUrl];
    [httpClient defaultValueForHeader:@"Accept"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[self.eventInfo valueForKey:@"event_id"] forKey:@"event_id"];
    [params setObject:__deviceToken forKey:@"device_token"];
    [params setObject:__name forKey:@"name"];
    [params setObject:[self.eventInfo valueForKey:@"event_title"] forKey:@"event_name"];
    [params setObject:__group forKey:@"group"];
    [params setObject:__school forKey:@"school"];
    
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api/scan.php" parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [operation responseString];
        NSLog(@"response: [%@]",response);
        NSLog(@"responseobject: %@", responseObject);
        self.successImage.image = [UIImage imageNamed:@"Checkmark.png"];
        [_progressHUD hide:YES];
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [operation error]);
        self.successImage.image = [UIImage imageNamed:@"X.png"];
        [_progressHUD hide:YES];
    }];
    
    [operation start];
}
- (IBAction)launchScanner:(id)sender {
    [self launchScanner];
}
- (void)viewDidUnload {
    
    [self setGroupLbl:nil];
    [self setNameLbl:nil];
    [self setSuccessImage:nil];
    [self setTitleField:nil];
    [super viewDidUnload];
}
-(IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
