//
//  HECStudentVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 8/2/12.
//
//

#import "HECStudentVC.h"
#import "HECRegisterCell.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface HECStudentVC ()

@end

@implementation HECStudentVC
@synthesize registerBtn = _registerBtn;
@synthesize backArrow = _backArrow;

- (void)viewDidLoad
{
    [super viewDidLoad];

    //group is 1 is they don't change group with the picker
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"groupe"];
    
    //all the groups for 2012-2013
    groups = [[NSArray alloc] initWithObjects:  @"1", @"2", @"3", @"4", @"5",
                                                @"6", @"7", @"8", @"9", @"10",
                                                @"11", @"12", @"13", @"14", @"15",
                                                @"16", @"21", @"22", @"23", nil];
    
    [self.registerBtn setBackgroundImage:[UIImage imageNamed:@"HECRegisterBottom.jpg"] forState:UIControlStateNormal];

    _credTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 90, 300, 100) style:UITableViewStyleGrouped];
    [self.view addSubview:_credTableView];
    _credTableView.delegate = self;
    _credTableView.dataSource = self;
    _credTableView.bounces = NO;
    _credTableView.backgroundColor = [UIColor clearColor];
    
    //picker view for schools
    picker = [[UIPickerView alloc] init];
    picker.frame = CGRectMake(0, 170, 320, 162);
    picker.backgroundColor = [UIColor blackColor];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
    UILabel *groupeLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 140, 200, 40)];
    groupeLbl.text = @"Selectionnez votre groupe";
    groupeLbl.backgroundColor = [UIColor clearColor];
    groupeLbl.textColor = [UIColor whiteColor];
    [self.view addSubview:groupeLbl];
    [self.view addSubview:picker];
    
    _cellTitles = [[NSArray alloc] initWithObjects:@"Matricule", nil ];
    
    _matriculeTF = [[UITextField alloc] initWithFrame:CGRectMake(139, 106, 144, 30)];
    _matriculeTF.backgroundColor = [UIColor clearColor];
    _matriculeTF.placeholder = @"Obligatoire";
    _matriculeTF.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    _matriculeTF.clearButtonMode = UITextFieldViewModeAlways;
    _matriculeTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _matriculeTF.returnKeyType = UIReturnKeyNext;
    _matriculeTF.tag = 0;
    _matriculeTF.delegate = self;
    _matriculeTF.keyboardType = UIKeyboardTypeNumberPad;
    [_matriculeTF becomeFirstResponder];

//    _groupeTF = [[UITextField alloc] initWithFrame:CGRectMake(139, 141, 144, 30)];
//    _groupeTF.backgroundColor = [UIColor clearColor];
//    _groupeTF.placeholder = @"Obligatoire";
//    _groupeTF.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
//    _groupeTF.clearButtonMode = UITextFieldViewModeAlways;
//    _groupeTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    _groupeTF.returnKeyType = UIReturnKeyGo;
//    _groupeTF.delegate = self;
//    _groupeTF.tag =1;
    
    [self.view addSubview:_matriculeTF];
//    [self.view addSubview:_groupeTF];
    
    UITapGestureRecognizer *pickerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePickerTap:)];
    [picker addGestureRecognizer:pickerTap];
    
    self.backArrow.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.backArrow addGestureRecognizer:singleTap];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_matriculeTF resignFirstResponder];
}

