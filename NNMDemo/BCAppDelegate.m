/*
 *  BCAppDelegate.m
 *  NNMDemo
 *
 *  Created by bearkode on 2014. 1. 2..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

#import "BCAppDelegate.h"
#import "BCConnectManager.h"


@implementation BCAppDelegate
{
    UIWindow *mWindow;
}


@synthesize window = mWindow;


#pragma mark -


- (BOOL)application:(UIApplication *)aApplication didFinishLaunchingWithOptions:(NSDictionary *)aLaunchOptions
{
    mWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [mWindow setBackgroundColor:[UIColor whiteColor]];
    [mWindow makeKeyAndVisible];
    
    [[BCConnectManager sharedManager] startAdvertising];
    [[BCConnectManager sharedManager] startBrowsing];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)aApplication
{

}


- (void)applicationDidEnterBackground:(UIApplication *)aApplication
{

}


- (void)applicationWillEnterForeground:(UIApplication *)aApplication
{

}


- (void)applicationDidBecomeActive:(UIApplication *)aApplication
{

}


- (void)applicationWillTerminate:(UIApplication *)aApplication
{

}


@end
