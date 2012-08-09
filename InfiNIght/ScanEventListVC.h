//
//  ScanEventListVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 8/7/12.
//
//

#import <UIKit/UIKit.h>

@interface ScanEventListVC : UIViewController <UITableViewDataSource, UITableViewDelegate >{
    NSMutableArray *newEvents;
}
@property (strong, nonatomic) IBOutlet UITableView *tableview;

-(IBAction)cancel:(id)sender;
-(IBAction)refresh:(id)sender;

@end
