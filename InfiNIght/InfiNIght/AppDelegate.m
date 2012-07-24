//
//  AppDelegate.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "TestFlight.h"
#import "CoreData/CoreData.h"
#import "HECActivites.h"
#import "AFNetworking.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize act=_act;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Let the device know we want to receive push notifications
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    
    if(!defaultValues) {
        defaultValues = [[NSMutableDictionary alloc] init ];
        
        NSDate *now = [NSDate date]; 
        NSDate *newDate = [now dateByAddingTimeInterval:-3600*24*365];

        [defaultValues setObject:@"YES" forKey:@"first_time"];
        [defaultValues setObject:@"" forKey:@"name"];
        [defaultValues setObject:@"" forKey:@"matricule"];
        [defaultValues setObject:@"" forKey:@"groupe"];
        [defaultValues setObject:@"" forKey:@"year"];
        [defaultValues setObject:newDate forKey:@"lastActivityFetched"];
    }
    
    //TestFlight settings
    [TestFlight takeOff:@"b2dce0d88734556c24efff16b2a69f8b_MTEwMTkxMjAxMi0wNy0xNSAxMjo1NToyNS42MDQ0NTA"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:defaultValues];
    ///////////////////////////////////////////
    
    if (launchOptions != nil)
	{
		NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (dictionary != nil)
		{
			NSLog(@"Launched from push notification: %@", dictionary);
			[self handleOpenOnPush];
		}
	}
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    return YES;
}
-(void) handleOpenOnPush {
    [self.act refreshActivities];
    NSLog(@"refresh got called ...");
}
-(void) applicationDidBecomeActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

}
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
	NSLog(@"Received notification: %@", userInfo);
	[self handleOpenOnPush];
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    
    
    NSString* newToken = [deviceToken description];
	newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[NSUserDefaults standardUserDefaults] setObject:newToken forKey:@"device_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    if(![[[NSUserDefaults standardUserDefaults] stringForKey:@"device_token"] isEqualToString:newToken]) {
//        
//        [self updateToken: newToken];
//        
//    }
}
//-(void) updateToken: (NSString *) token {
//    NSURL *baseUrl = [[NSURL alloc] initWithString:@"http://10.11.1.59:8888"];
//    
//    AFHTTPClient *httpClient =[[AFHTTPClient alloc] initWithBaseURL:baseUrl];
//    [httpClient defaultValueForHeader:@"Accept"];
//    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];    
//    [params setObject:@"update" forKey:@"cmd"];
//    [params setObject:token forKey:@"token"];
//    
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api.php" parameters:params];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    
//    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {        
//        NSLog(@"token was updated");
//        
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"error: %@", [operation error]);
//
//    }];
//    
//    [operation start];
//}
+ (NSString *) device_id {
    
    NSString* uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"];
    if (!uuid) {
        CFUUIDRef theUUID = CFUUIDCreate(NULL);
        CFStringRef string = CFUUIDCreateString(NULL, theUUID);
        CFRelease(theUUID);
        
        NSString *inBetween = (__bridge NSString *) string;
        NSLog(@"in between: %@", inBetween);
        inBetween = [inBetween stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"inbetween after: %@", inBetween);
        [[NSUserDefaults standardUserDefaults] setObject:inBetween forKey:@"uuid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"];
    }
    
    return uuid;
    
}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error..."
                                                            message:@"An error has occured. The routine could not be saved."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [error show];
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Events" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Events.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error..."
                                                        message:@"An error has occured. The routine could not be saved."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [error show];    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
}   

@end
