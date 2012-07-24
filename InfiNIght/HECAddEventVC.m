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
#import "HECAddEventTimeVC.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;

@interface HECAddEventVC ()

@end

@implementation HECAddEventVC
@synthesize titleTF;
@synthesize descriptionTF;
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
    self.locationTF.delegate = self;
    
    [self.titleTF becomeFirstResponder];
    
}



- (void)viewDidUnload
{
    [self setTitleTF:nil];
    [self setDescriptionTF:nil];
    [self setLocationTF:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    switch (textField.tag) {
        case 0:
            [self.descriptionTF becomeFirstResponder];
            break;
        case 1:
            [self.locationTF becomeFirstResponder];
            break;
        case 2:
            [textField resignFirstResponder];

            break;

        default:
            break;
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
}
- (IBAction)addEvent:(id)sender {
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	hud.labelText = @"Ajout de l'évènement";
    hud.dimBackground = YES;
    
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"http://10.11.1.59:8888"];
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:baseUrl];
    [httpClient defaultValueForHeader:@"Accept"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:@"addEvent" forKey:@"cmd"];
    [params setObject:self.titleTF.text forKey:@"title"];
    [params setObject:self.descriptionTF.text forKey:@"description"];
    [params setObject:_newEventDate forKey:@"date"];
    [params setObject:self.locationTF.text forKey:@"location"]; 
    [params  setObject:_dateString forKey:@"event_date_string"];
    NSLog(@"date string i am passing with the params : %@", _dateString);
    
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
        [hud hide:YES];
        
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
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(void) sendPushNotificationToUsers {
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	hud.labelText = @"Envoi de la notification...";
    hud.dimBackground = YES;
    
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"http://10.11.1.59:8888"];
    
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
-(IBAction) addEventTime:(id)sender {
    HECAddEventTimeVC *addTime = [[HECAddEventTimeVC alloc] initWithNibName:@"HECAddEventTimeVC" bundle:[NSBundle mainBundle]];
    addTime.delegate = self;
    [self presentModalViewController:addTime animated:YES];
                                  
}
-(void) passDateBack:(HECAddEventTimeVC *)controller didFinish:(NSDictionary *)dic{
    _newEventDate = [dic objectForKey:@"event_date"];
    
    //parse it before sending it ... cut out the seconds and Eastern Daylight Time
    int index = [[dic objectForKey:@"event_date_string"] length] -3 ;
    _dateString = [[dic objectForKey:@"event_date_string"] substringToIndex:index];
    
    NSLog(@"eventdatestring : %@" ,_dateString);
}
@end
