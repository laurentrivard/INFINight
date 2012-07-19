//
//  HECActivites.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HECActivites.h"
#import "HECRegisterVC.h"
#import "HECPartyDetailVC.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface HECActivites ()

@end

@implementation HECActivites

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //////////////////////////////////////////////////
    //on first load, show the register page
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshActivities)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"activities_navBar.png"] forBarMetrics:UIBarMetricsDefault];
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"first_time"] isEqualToString:@"YES"]) {
        HECRegisterVC *reg = [[HECRegisterVC alloc] initWithNibName:@"HECRegisterVC" bundle:[NSBundle mainBundle]];
    
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self presentModalViewController:reg animated:YES];
        });
    }
//////////////////////////////////////////////////
    if(!_events) {
        _events = [[NSMutableArray alloc] init];
        [self refreshActivities];
    }

    if(!_dates)
        _dates = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return [[_events objectAtIndex:section] valueForKey:@"event_date"];
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  20.0;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_events count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [[_events objectAtIndex:indexPath.section] valueForKey:@"event_title"];
    
    return cell;
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HECPartyDetailVC *partyDetail = [[HECPartyDetailVC alloc] initWithNibName:@"HECPartyDetailVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:partyDetail animated:YES];
}

-(void) refreshActivities {
    NSLog(@"refresh tapped");
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.dimBackground = YES;
    hub.labelText = @"Chargement des évènements...";
    
    id last = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastActivityFetched"];
    NSLog(@"last : %@", last);
    
    
    NSURL *url = [NSURL URLWithString:@"http://10.11.1.59:8888/get/get_events"];
    
    //////////////////////
        //////////////////////
        //////////////////////
        //////////////////////
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];    //GOOD CODE!

        //////////////////////
        //////////////////////
        //////////////////////
        //////////////////////
    ///////////////////////////////////////////////////

  /////////////////////////////////////////// code below to delete if request doesn't work  
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:url];
//    [httpClient defaultValueForHeader:@"Accept"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"lastActivityFetched"] forKey:@"last"];
 
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"" parameters:params];
    ///////////////////////////////////////////////////

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Public Timeline: %@", JSON);
        [self parseJSON:JSON];
        [hub hide:YES];
    } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON){
        NSLog(@"Failed: %@",[error localizedDescription]);        
    }];
    [operation start];
}
-(void) parseJSON: (NSArray *) json {
    
    //parsing results gotten from web server
    for(NSDictionary *dic in json) {
        [_events addObject:dic];
//        [_dates addObject:[dic valueForKey:@"date_created"]];
    }
    //getting the last created event's date
    int count = [_events count] -1;
    [[NSUserDefaults standardUserDefaults] setObject: [[_events objectAtIndex:count] valueForKey:@"date_created"] forKey:@"lastActivityFetched"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"last date : %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"lastActivityFetched"]);
    //we got the elements, so updating the tableview 
    [self.tableView reloadData];
}

-(void) orderDates: (NSMutableArray *) dates {
    
}

@end
