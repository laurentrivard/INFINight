//
//  AppDelegate.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "TestFlight.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Let the device know we want to receive push notifications
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    
    if(!defaultValues) {
        defaultValues = [[NSMutableDictionary alloc] init ];
        
        [defaultValues setObject:@"YES" forKey:@"first_time"];
        [defaultValues setObject:@"" forKey:@"name"];
        [defaultValues setObject:@"" forKey:@"matricule"];
        [defaultValues setObject:@"" forKey:@"groupe"];
        [defaultValues setObject:@"" forKey:@"year"];
    }
    
    //TestFlight settings
    [TestFlight takeOff:@"b2dce0d88734556c24efff16b2a69f8b_MTEwMTkxMjAxMi0wNy0xNSAxMjo1NToyNS42MDQ0NTA"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:defaultValues];
    // Override point for customization after application launch.
    return YES;
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    
    
    NSString* newToken = [deviceToken description];
	newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[NSUserDefaults standardUserDefaults] setObject:newToken forKey:@"device_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
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

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
