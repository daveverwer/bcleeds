//
//  RootViewController.m
//  BarCampLeedsTest
//
//  Created by Dave Verwer on 13/08/2008.
//  Copyright Shiny Development Ltd. 2008. All rights reserved.
//

#import "RootViewController.h"
#import "BarCampLeedsTestAppDelegate.h"

@implementation RootViewController

static NSString* feedURL = @"http://search.twitter.com/search.atom?q=%23barcampleeds08";

#pragma mark XML Parsing
- (void)fetchFeed:(NSString*)feed {
  // Load the feed and start it parsing
  NSURL *feedUrl = [NSURL URLWithString:feed];
	NSXMLParser *parser = [[[NSXMLParser alloc] initWithContentsOfURL:feedUrl] autorelease];
	[parser setDelegate:self];
	[parser parse];
}

#pragma mark XML Parsing Delegates
- (void)parserDidStartDocument:(NSXMLParser *)parser {
  // Start a new set of tweets
  [tweets release]; tweets = [NSMutableArray new];
}

- (void)parser:(NSXMLParser*)parser didStartElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qualifiedName attributes:(NSDictionary*)attributeDict {
  // Keep a reference to the element so that its data can be collected
  [currentXMLElement release]; currentXMLElement = [elementName copy];

	if ([currentXMLElement isEqualToString:@"entry"]) {
    [currentTweetText release]; currentTweetText = [NSMutableString new];
    [currentTweetAuthor release]; currentTweetAuthor = [NSMutableString new];
	}
}

- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString*)string {
	if ([currentXMLElement isEqualToString:@"title"]) [currentTweetText appendString:string];
  else if ([currentXMLElement isEqualToString:@"name"]) [currentTweetAuthor appendString:string];
}

- (void)parser:(NSXMLParser*)parser didEndElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qName {
	if ([elementName isEqualToString:@"entry"]) {
    // Strip whitespace
    NSString *tempTweetText = [currentTweetText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *tempTweetAuthor = [currentTweetAuthor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Add the tweet to the array of tweets
    [tweets addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                       tempTweetText, @"text",
                       tempTweetAuthor, @"author", nil]];
    // Clean up
    [currentTweetText release]; currentTweetText = nil;
    [currentTweetAuthor release]; currentTweetAuthor = nil;
	}
}

- (void)parserDidEndDocument:(NSXMLParser*)parser {
  // Clean up all the processing variables
  [currentXMLElement release]; currentXMLElement = nil;
  [currentTweetText release]; currentTweetText = nil;
  [currentTweetAuthor release]; currentTweetAuthor = nil;
  
  // Refresh the UI
	[[self tableView] reloadData];
  NSLog(@"%d tweets fetched", [tweets count]);
}

#pragma mark XML Parsing Errors
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	UIAlertView *error = [[[UIAlertView alloc] initWithTitle:@"Error"
                                                   message:@"Twitter is probably down!"
                                                  delegate:self
                                         cancelButtonTitle:@"Not again!"
                                         otherButtonTitles:nil] autorelease];
	[error show];
}

#pragma mark UI Maintenance
- (void)viewDidLoad {
  [self fetchFeed:feedURL];
}

#pragma mark UITableView Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [tweets count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:nil] autorelease];
  
  NSLog(@"%s", _cmd);

  NSString *tweetAuthor = [[tweets objectAtIndex:[indexPath row]] objectForKey:@"author"];
  UILabel *tweetAuthorView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 20.0)];
	[tweetAuthorView setText:tweetAuthor];
	[tweetAuthorView setFont:[UIFont boldSystemFontOfSize:14]];
  [tweetAuthorView setBackgroundColor:[UIColor grayColor]];
  [tweetAuthorView setTextColor:[UIColor whiteColor]];
  [[cell contentView] addSubview:tweetAuthorView];
	[tweetAuthorView release];
  
  NSString *tweetText = [[tweets objectAtIndex:[indexPath row]] objectForKey:@"text"];
  UILabel *tweetTextView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 20.0, 320, 44.0)];
	[tweetTextView setText:tweetText];
	[tweetTextView setNumberOfLines:3];
	[tweetTextView setFont:[UIFont systemFontOfSize:13]];
  [[cell contentView] addSubview:tweetTextView];
	[tweetTextView release];

	return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
  return YES;
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)dealloc {
  [tweets release];
	[super dealloc];
}

@end

