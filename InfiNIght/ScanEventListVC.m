//
//  ScanEventListVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 8/7/12.
//
//

#import "ScanEventListVC.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "ScanQRVC.h"
@interface ScanEventListVC ()

@end

@implementation ScanEventListVC
@synthesize tableview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self getEvents];
}

- (void)viewDidUnload
{
    [self setTableview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [newEvents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"here");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [[newEvents objectAtIndex:indexPath.section] valueForKey:@"event_title"];
    NSLog(@"%@", cell.textLabel.text);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanQRVC *scan = [[ScanQRVC alloc] initWithNibName:@"ScanQRVC" bundle:[NSBundle mainBundle]];
    
    scan.eventInfo = [newEvents objectAtIndex:indexPath.section];
    
    [self presentModalViewController:scan animated:YES];
    
    
}
-(void) getEvents {
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.dimBackground = YES;
    hub.labelText = @"Chargement ...";
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://50.116.56.171"];
    
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSDate *now = [NSDate date];
    NSDate *newDate = [now dateByAddingTimeInterval:-3600*24*365];
    
    
    [params setObject:newDate forKey:@"last"];
    
    
    
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"/api/get/get_events.php" parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [self parseJSON:JSON];
        [hub hide:YES];
    } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON){
        NSLog(@"Failed: %@",[error localizedDescription]);
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Assurez vous d'avoir accès à internet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorAlert show];
        [hub hide:YES];
    }];
    [operation start];
}
-(void) parseJSON: (NSArray *) json {
    newEvents = [[NSMutableArray alloc] init];
    
    //parsing results gotten from web server
    for(NSDictionary *dic in json) {
        [newEvents addObject:dic];
    }
    
 //   NSLog(@"%@", newEvents);
//    NSLog(@"count: %d", [newEvents count]);
    
    [self.tableview reloadData];
}

-(IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];

}
-(IBAction)refresh:(id)sender {
    [self getEvents];
}


@end

