//
//  HECAddEventVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HECAddEventVC.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;

@interface HECAddEventVC ()

@end

@implementation HECAddEventVC
@synthesize titleTF;
@synthesize descriptionTF;
@synthesize dateTF;
@synthesize locationTF;

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
    
    self.titleTF.delegate = self;
    self.descriptionTF.delegate = self;
    self.dateTF.delegate = self;
    self.locationTF.delegate = self;
}

- (void)viewDidUnload
{
    [self setTitleTF:nil];
    [self setDescriptionTF:nil];
    [self setDateTF:nil];
    [self setLocationTF:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    switch (textField.tag) {
        case 0:
            [self.descriptionTF becomeFirstResponder];
            break;
        case 1:
            [self.dateTF becomeFirstResponder];
            break;
        case 2:
            [self.locationTF becomeFirstResponder];
            break;
        case 3:
            [textField resignFirstResponder];
            break;
        default:
            break;
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    CGRect textFieldRect =
//    [self.view.window convertRect:textField.bounds fromView:textField];
//    CGRect viewRect =
//    [self.view.window convertRect:self.view.bounds fromView:self.view];
//    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
//    CGFloat numerator =
//    midline - viewRect.origin.y
//    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
//    CGFloat denominator =
//    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
//    * viewRect.size.height;
//    CGFloat heightFraction = numerator / denominator;
//    
//    if (heightFraction < 0.0)
//    {
//        heightFraction = 0.0;
//    }
//    else if (heightFraction > 1.0)
//    {
//        heightFraction = 1.0;
//    }
//        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
//    
//
//    
//    CGRect viewFrame = self.view.frame;
//    viewFrame.origin.y -= animatedDistance;
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
//    
//    [self.view setFrame:viewFrame];
//    
//    [UIView commitAnimations];
}
- (IBAction)addEvent:(id)sender {
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	hud.labelText = @"Ajout de l'évènement";
    hud.dimBackground = YES;
    
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"http://192.168.1.103:8888"];
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:baseUrl];
    [httpClient defaultValueForHeader:@"Accept"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:@"addEvent" forKey:@"cmd"];
    [params setObject:self.titleTF.text forKey:@"title"];
    [params setObject:self.descriptionTF.text forKey:@"description"];
    [params setObject:self.dateTF.text forKey:@"date"];
    [params setObject:self.locationTF.text forKey:@"location"];        
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api.php" parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        NSString *response = [operation responseString];
        NSLog(@"response: [%@]",response);
        NSLog(@"responseobject: %@", responseObject);
        
        UIAlertView *push = [[UIAlertView alloc] initWithTitle:@"" message:@"Envoyer une notification push aux utilisateurs?" delegate:nil cancelButtonTitle:@"Non" otherButtonTitles:@"Oui", nil];
        push.delegate = self;
        [push show];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [operation error]);
        
    }];
    
    [operation start];
}
-(IBAction)didCancelEvent:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

//respond to push notifications
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self dismissModalViewControllerAnimated:YES];
    }
    else if (buttonIndex == 1) {
        NSLog(@"sending push notification...");
        [self sendPushNotificationToUsers];
    }
}

-(void) sendPushNotificationToUsers {
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	hud.labelText = @"Envoi...";
    hud.dimBackground = YES;
    
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"http://192.168.1.103:8888"];
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:baseUrl];
    [httpClient defaultValueForHeader:@"Accept"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:@"message" forKey:@"cmd"];
    [params setObject:self.titleTF.text forKey:@"text"];
    
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api.php" parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [hud hide:YES];
        
        NSString *response = [operation responseString];
        NSLog(@"response: [%@]",response);
        NSLog(@"responseobject: %@", responseObject);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [operation error]);
        
    }];
    
    [operation start];
}
@end
