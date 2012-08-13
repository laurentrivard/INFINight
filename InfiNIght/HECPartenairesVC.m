//
//  HECPartenairesVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 8/13/12.
//
//

#import "HECPartenairesVC.h"
#import "HECPartenairesDetailVC.h"

@interface HECPartenairesVC ()

@end

@implementation HECPartenairesVC

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
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.title = @"Partenaires";

    _sponsors = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Partenaires" ofType:@"plist"]]; //load the contents of the plist
    
  //  NSLog(@"sponsors: %@", _sponsors);
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
    
    return [[_sponsors objectForKey:@"Partenaires"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    // Configure the cell...
    cell.textLabel.text = [[[_sponsors objectForKey:@"Partenaires"] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.imageView.image = [UIImage imageNamed:[[[_sponsors objectForKey:@"Partenaires"] objectAtIndex:indexPath.row] objectForKey:@"pic"]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HECPartenairesDetailVC *web = [[HECPartenairesDetailVC alloc] initWithNibName:@"HECPartenairesDetailVC" bundle:[NSBundle mainBundle]];
    web.urlString = [[[_sponsors objectForKey:@"Partenaires"] objectAtIndex:indexPath.row] objectForKey:@"website"];
    
    [self.navigationController pushViewController:web animated:YES];
}

@end
