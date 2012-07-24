//
//  HECAddEventTimeVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HECAddEventTimeVC.h"

@interface HECAddEventTimeVC ()

@end

@implementation HECAddEventTimeVC

@synthesize datePicker;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //register change events for datepicker
    [datePicker addTarget:self action:@selector(dateDidChange) forControlEvents:UIControlEventValueChanged];
    
}

- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [super viewDidUnload];
}

-(IBAction)didCancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)didSave:(id)sender {
    [self.delegate passDateBack:self didFinish: _dic];
    [self dismissModalViewControllerAnimated:YES];
}
-(void) dateDidChange {
    dateString = [NSDateFormatter localizedStringFromDate:self.datePicker.date 
                                                dateStyle:NSDateFormatterLongStyle 
                                                timeStyle:NSDateFormatterMediumStyle];
   _eventDate = self.datePicker.date;
    _dic = [[NSDictionary alloc] initWithObjectsAndKeys:_eventDate, @"event_date", dateString, @"event_date_string", nil ];

}


@end
