//
//  HECTrophyVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HECTrophyVC.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "GroupCell.h"
#import "AppDelegate.h"
#import "CoreData/CoreData.h"

@implementation HECTrophyVC

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
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(getRankings)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.title = @"Classement";

    
    [self getRankings];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{return 1;}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{return @"Pos   Groupe      Points ";}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{return 35;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{return [groupPoints count];}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
  NSArray *myCustomCell = [[NSBundle mainBundle] loadNibNamed:@"GroupCell" owner:nil options:nil];
    if(cell == nil) {
        
        for(id currentObj in myCustomCell) {
            if([currentObj isKindOfClass:[GroupCell class]])
                cell = (GroupCell *) currentObj;
        }
     
    }
    
    int previousPos = [[[groupPoints objectAtIndex:indexPath.row] valueForKey:@"previous_position"] intValue];
    int currentPos = [[[groupPoints objectAtIndex:indexPath.row] valueForKey:@"current_position"] intValue];
    
    cell.groupName.text = [NSString stringWithFormat:@"%@",[[groupPoints objectAtIndex:indexPath.row] valueForKey:@"group"]];
    cell.groupPoints.text = [NSString stringWithFormat:@"%@ ", [[groupPoints objectAtIndex:indexPath.row] valueForKey:@"points"]];
    cell.position.text = [NSString stringWithFormat:@"%d", currentPos];
    
    
    //image
    if(currentPos < previousPos)
        cell.arrowIV.image = [UIImage imageNamed:@"greenArrow.png"];
    else if(currentPos > previousPos)
        cell.arrowIV.image = [UIImage imageNamed:@"redArrow.png"];
    else
        cell.arrowIV.image = [UIImage imageNamed:@"doubleArrow.gif"];
    

    return cell;
}


-(void) getRankings{
    NSLog(@"getting rankings");
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.dimBackground = YES;
    hub.labelText = @"Classement ...";
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://50.116.56.171"];
    
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"/api/get/get_group_rankings.php" parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"rankings: %@", JSON);
        [self parseJSON:JSON];
        [hub hide:YES];
    } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON){
        NSLog(@"Failed: %@",[error localizedDescription]);   
        UIAlertView *failed = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Une erreur est survenue. Essayez de nouveau" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [failed show];
        [hub hide:YES];
    }];
    [operation start];
}

-(void) parseJSON: (id) JSON {
    if(!groupPoints)
        groupPoints = [[NSMutableArray alloc] init];
    
    [groupPoints removeAllObjects];
    
    for(NSDictionary *dic in JSON) {
        [groupPoints addObject:dic];        
    }
    
    [self.tableView reloadData];
        
}

@end
