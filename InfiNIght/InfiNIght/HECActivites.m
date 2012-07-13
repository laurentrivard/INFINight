//
//  HECActivites.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HECActivites.h"
#import "HECRegisterVC.h"

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
    //on first load, show the register page
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"activities_navBar.png"] forBarMetrics:UIBarMetricsDefault];
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"first_time"] isEqualToString:@"NO"]) {
        HECRegisterVC *reg = [[HECRegisterVC alloc] initWithNibName:@"HECRegisterVC" bundle:[NSBundle mainBundle]];
    
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self presentModalViewController:reg animated:YES];
        });
    }
     events = [[NSArray alloc] initWithObjects:@"Mega Bash Summer", @"Soiree au bar officiel!", @"Party HEC", @"Party Fin de Session", @"4 a 7!", @"Fin de session a l'Ecurie",  @"4 a 7!", @"Bar Officiel apres le 4 a 7!",nil];
    NSLog(@"events: %@", events);
    dates = [[NSArray alloc] initWithObjects:@"1er Juillet", @"24 Juin", @"31 Mai", @"17 Avril", @"22 Mars", @"21 Decembre", @"12 Decembre", @"7 Decembre", nil];
    count = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return [dates objectAtIndex:section];
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  20.0;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [dates count];
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
    cell.textLabel.text = [events objectAtIndex:indexPath.section];
    
    count++;
    return cell;
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
