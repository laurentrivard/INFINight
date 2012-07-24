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
#import "CoreData/CoreData.h"
#import "AppDelegate.h"
#import "Events.h"


@interface HECActivites ()

@end


@implementation HECActivites

@synthesize managedObjectContext=_managedObjectContext;


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
    
    if (_managedObjectContext == nil) 
    { 
        _managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
    }
    
    //////////////////////////////////////////////////
    //on first load, show the register page
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshActivities)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.title = @"Évènements";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"first_time"] isEqualToString:@"YES"]) {
        HECRegisterVC *reg = [[HECRegisterVC alloc] initWithNibName:@"HECRegisterVC" bundle:[NSBundle mainBundle]];
        reg.delegate = self;
    
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self presentModalViewController:reg animated:YES];
        });
    }
    else {
        
    if(!_events) {
        _events = [[NSMutableArray alloc] init];
        NSLog(@"last date before anything: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"lastActivityFetched"]);
        [self refreshActivities];
    }

    if(!_dates)
        _dates = [[NSMutableArray alloc] init];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{

    return [[tableViewEvents objectAtIndex:section] valueForKey:@"event_date_string"];
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  20.0;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.

    return [tableViewEvents count];
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
    cell.textLabel.text = [[tableViewEvents objectAtIndex:indexPath.section] valueForKey:@"event_title"];

    return cell;
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HECPartyDetailVC *partyDetail = [[HECPartyDetailVC alloc] initWithNibName:@"HECPartyDetailVC" bundle:[NSBundle mainBundle]];
    partyDetail.eventInfo = [tableViewEvents objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:partyDetail animated:YES];
}

-(void) refreshActivities {
    NSLog(@"getting events");
    newEventWasReceived = NO;
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.dimBackground = YES;
    hub.labelText = @"Chargement ...";

    
    
    NSURL *url = [NSURL URLWithString:@"http://10.11.1.59:8888/get/get_events"];

    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"lastActivityFetched"] forKey:@"last"];
 
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"" parameters:params];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"All Events: %@", JSON);
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
    NSMutableArray *newEvents = [[NSMutableArray alloc] init];
    
        //parsing results gotten from web server
        for(NSDictionary *dic in json) {
            [newEvents addObject:dic];
        }
    if([newEvents count] > 0) {
        
        NSLog(@"NEW EVENT");
        newEventWasReceived = YES;
        
    //getting the last created event's date
        int count = [newEvents count] -1;
        [[NSUserDefaults standardUserDefaults] setObject: [[newEvents objectAtIndex:count] valueForKey:@"date_created"] forKey:@"lastActivityFetched"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
        
        NSLog(@"last date : %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"lastActivityFetched"]);
    
        //save new events to core data
        [self saveToCoreData:newEvents];
        
        //fetch all events
        
    }
    if(newEventWasReceived) {
        [self readFromCoreData];
        NSLog(@"also read from core data");
    }
    else {
        [self readFromCoreData];
    }

}

-(void) saveToCoreData: (NSMutableArray *) events{
    NSLog(@"in save to core data");
    
    
    NSManagedObjectContext *context = [self managedObjectContext ];
    int count = 0;
    for(NSDictionary *dic in events) {
        NSLog(@"event added: %d", count);
        NSManagedObject *event = [NSEntityDescription insertNewObjectForEntityForName:@"Events" inManagedObjectContext:context];
    
        
        [event setValue:[[events objectAtIndex:count] objectForKey:@"event_title"] forKey:@"event_title"];
        [event setValue:[[events objectAtIndex:count] valueForKey:@"event_description"] forKey:@"event_desc"];
        [event setValue:[[events objectAtIndex:count] valueForKey:@"event_date"] forKey:@"event_date"];
        [event setValue:[[events objectAtIndex:count] valueForKey:@"event_location"] forKey:@"event_location"];
        [event setValue:[[events objectAtIndex:count] valueForKey:@"event_date_string"] forKey:@"event_date_string"];
        
        
        
    
    
        NSError *error;
    
        if(![context save:& error]) {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:nil delegate:self cancelButtonTitle:@"Retry" otherButtonTitles: nil];
        
            [errorAlert show];
        }
        count++;
    }
}
-(void) readFromCoreData {
    //update tableview from all elements saved in CoreData 
    if(!_events) 
        _events = [[NSMutableArray alloc] init];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription 
                                   entityForName:@"Events" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"event_date" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setEntity:entity];

    NSError *error;
    NSArray *tempEvents = [[NSArray alloc] init];
    tempEvents = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    [_events removeAllObjects];
    
    for(int i =0; i < [tempEvents count]; i ++ ) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        //organizing event infos
        Events *event = [tempEvents objectAtIndex:i];
        [dic setObject:event.event_title forKey:@"event_title"];
        [dic setObject:event.event_desc forKey:@"event_description"];
        [dic setObject:event.event_date forKey:@"event_date"];
        [dic setObject:event.event_location forKey:@"event_location"];
        NSLog(@"event date string just before adding: %@", event.event_date_string);
        [dic setObject:event.event_date_string forKey:@"event_date_string"];
        
        //add all events to display
        [_events addObject:dic];
        
    }

    tableViewEvents = [[NSArray alloc] initWithArray:_events];
    tableViewEvents = [[tableViewEvents reverseObjectEnumerator] allObjects];
    
    //after reloading all the new events, reload the tableview
    [self.tableView reloadData];

}
-(void) registrationWasSuccessful: (NSString *) success {
    NSLog(@"registrationWasSuccessful delegate callback : %@", success);
    if([success isEqualToString:@"success"])
        [self refreshActivities];
}


@end
