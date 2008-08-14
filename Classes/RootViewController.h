//
//  RootViewController.h
//  BarCampLeedsTest
//
//  Created by Dave Verwer on 13/08/2008.
//  Copyright Shiny Development Ltd. 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
  NSMutableArray *tweets;
  NSString *currentXMLElement;
  NSMutableString *currentTweetText;
  NSMutableString *currentTweetAuthor;
}

@end
