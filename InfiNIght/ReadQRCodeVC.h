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

@interface ReadQRCodeVC : UIViewController <ZBarReaderDelegate, MBProgressHUDDelegate> {
    UIView *_confirmation;
    NSTimer *_timer;
    MBProgressHUD *_progressHUD;
}
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *matriculeLbl;
@property (strong, nonatomic) IBOutlet UILabel *groupLbl;
@property (strong, nonatomic) IBOutlet UILabel *yearLbl;

- (IBAction)launchScanner:(id)sender;

@end
