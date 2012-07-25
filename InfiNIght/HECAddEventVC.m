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
@synthesize titleCharacterCount;
@synthesize descriptionCharacterCount;
@synthesize locationCharacterCount;
@synthesize entryFields;

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

    
        //uitextviewdelegate
    self.titleTF.delegate = self;
    self.descriptionTF.delegate = self;
    self.locationTF.delegate = self;
    
    [self.titleTF becomeFirstResponder];
    
    self.titleCharacterCount.text = @"50";
    self.descriptionCharacterCount.text = @"250";
    self.locationCharacterCount.text =@"50";
     
    
}

-(void) textViewDidChange:(UITextView *)textView {
    //title
    self.titleCharacterCount.text = [NSString stringWithFormat:@"%d", 50 - self.titleTF.text.length];
    if(self.titleTF.text.length >=40)
        [self.titleCharacterCount setTextColor:[UIColor yellowColor]];
    if(self.titleTF.text.length >50)
        [self.titleCharacterCount setTextColor:[UIColor redColor]];
    
    //description
    self.descriptionCharacterCount.text = [NSString stringWithFormat:@"%d", 250 - self.descriptionTF.text.length];
    if(self.descriptionTF.text.length >= 235)
        [self.descriptionCharacterCount setTextColor:[UIColor yellowColor]];
    if(self.descriptionTF.text.length > 250)
        [self.descriptionCharacterCount setTextColor:[UIColor redColor]];
    
    //location
    self.locationCharacterCount.text = [NSString stringWithFormat:@"%d", 50 - self.locationTF.text.length];
    if(self.locationTF.text.length >= 45)
        [self.locationCharacterCount setTextColor:[UIColor yellowColor]];
    if(self.locationTF.text.length > 50)
        [self.locationCharacterCount setTextColor:[UIColor redColor]];
    
}

- (void)viewDidUnload
{
    [self setTitleTF:nil];
    [self setDescriptionTF:nil];
    [self setLocationTF:nil];
    [self setTitleCharacterCount:nil];
    [self setDescriptionCharacterCount:nil];
    [self setLocationCharacterCount:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//method to get all text views
- (NSArray *)entryFields {  
    if (!entryFields) {  
        self.entryFields = [[NSMutableArray alloc] init];  
        NSInteger tag = 1;  
        UIView *aView;  
        while ((aView = [self.view viewWithTag:tag])) {  
            if (aView && [[aView class] isSubclassOfClass:[UIResponder class]]) {  
                [entryFields addObject:aView];  
            }  
            tag++;  
        }  
    }  
    return entryFields;  
} 

//When hitting return, change to next textview
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {  
    BOOL shouldChangeText = YES;  
    
    if ([text isEqualToString:@"\n"]) {  
        // Find the next entry field  
        BOOL isLastField = YES;  
        for (UIView *view in [self entryFields]) {  
            if (view.tag == (textView.tag + 1)) {  
                [view becomeFirstResponder];  
                isLastField = NO;  
                break;  
            }  
        }  
        if (isLastField) {  
            [textView resignFirstResponder];  
        }  
        
        shouldChangeText = NO;  
    }  
    
    return shouldChangeText;  
}  
-(void) textViewDidEndEditing:(UITextView *)textView {
    if(textView.tag ==1)
        NSLog(@"uyu");
}

-(IBAction)addEvent:(id)sender {
    if([self checkFields])
        [self pushEvent];
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Assurez-vous que le texte ne soit pas trop long." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}
-(BOOL) checkFields {
    if(self.titleTF.text.length >50 || self.descriptionTF.text.length > 250 || self.locationTF.text.length > 50)
        return NO;
    else 
        return YES;
    
}
//upload event to database 
-(void) pushEvent {
    
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

//sends push notifications to users
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
//pushes the controller to adding an event time
-(IBAction) addEventTime:(id)sender {
    HECAddEventTimeVC *addTime = [[HECAddEventTimeVC alloc] initWithNibName:@"HECAddEventTimeVC" bundle:[NSBundle mainBundle]];
    addTime.delegate = self;
    [self presentModalViewController:addTime animated:YES];
                                  
}

- (IBAction)choosePhoto:(id)sender {
    
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:_imagePicker animated:NO];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    

    
    UIImage *img = [[UIImage alloc] init];
    img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    if(img) {
//        imgView.image = img;
//        NSLog(@"theres na image");}
//    else {
//        imgView.image = [UIImage imageNamed:@"annieProfilePic.jpg"];
//    }
//    
//    [self.view addSubview:imgView];
    
        NSData *imgData = [[NSData alloc] initWithData:(UIImagePNGRepresentation(img))];
        
        NSLog(@"image was added successfully %@", imgData);
//    }
//    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
//    {
//        
//        //i don't think this is necessary
//        UIAlertView *notAPic = [[UIAlertView alloc] initWithTitle:nil message:@"You cannot choose a video" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//        
//        [notAPic show];
//    }
    
    [picker dismissModalViewControllerAnimated:YES];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // Dismiss the image selection and close the program
    [picker dismissModalViewControllerAnimated:YES];
}
-(void) passDateBack:(HECAddEventTimeVC *)controller didFinish:(NSDictionary *)dic{
    _newEventDate = [dic objectForKey:@"event_date"];
    
    //parse it before sending it ... cut out the seconds and Eastern Daylight Time
    int index = [[dic objectForKey:@"event_date_string"] length] -3 ;
    _dateString = [[dic objectForKey:@"event_date_string"] substringToIndex:index];
    
    NSLog(@"eventdatestring : %@" ,_dateString);
}
//-(void) uploadImgToServer: (NSData *) imgData {
//    NSData* sendData = [self.fileName.text dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *sendDictionary = [NSDictionary dictionaryWithObject:sendData forKey:@"name"];
//    NSURL *baseUrl = [[NSURL alloc] initWithString:@"http://10.11.1.59:8888"];
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseUrl];
//    NSMutableURLRequest *afRequest = [httpClient multipartFormRequestWithMethod:@"POST" 
//                                                                           path:@"/photos" 
//                                                                     parameters:sendDictionary 
//                                                      constructingBodyWithBlock:^(id <AFMultipartFormData>formData) 
//                                      {                                     
//                                          [formData appendPartWithFileData:photoImageData 
//                                                                      name:self.fileName.text 
//                                                                  fileName:filePath 
//                                                                  mimeType:@"image/jpeg"]; 
//                                      }
//                                      ];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:afRequest];
//    [operation setUploadProgressBlock:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
//        
//        NSLog(@"Sent %d of %d bytes", totalBytesWritten, totalBytesExpectedToWrite);
//        
//    }];
//    
//    [operation setCompletionBlock:^{
//        NSLog(@"%@", operation.responseString); //Gives a very scary warning
//    }];
//    
//    [operation start]; 
//}
@end
