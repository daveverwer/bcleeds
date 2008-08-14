//
//  BarCampLeedsTestAppDelegate.m
//  BarCampLeedsTest
//
//  Created by Dave Verwer on 13/08/2008.
//  Copyright Shiny Development Ltd. 2008. All rights reserved.
//

#import "BarCampLeedsTestAppDelegate.h"
#import "RootViewController.h"


@implementation BarCampLeedsTestAppDelegate

@synthesize window;
@synthesize navigationController;


- (id)init {
	if (self = [super init]) {
		// 
	}
	return self;
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
