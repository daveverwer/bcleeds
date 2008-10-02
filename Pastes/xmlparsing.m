NSMutableArray *tweets;
NSString *currentXMLElement;
NSMutableString *currentTweetText;
NSMutableString *currentTweetAuthor;

----

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

