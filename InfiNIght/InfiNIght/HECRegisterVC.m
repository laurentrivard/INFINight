#import "HECRegisterVC.h"
#import "HECRegisterCell.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "HECBarLoginVC.h"

@interface HECRegisterVC ()

@end

@implementation HECRegisterVC
@synthesize nameTF = _nameTF;
@synthesize matriculeTF = _matriculeTF;
@synthesize groupeTF = _groupeTF;
@synthesize registerBtn;
@synthesize delegate;

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
    
    [self.registerBtn setBackgroundImage:[UIImage imageNamed:@"HECRegisterBottom.jpg"] forState:UIControlStateNormal];
    
    //picker view for schools
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.frame = CGRectMake(0, 200, 320, 162);
    picker.backgroundColor = [UIColor blackColor];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
    [self.view addSubview:picker];
        
    _cellTitles= [[NSArray alloc] initWithObjects:@"Prénom", @"Nom de Famille", @"Année", nil];
    _credTableView.backgroundColor = [UIColor clearColor];
    _credTableView.delegate = self;
    _credTableView.dataSource = self;
    
    //init text fields
    self.nameTF.delegate = self;
    self.matriculeTF.delegate = self;
    self.groupeTF.delegate = self;
    
    self.nameTF.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    self.matriculeTF.autocapitalizationType = UITextAutocapitalizationTypeSentences;


    //Harcoded so the tableview looks great
    [self.groupeTF setFrame:CGRectMake(139, 167, 144, 30)];
    
    
    mtlSchools = [NSArray arrayWithObjects:@"HEC Montréal", @"Concordia", @"McGill",@"Polytechnique",  @"Université de Montréal", @"UQAM",@"Bar Officiel", nil];
    [self.nameTF becomeFirstResponder];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
            [self.matriculeTF becomeFirstResponder];
            break; 
        case 1:
            [self.groupeTF becomeFirstResponder];
            break;
        case 2:
            [textField resignFirstResponder];
            break;
        default:
            break;
    }
    return NO;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    switch (indexPath.row) {
        case 0:
            [self.nameTF becomeFirstResponder];
            break;
        case 1:
            [self.matriculeTF becomeFirstResponder];
            break;
        case 2: 
            [self.groupeTF becomeFirstResponder];
            break;

        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)viewDidUnload
{
    [self setRegisterBtn:nil];
    [self setNameTF:nil];
    [self setMatriculeTF:nil];
    [self setGroupeTF:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) viewDidAppear:(BOOL)animated {
    [self.navigationController.navigationBar setHidden:YES];

}
-(void) textFieldDidBeginEditing:(UITextField *)textField {
    
}
-(IBAction)go:(id)sender {
    NSLog(@"hello!!");
    [self saveInfoToUserDefaults];
    
    NSArray *params = [NSArray arrayWithObjects:self.nameTF.text, self.matriculeTF.text, self.groupeTF.text, nil];

    if([self checkFields:params]) {
        [self saveInfoToUserDefaults];
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"school"] isEqualToString:[NSString stringWithFormat:@"%@", [mtlSchools objectAtIndex:0]]]) {  //student goes to HEC
            NSLog(@"Goes to HEC");
            
            HECStudentVC *student = [[HECStudentVC alloc] initWithNibName:@"HECStudentVC" bundle:[NSBundle mainBundle]];

            [self.navigationController pushViewController:student animated:YES];
        }
        else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"school" ]  isEqualToString:[NSString stringWithFormat:@"%@", [mtlSchools lastObject]]]) {
            HECBarLoginVC *bar = [[HECBarLoginVC alloc] initWithNibName:@"HECBarLoginVC" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:bar animated:YES];

        }
        else {   //student does not go to HEC
            [self addUserToDatabase];
        }
    }
    
    else {
            UIAlertView *failed = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Veuillez compléter tous les champs obligatoires. \n Assurez-vous que votre année de graduation soit vraie..bla"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [failed show];
        } 
}

-(BOOL) checkFields: (NSArray *) params {
    
    NSLog(@"params :%@", params);
    
    if([[params objectAtIndex:0] isEqualToString:@""] || [[params objectAtIndex:1] isEqualToString:@""] ||[[params objectAtIndex:2] isEqualToString:@""]) {
        return  NO;
    }
    if([self.groupeTF.text intValue] < 2000 || [self.groupeTF.text intValue] > 2025)
        return NO;
    
    
    return YES;
}

-(void) saveInfoToUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //user has login for first time
    NSString *fullName = self.nameTF.text;
    fullName = [fullName stringByAppendingString:[NSString stringWithFormat:@" %@", self.matriculeTF.text]];
    NSLog(@"FUL NAME BEFORE SAVE : %@", fullName);
    
    [defaults setObject:fullName forKey:@"name"];
    [defaults setObject:self.groupeTF.text forKey:@"year"];
    
    [defaults synchronize];
    
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
    
    
    [params setObject:@"join" forKey:@"cmd"];
    [params setObject:[currentDefaults objectForKey:@"name"] forKey:@"name"];
    [params setObject:@"0" forKey:@"matricule"];   //set default to zero
    [params setObject:@"0" forKey:@"groupe"];       //set default to zero
    [params setObject:[currentDefaults objectForKey:@"year"] forKey:@"grad_year"];
    [params setObject:[currentDefaults objectForKey:@"school"] forKey:@"school"];
    [params setObject:uuid forKey:@"udid"];
    NSLog(@"token :%@", [currentDefaults stringForKey:@"device_token"]);

#if TARGET_IPHONE_SIMULATOR
    [params setObject:@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" forKey:@"token"];
#else
    [params setObject:[currentDefaults objectForKey:@"device_token"] forKey:@"token"];

#endif

    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api/api.php" parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        
        NSLog(@"Success on creating account");
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"first_time"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //call function for HECActivities to fetch events
        [self.delegate registrationWasSuccessful:@"success"];
        
        [self dismissModalViewControllerAnimated:YES];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [operation error]);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Une erreur est survenue." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        [hud hide: YES];
    }];
    
    [operation start];
}

//picker view code
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [mtlSchools count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [mtlSchools objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [[NSUserDefaults standardUserDefaults] setObject:[mtlSchools objectAtIndex:row] forKey:@"school"];
    NSLog(@"%@", [mtlSchools objectAtIndex:row]);
}


@end
