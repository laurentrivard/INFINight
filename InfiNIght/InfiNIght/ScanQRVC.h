//
//  ReadQRCodeVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "MBProgressHUD.h"
#import <AudioToolBox/AudioToolbox.h>

@interface ScanQRVC : UIViewController <ZBarReaderDelegate, MBProgressHUDDelegate> {
    UIView *_confirmation;
    NSTimer *_timer;
    MBProgressHUD *_progressHUD;
    
    NSString *__name;
    NSString *__deviceToken;
    NSString *__group;
    NSString *__school;
}
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *groupLbl;
@property (strong, nonatomic) IBOutlet UIImageView *successImage;
@property (strong, nonatomic) NSArray *eventInfo;
@property (strong, nonatomic) IBOutlet UILabel *titleField;

- (IBAction)launchScanner:(id)sender;
-(IBAction)cancel:(id)sender;
@end
