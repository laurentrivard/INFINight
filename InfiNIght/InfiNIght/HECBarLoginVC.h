//
//  HECBarLoginVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 8/8/12.
//
//

#import <UIKit/UIKit.h>

@interface HECBarLoginVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate > {
    UITableView *_credTableView;
    NSArray *_cellTitles;
    UITextField *_usernameTF;
    UITextField *_passwordTF;
}
@property (strong, nonatomic) IBOutlet UIImageView *backArrow;

@end
