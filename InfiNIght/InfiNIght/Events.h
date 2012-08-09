//
//  Events.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Events : NSManagedObject

@property (nonatomic, retain) NSString * event_title;
@property (nonatomic, retain) NSString * event_desc;
@property (nonatomic, retain) NSString * event_date;
@property (nonatomic, retain) NSString * event_location;
@property (nonatomic, retain) NSString * event_date_string;
@property (nonatomic, retain) NSString * image_title;
@property (nonatomic, retain) NSString * type;



@end
