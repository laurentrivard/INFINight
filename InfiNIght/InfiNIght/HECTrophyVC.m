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

@interface HECTrophyVC ()

@end

@implementation HECTrophyVC

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [groupPoints count];
}

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
    
    cell.groupName.text = [NSString stringWithFormat:@"Groupe %@",[[groupPoints objectAtIndex:indexPath.row] valueForKey:@"group"]];
    cell.groupPoints.text = [NSString stringWithFormat:@"%@ Points", [[groupPoints objectAtIndex:indexPath.row] valueForKey:@"points"]];

    return cell;
}



#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}

-(void) getRankings{
    NSLog(@"getting rankings");
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.dimBackground = YES;
    hub.labelText = @"Classement ...";
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://10.11.1.59:8888/get/get_group_rankings"];
    
    
    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"" parameters:params];
    
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
    
    groupPoints = [[NSMutableArray alloc] init ];
    for(NSDictionary *dic in JSON) {
        [groupPoints addObject:dic];        
    }
    
    [self.tableView reloadData];
}

@end
