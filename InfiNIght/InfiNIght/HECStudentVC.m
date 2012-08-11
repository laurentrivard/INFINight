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
@synthesize backArrow = _backArrow;

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    _credTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 90, 300, 100) style:UITableViewStyleGrouped];
    [self.view addSubview:_credTableView];
    _credTableView.delegate = self;
    _credTableView.dataSource = self;
    _credTableView.bounces = NO;
    _credTableView.backgroundColor = [UIColor clearColor];
    
    _cellTitles = [[NSArray alloc] initWithObjects:@"Matricule", @"Groupe", nil ];
    
    _matriculeTF = [[UITextField alloc] initWithFrame:CGRectMake(139, 106, 144, 30)];
    _matriculeTF.backgroundColor = [UIColor clearColor];
    _matriculeTF.placeholder = @"Obligatoire";
    _matriculeTF.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    _matriculeTF.clearButtonMode = UITextFieldViewModeAlways;
    _matriculeTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _matriculeTF.returnKeyType = UIReturnKeyNext;
    _matriculeTF.tag = 0;
    _matriculeTF.delegate = self;
    _matriculeTF.keyboardType = UIKeyboardTypeDecimalPad;
    [_matriculeTF becomeFirstResponder];

    _groupeTF = [[UITextField alloc] initWithFrame:CGRectMake(139, 141, 144, 30)];
    _groupeTF.backgroundColor = [UIColor clearColor];
    _groupeTF.placeholder = @"Obligatoire";
    _groupeTF.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    _groupeTF.clearButtonMode = UITextFieldViewModeAlways;
    _groupeTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _groupeTF.returnKeyType = UIReturnKeyGo;
    _groupeTF.delegate = self;
    _groupeTF.tag =1;
    
    [self.view addSubview:_matriculeTF];
    [self.view addSubview:_groupeTF];
    
    
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
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    switch (textField.tag) {
        case 0:
            [[NSUserDefaults standardUserDefaults] setObject:_matriculeTF.text forKey:@"matricule"];
            [_groupeTF becomeFirstResponder];
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setObject:_groupeTF.text forKey:@"group"];
            [self check];
            break;
        default:
            break;
    }
    return NO;
}
-(void) check {
    NSArray *params = [[NSArray alloc] initWithObjects:_matriculeTF.text, _groupeTF.text, nil];
    if([self checkFields:params]) {
        
        [self crossReferenceGroups];
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
            [_groupeTF becomeFirstResponder];
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
    if(_matriculeTF.text.length != 9)
        return NO;
    
    [[NSUserDefaults standardUserDefaults] setObject:_matriculeTF.text forKey:@"matricule"];
    [[NSUserDefaults standardUserDefaults] setObject:_groupeTF.text forKey:@"groupe"];
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
    [params setObject:[currentDefaults objectForKey:@"name"] forKey:@"name"];
    [params setObject:@"join" forKey:@"cmd"];
    [params setObject:[currentDefaults objectForKey:@"matricule"] forKey:@"matricule"];
    [params setObject:[currentDefaults objectForKey:@"groupe"] forKey:@"groupe"];
    [params setObject:[currentDefaults objectForKey:@"year"] forKey:@"grad_year"];
    [params setObject:[currentDefaults objectForKey:@"school"] forKey:@"school"];
    [params setObject:uuid forKey:@"udid"];
    [params setObject:[currentDefaults objectForKey:@"device_token"] forKey:@"token"];
#if TARGET_IPHONE_SIMULATOR
    [params setObject:@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" forKey:@"token"];   //test for simulator
#endif

    NSLog(@"token :%@", [currentDefaults stringForKey:@"device_token"]);
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api/api.php" parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        
        NSLog(@"Success on creating account");
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"first_time"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //call function for HECActivities to fetch events
        [self.delegate studentRegistrationWasSuccessful:@"success"];
        NSLog(@"DELEGATE FUNCTION WAS CALLED");
        
        [self dismissModalViewControllerAnimated:YES];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [operation error]);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Une erreur est survenue." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        [hud hide: YES];
    }];
    
    [operation start];
}
-(void) checkGroups: (NSMutableArray *) groups {
    for(NSString *group in groups) {
        NSLog(@"self.grouptf : %@", _groupeTF.text);
        NSLog(@"group :%@", group);
        if([group isEqualToString:_groupeTF.text]) {
            [self saveInfoToUserDefaults];
            [self addUserToDatabase];
            return;
        }
    }
    UIAlertView *groupAlert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Veuillez entrer un groupe valide" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [groupAlert show];
    
}

- (void) crossReferenceGroups {
    
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	hud.labelText = @"Validation...";
    hud.dimBackground = YES;
    
    
    NSURL *url = [NSURL URLWithString:@"http://50.116.56.171"];
    
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"/api/get/get_group_rankings.php" parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [self parseJSON:JSON];
        [hud hide:YES];
    } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON){
        NSLog(@"Failed: %@",[error localizedDescription]);
        [hud hide:YES];
    }];
    [operation start];
    
}

-(void) parseJSON: (id) JSON {
    
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dic in JSON) {
        [groups addObject:[dic objectForKey:@"group"]];
    }
    
    [self checkGroups:groups];
    
}

-(void) saveInfoToUserDefaults {
    [[NSUserDefaults standardUserDefaults] setObject:_matriculeTF.text forKey:@"matricule"];
    [[NSUserDefaults standardUserDefaults] setObject:_groupeTF.text forKey:@"group"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void) handleSingleTap :(UIGestureRecognizer *) singleTap {
    [self.navigationController popViewControllerAnimated: YES];
}





@end
