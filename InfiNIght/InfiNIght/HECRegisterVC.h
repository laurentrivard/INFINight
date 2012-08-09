//
//  HECRegisterVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HECStudentVC.h"

@class HECRegisterVC;

@protocol RegistrationWasSuccessful <NSObject>
-(void) registrationWasSuccessful: (NSString *) success;
@end

@interface HECRegisterVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    UITableView *_credTableView;
    NSArray *_cellTitles;
    BOOL groupExists;
    NSArray *mtlSchools;
}

@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *matriculeTF;
@property (strong, nonatomic) IBOutlet UITextField *groupeTF;

@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) id <RegistrationWasSuccessful> delegate;
- (IBAction)go:(UIButton *)sender;

@end
