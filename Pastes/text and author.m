- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:nil] autorelease];

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

