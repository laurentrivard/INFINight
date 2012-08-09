//
//  HECTrophyVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HECTrophyVC : UITableViewController {
    NSMutableArray *groupPoints;
    NSMutableArray *positionChanged;
    NSMutableArray *lastPositions;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
