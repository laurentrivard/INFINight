//
//  AppDelegate.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HECActivites;
@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableDictionary *defaultValues;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) HECActivites *act;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (NSString *) device_id;

@end
