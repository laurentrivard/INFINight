//
//  HECRegisterVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HECRegisterVC;

@protocol RegistrationWasSuccessful <NSObject>

-(void) registrationWasSuccessful: (NSString *) success;

@end
@interface HECRegisterVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    UITableView *_credTableView;
    NSArray *_cellTitles;
    BOOL groupExists;
}

@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *matriculeTF;
@property (strong, nonatomic) IBOutlet UITextField *groupeTF;
@property (strong, nonatomic) IBOutlet UITextField *yearTF;

@property (strong, nonatomic) IBOutlet UITableView *_credTableView;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) id <RegistrationWasSuccessful> delegate;
- (IBAction)go:(UIButton *)sender;

@end
