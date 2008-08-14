//
//  BarCampLeedsTestAppDelegate.h
//  BarCampLeedsTest
//
//  Created by Dave Verwer on 13/08/2008.
//  Copyright Shiny Development Ltd. 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarCampLeedsTestAppDelegate : NSObject <UIApplicationDelegate> {
	
	IBOutlet UIWindow *window;
	IBOutlet UINavigationController *navigationController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@end

