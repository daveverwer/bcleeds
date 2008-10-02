- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:nil] autorelease];
  
  NSString *tweetText = [[tweets objectAtIndex:[indexPath row]] objectForKey:@"text"];
  UILabel *tweetTextView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 43.0)];
	[tweetTextView setText:tweetText];
	[tweetTextView setNumberOfLines:3];
	[tweetTextView setFont:[UIFont systemFontOfSize:13]];
  [[cell contentView] addSubview:tweetTextView];
	[tweetTextView release];
  
	return cell;
}

