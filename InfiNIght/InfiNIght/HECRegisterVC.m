//
//
//
// Copyright Promo InfiNIght
// By Laurent Rivard
//
//
//
#import "HECRegisterVC.h"
#import "HECRegisterCell.h"
@interface HECRegisterVC ()

@end

@implementation HECRegisterVC
@synthesize nameTF = _nameTF;
@synthesize matriculeTF = _matriculeTF;
@synthesize groupeTF = _groupeTF;
@synthesize yearTF = _yearTF;
@synthesize _credTableView;
@synthesize registerBtn;

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
    
 //   _credTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 80, 310, 175) style:UITableViewStyleGrouped];
    
    _cellTitles= [[NSArray alloc] initWithObjects:@"Nom Complet", @"Matricule", @"Groupe", @"Année", nil];
    _credTableView.backgroundColor = [UIColor clearColor];
    _credTableView.delegate = self;
    _credTableView.dataSource = self;
//    [self.view addSubview:_credTableView];
    
    //init text fields
    self.nameTF.delegate = self;
    self.matriculeTF.delegate = self;
    self.groupeTF.delegate = self;
    self.yearTF.delegate = self;
    
    //Harcoded so the tableview looks great
    [self.groupeTF setFrame:CGRectMake(139, 167, 100, 30)];
    
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
//    cell.inputTextField.tag = _tagCell;
    cell.cellTitle.text = [_cellTitles objectAtIndex:indexPath.row];
//    cell.inputTextField.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if(cell.inputTextField.tag == 3)
//        cell.inputTextField.returnKeyType = UIReturnKeyDone;
    
    
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
            [self.yearTF becomeFirstResponder];
            break;
        case 3:
          
           if([self checkAllLoginFields])
               [self go:nil];
           else {
               //ALRETVIEWWWSSSSSS
           }
            
            
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
        case 3:
            [self.yearTF becomeFirstResponder];
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
    [self set_credTableView:nil];
    [self setNameTF:nil];
    [self setMatriculeTF:nil];
    [self setGroupeTF:nil];
    [self setYearTF:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"should clear");
    
}
//-(BOOL) textFieldShouldReturn:(UITextField *)textField {
//
////    //Get the indexPath for the currently selected cell
////    NSIndexPath *cellPath = [(UITableView*)[self view] indexPathForSelectedRow];
////    
////    //Get the actual cell
////    CustomTableCell *cell = (CustomTableCell *)[(UITableView*)[self view] cellForRowAtIndexPath:cellPath];
////    
////    int currentTag = textView.tag;
////    int nextTag = currentTag + 1; // or something else
////    
////    UITextView *nextTV = [cell viewWithTag: nextTag];
////    [nextTV becomesFirstResponder];
//    
//    
//    //////////////////
//    NSIndexPath *indexPath = [_credTableView indexPathForSelectedRow];
//    HECRegisterCell* cell = (HECRegisterCell *) [_credTableView cellForRowAtIndexPath:indexPath];
//    
//    int currentTag = cell.inputTextField.tag;
//    NSLog(@"cell tag : %d", cell.inputTextField.tag);
//    int nextTag = currentTag +1;
//    
//    UITextView *nextTextView = [cell viewWithTag:nextTag];
//    
//    [nextTextView resignFirstResponder];
//    
//   // [cell.inputTextField.t becomeFirstResponder];
//
//    
//    return NO;
//}

- (IBAction)go:(UIButton *)sender {
    
    [self saveInfoToUserDefaults];
    [self dismissModalViewControllerAnimated:YES];
}
-(BOOL) checkAllLoginFields {
    return YES;
}
-(void) saveInfoToUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //user has login for first time
    [defaults setObject:@"NO" forKey:@"first_time"];

    [defaults setObject:self.nameTF.text forKey:@"name"];
    [defaults setObject:self.matriculeTF.text forKey:@"matricule"];
    [defaults setObject:self.groupeTF.text forKey:@"groupe"];
    [defaults setObject:self.yearTF.text forKey:@"year"];
    
    [defaults synchronize];
    
}
@end
