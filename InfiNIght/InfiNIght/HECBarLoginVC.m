//
//  HECBarLoginVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 8/8/12.
//
//

#import "HECBarLoginVC.h"
#import "HECRegisterCell.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MacAddressHelper.h"

@interface HECBarLoginVC ()

@end

@implementation HECBarLoginVC
@synthesize backArrow = _backArrow;

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
    
    _credTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 90, 300, 100) style:UITableViewStyleGrouped];
    [self.view addSubview:_credTableView];
    _credTableView.delegate = self;
    _credTableView.dataSource = self;
    _credTableView.bounces = NO;
    _credTableView.backgroundColor = [UIColor clearColor];
    
    _cellTitles = [[NSArray alloc] initWithObjects:@"Nom d'utilisateur", @"Mot de passe", nil ];
    
    _usernameTF = [[UITextField alloc] initWithFrame:CGRectMake(139, 106, 144, 30)];
    _usernameTF.backgroundColor = [UIColor clearColor];
    _usernameTF.placeholder = @"Obligatoire";
    _usernameTF.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    _usernameTF.clearButtonMode = UITextFieldViewModeAlways;
    _usernameTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _usernameTF.returnKeyType = UIReturnKeyNext;
    _usernameTF.tag = 0;
    _usernameTF.delegate = self;
    _usernameTF.keyboardType = UIKeyboardTypeAlphabet;
    [_usernameTF becomeFirstResponder];
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(139, 141, 144, 30)];
    _passwordTF.backgroundColor = [UIColor clearColor];
    _passwordTF.placeholder = @"Obligatoire";
    _passwordTF.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    _passwordTF.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordTF.returnKeyType = UIReturnKeyGo;
    _passwordTF.delegate = self;
    _passwordTF.tag =1;
    _passwordTF.secureTextEntry = YES;
    
    [self.view addSubview:_usernameTF];
    [self.view addSubview:_passwordTF];
    
    
    self.backArrow.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.backArrow addGestureRecognizer:singleTap];
}

- (void)viewDidUnload
{
    [self setBackArrow:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    switch (textField.tag) {
        case 0:
            [[NSUserDefaults standardUserDefaults] setObject:_usernameTF.text forKey:@"matricule"];
            [_passwordTF becomeFirstResponder];
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setObject:_passwordTF.text forKey:@"group"];
            [self check];
            break;
        default:
            break;
    }
    return NO;
}
-(void) check {
    NSArray *params = [[NSArray alloc] initWithObjects:_usernameTF.text, _passwordTF.text, nil];
    if([self checkFields:params]) {
    
        [self checkCreds];
        
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
            [_usernameTF becomeFirstResponder];
            break;
        case 1:
            [_passwordTF becomeFirstResponder];
            break;
        default:
            break;
    }
}
-(BOOL) checkFields: (NSArray *) params {
    
    NSLog(@"params :%@", params);
    
    if([[params objectAtIndex:0] isEqualToString:@""] || [[params objectAtIndex:1] isEqualToString:@""] ) {
        return  NO;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:_usernameTF.text forKey:@"matricule"];
    [[NSUserDefaults standardUserDefaults] setObject:_passwordTF.text forKey:@"groupe"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}
-(void) handleSingleTap: (UIGestureRecognizer *) singleTap {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) checkCreds {

    NSLog(@"checking creds");
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	hud.labelText = @"Authorization...";
    hud.dimBackground = YES;
        
    
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"http://50.116.56.171"];
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:baseUrl];
    [httpClient defaultValueForHeader:@"Accept"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:_usernameTF.text forKey:@"username"];
    [params setObject:_passwordTF.text forKey:@"password"];



    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api/barlogin.php" parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        
        NSLog(@"Success on creating account");
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"first_time"];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"canScan"];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"firstTimeEvents"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //call function for HECActivities to fetch events
        
        NSString *responseStr = [NSString stringWithUTF8String:[responseObject bytes]];

        NSLog(@"reponse object: %@", responseStr);
        if([responseStr isEqualToString:@"1"]) {
//            NSLog(@"YES");
//            NSLog(@"Success on creating account");
//            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"first_time"];
//            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"canScan"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            
//            [self dismissModalViewControllerAnimated:YES];
            
            [self addScannerToDatabase];
        }
        else {
            UIAlertView *nope = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Nom d'utilisateur/mot de passe invalide" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [nope show];
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [operation error]);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Une erreur est survenue." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        [hud hide: YES];
    }];
    
    [operation start];
}



///////////////////////////////////////////////
///////////////////////////////////////////////
///////////////////////////////////////////////
///////////////////////////////////////////////
- (void) addScannerToDatabase {
    NSLog(@"addScannerToDatabase");
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	hud.labelText = @"Création du compte";
    hud.dimBackground = YES;
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    
    
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"http://50.116.56.171"];
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:baseUrl];
    [httpClient defaultValueForHeader:@"Accept"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSDate *now = [NSDate date];
    NSString *uuid = [AppDelegate device_id];
    NSLog(@"uuid: %@", uuid);
    
    if(![currentDefaults objectForKey:@"device_token"]) {
        NSLog(@"didn't register for push");
        [self generateRandomToken];
    }
    
    [params setObject:[currentDefaults objectForKey:@"name"] forKey:@"name"];
    [params setObject:@"join_scanner" forKey:@"cmd"];
    [params setObject:now forKey:@"date"];
    [params setObject:uuid forKey:@"udid"];
//#if TARGET_IPHONE_SIMULATOR
//    [params setObject:@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" forKey:@"token"];   //test for simulator
//#else
    [params setObject:[currentDefaults objectForKey:@"device_token"] forKey:@"token"];
//#endif
    
    NSLog(@"token :%@", [currentDefaults stringForKey:@"device_token"]);
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api/api.php" parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"YES");
            NSLog(@"Success on creating account");
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"first_time"];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"canScan"];
            [[NSUserDefaults standardUserDefaults] synchronize];
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
    
    NSString *mac = [MacAddressHelper getMacAddress];
    
    int toGo = tokenLength - [mac length];
    
    
    for(int i =0; i <toGo; i++) {
        mac = [mac stringByAppendingString:@"a"];
    }
    
    NSLog(@"new token count: %d", [mac length]);
    
    [[NSUserDefaults standardUserDefaults] setObject:mac forKey:@"device_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