- (void)viewDidUnload
{
    [self setBackArrow:nil];
    [self setRegisterBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    switch (textField.tag) {
        case 0:
            [[NSUserDefaults standardUserDefaults] setObject:_matriculeTF.text forKey:@"matricule"];
            [_groupeTF becomeFirstResponder];
            break;
        case 1:
         //  [self check];
            break;
        default:
            break;
    }
    return NO;
}
-(void) check {
    NSArray *params = [[NSArray alloc] initWithObjects:_matriculeTF.text, nil];
    if([self checkFields:params]) {
        
        [self saveInfoToUserDefaults];
        [self addUserToDatabase];
        
    }
    else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Assurez-vous de bien compléter tous les champs obligatoires" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [_matriculeTF becomeFirstResponder];
            break;
        case 1:
            break;
        default:
            break;
    }
}
-(BOOL) checkFields: (NSArray *) params {
    
    NSLog(@"params :%@", params);
    
    if([[params objectAtIndex:0] isEqualToString:@""] /*|| [[params objectAtIndex:1] isEqualToString:@""] */) {
        return  NO;
    }
    if(_matriculeTF.text.length != 8)
        return NO;
    
    [[NSUserDefaults standardUserDefaults] setObject:_matriculeTF.text forKey:@"matricule"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cellTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HECRegisterCell";
    HECRegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        NSArray *bundleObj = [[NSBundle mainBundle] loadNibNamed:@"HECRegisterCell" owner:nil options:nil];
        for(id current in bundleObj) {
            if([current isKindOfClass:[HECRegisterCell class]]) {
                cell = (HECRegisterCell *) current;
            }
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    cell.cellTitle.text = [_cellTitles objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (void) addUserToDatabase {
    NSLog(@"addUserToDatabase");
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	hud.labelText = @"Création du compte";
    hud.dimBackground = YES;
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    
    
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"http://50.116.56.171"];
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:baseUrl];
    [httpClient defaultValueForHeader:@"Accept"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *uuid = [AppDelegate device_id];
    NSLog(@"uuid: %@", uuid);
    if(![currentDefaults objectForKey:@"device_token"]) {
        NSLog(@"iphone sim");
        [self generateRandomToken];
    }
    [params setObject:[currentDefaults objectForKey:@"name"] forKey:@"name"];
    [params setObject:@"join" forKey:@"cmd"];
    [params setObject:[currentDefaults objectForKey:@"matricule"] forKey:@"matricule"];
    [params setObject:[currentDefaults objectForKey:@"groupe"] forKey:@"groupe"];
    [params setObject:[currentDefaults objectForKey:@"year"] forKey:@"grad_year"];
    [params setObject:[currentDefaults objectForKey:@"school"] forKey:@"school"];
    [params setObject:uuid forKey:@"udid"];
    
   
//#if TARGET_IPHONE_SIMULATOR
//    [params setObject:@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" forKey:@"token"];   //test for simulator
//#else
    NSLog(@"token :%@", [currentDefaults stringForKey:@"device_token"]);

    [params setObject:[currentDefaults objectForKey:@"device_token"] forKey:@"token"];
//#endif

    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api/api.php" parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        
        NSLog(@"Success on creating account");
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"first_time"];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"firstTimeEvents"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //call function for HECActivities to fetch events
 //       [self.delegate studentRegistrationWasSuccessful:@"success"];
 //       NSLog(@"DELEGATE FUNCTION WAS CALLED");
        
        [self dismissModalViewControllerAnimated:YES];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [operation error]);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Une erreur est survenue." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        [hud hide: YES];
    }];
    
    [operation start];
}
-(void) generateRandomToken {
    int tokenLength = 64;
    
    NSString *possibleChar = @"1234567890abcdefABCDEF";
    NSMutableString *subToken = [NSMutableString stringWithCapacity:tokenLength];
    
    for(int i =0; i <tokenLength; i++) {
        [subToken appendFormat:@"%C", [possibleChar characterAtIndex:arc4random() % [possibleChar length]]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:subToken forKey:@"device_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void) saveInfoToUserDefaults {
    [[NSUserDefaults standardUserDefaults] setObject:_matriculeTF.text forKey:@"matricule"];
   // [[NSUserDefaults standardUserDefaults] setObject:_groupeTF.text forKey:@"group"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void) handleSingleTap :(UIGestureRecognizer *) singleTap {
    [self.navigationController popViewControllerAnimated: YES];
}

//picker view code
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [groups count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [groups objectAtIndex:row];
   
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [[NSUserDefaults standardUserDefaults] setObject:[groups objectAtIndex:row] forKey:@"groupe"];
    NSLog(@"%@", [groups objectAtIndex:row]);
}

- (IBAction)submit:(id)sender {
    [self check];
}
-(void) handlePickerTap: (UIGestureRecognizer *) pickerTap {
    [_matriculeTF resignFirstResponder];
}
@end
