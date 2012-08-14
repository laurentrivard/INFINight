//
//  HECStudentVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 8/2/12.
//
//

#import <UIKit/UIKit.h>

@protocol studentRegistrationWasSuccessful <NSObject>
-(void) studentRegistrationWasSuccessful: (NSString *) success;
@end


@interface HECStudentVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    UITableView *_credTableView;
    NSArray *_cellTitles;
    UITextField *_matriculeTF;
    UITextField *_groupeTF;
    NSMutableArray *groups;
    UIPickerView *picker;
}

@property (weak, nonatomic) id <studentRegistrationWasSuccessful> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *backArrow;
- (IBAction)submit:(id)sender;

@end
