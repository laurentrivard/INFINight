//
//  HECRegisterVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HECRegisterVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    UITableView *_credTableView;
    NSArray *_cellTitles;
}

@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *matriculeTF;
@property (strong, nonatomic) IBOutlet UITextField *groupeTF;
@property (strong, nonatomic) IBOutlet UITextField *yearTF;

@property (strong, nonatomic) IBOutlet UITableView *_credTableView;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)go:(UIButton *)sender;

@end
