//
//  HECActivites.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HECRegisterVC.h"

@interface HECActivites : UITableViewController <RegistrationWasSuccessful> {
    NSMutableArray *_dates;
    NSMutableArray *_events;
    NSArray *tableViewEvents;
    BOOL newEventWasReceived;

}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(void) refreshActivities;

@end
