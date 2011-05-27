//
//  PictureViewController.m
//  Karaca
//
//  Created by yasin on 3/19/11.
//  Copyright 2011 YKB. All rights reserved.
//

#define MAINLABEL_TAG   1
#define SUBLABEL_TAG    3
#define IMAGE_TAG       2
#define CELL_HEIGHT     120
#define OVERLAY_TAG     4       
#define ACTIVITY_TAG     4       
#define ACTIVITY_TAG2     5  

#import "PictureViewController.h"
#import "ASIHTTPRequest.h"
#import "NSObject+JSON.h"
#import "KaracaAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
@implementation PictureViewController

- (void)dealloc
{
	if (m_photoTitles) {
		[m_photoTitles removeAllObjects];
		[m_photoTitles release];
		
	}
	
	if (m_photoSmallImageData) {
		[m_photoSmallImageData removeAllObjects];
		[m_photoSmallImageData release];
	}
	
	if (m_photoURLsLargeImage) {
		[m_photoURLsLargeImage removeAllObjects];
		[m_photoURLsLargeImage release];
	}
	
	if (m_imgLoaded) {
		[m_imgLoaded removeAllObjects];
		[m_imgLoaded release];
	}
	
	if (m_cachedImageData) {
		[m_cachedImageData removeAllObjects];
		[m_cachedImageData release];
	}
	
	
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
	// Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    m_tableView = [[UITableView alloc] initWithFrame:bounds style:UITableViewStylePlain];
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.view = m_tableView;
    
	m_photoTitles = [[NSMutableArray alloc] init];
	m_photoSmallImageData = [[NSMutableArray alloc] init];
	m_photoURLsLargeImage = [[NSMutableArray alloc] init];
	m_imgLoaded  = [[NSMutableArray alloc]init];
	m_cachedImageData = [[NSMutableArray alloc] init];
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 41)];
    searchBar.translucent = YES;
    searchBar.delegate = self;
    searchBar.autocorrectionType= UITextAutocorrectionTypeNo;
    searchBar.barStyle = UIBarStyleBlackOpaque;
    searchBar.placeholder = @"Aranacak kelimeyi giriniz..";
    
    m_tableView.tableHeaderView = searchBar;
    [[KaracaAppDelegate appDelegate].queue go];
    
    [searchBar release];
    [m_tableView release];
}

- (void)viewDidUnload
{
    [m_activityIndicator release];
    [m_overlay release];
    m_overlay = nil;
    m_activityIndicator = nil;
    [super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_photoTitles count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	@try {
		
		
		CGRect bounds = [UIScreen mainScreen].bounds;
		
		static NSString *cellIndentifier = @"mycell";
		int rowIndex = indexPath.row;
		static int imgWidth = 75;
		
		UILabel *mainLabel = nil;
		UIImageView *imgView = nil;
		UIActivityIndicatorView *activity = nil;
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
		
		
		int status = [(NSNumber*)[m_imgLoaded objectAtIndex:rowIndex] intValue];
		
		//cell = nil;
		if (cell == nil) {
			
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			[cell setFrame:CGRectMake(0, 0, bounds.size.width, 75)];
			
			mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgWidth, 0, cell.frame.size.width - imgWidth, cell.frame.size.height)];
			mainLabel.tag = MAINLABEL_TAG;
			
			imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imgWidth,cell.frame.size.height)];
			imgView.tag = IMAGE_TAG;
			imgView.image = nil;
			imgView.layer.masksToBounds = YES;
			imgView.layer.cornerRadius = 15.0;
			
			activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
			activity.hidesWhenStopped = YES;
			activity.center = imgView.center;
			//activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
			activity.tag = ACTIVITY_TAG;
			[imgView addSubview:activity];
			
			
			[cell.contentView addSubview:mainLabel];
			[cell.contentView addSubview:imgView];
			
			[activity release];
			[imgView release];
			[mainLabel release];
		}
		UIView *view = cell.contentView;
		mainLabel = (UILabel*)[view viewWithTag:MAINLABEL_TAG];
		imgView = (UIImageView*)[view viewWithTag:IMAGE_TAG];
		mainLabel.text =   [m_photoTitles objectAtIndex:rowIndex];
		activity = (UIActivityIndicatorView*)[view viewWithTag:ACTIVITY_TAG];
		
		//NSLog(@"s:%d, r:%d", status, rowIndex);
		if (status == 2) {
			//NSLog(@"cell Loaded -> index: %d", rowIndex);
			[activity stopAnimating];
			imgView.image = (UIImage*)[m_cachedImageData objectAtIndex:rowIndex];
		}
		else if (status == 1)
		{
			imgView.image = nil;
			//NSLog(@"cell Loading -> index: %d", rowIndex);
			[activity startAnimating];
		}
		else if (status == 0)
		{
			//NSLog(@"cell init -> index: %d", rowIndex);
			[activity stopAnimating];
			imgView.image = nil;
		}
		
		return  cell;
	}
	@catch (NSException *exception) {
		//NSLog(@"hata --- %@ ----", [exception reason]);
		return nil;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    CGSize searchBarSize = searchBar.bounds.size;
    
    if (m_overlay == nil) {
		[m_overlay release];
        m_overlay = [[UIView alloc] initWithFrame:CGRectMake(0, searchBarSize.height, searchBarSize.width, m_tableView.frame.size.height)];
        m_overlay.backgroundColor = [UIColor grayColor];
        m_overlay.alpha = 0;
        m_overlay.tag = OVERLAY_TAG;
    }
    
    [m_tableView addSubview:m_overlay];
    
    [UIView beginAnimations:@"FadeIn" context:nil];
    [UIView setAnimationDuration:0.5];
    m_overlay.alpha = 0.6;
    [UIView commitAnimations];
    
    
    [searchBar setShowsCancelButton:YES animated:YES];
    m_tableView.allowsSelection = NO;
    m_tableView.scrollEnabled = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text= @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
    m_tableView.allowsSelection = YES;
    m_tableView.scrollEnabled = YES;
    [m_activityIndicator stopAnimating];
    [m_activityIndicator removeFromSuperview];
    [m_overlay removeFromSuperview];
    m_overlay = nil;
    m_activityIndicator = nil;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
	if ([searchBar.text length] != 0)
	{
		[[KaracaAppDelegate appDelegate].queue cancelAllOperations];
        flickerUrl =  [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=200&format=json&nojsoncallback=1", @"bd96c1933f85bfacc0bde28b60a3bdc4", searchBar.text];
        
        
        __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[flickerUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        [request setCompletionBlock:
         ^{ 
			 NSString *responseString = [request responseString];
			 
             NSDictionary *results = [responseString JSONValue];
             NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
			 [m_photoTitles removeAllObjects];
			 [m_photoSmallImageData removeAllObjects];
			 [m_photoURLsLargeImage removeAllObjects];
			 [m_imgLoaded removeAllObjects];
			 [m_cachedImageData removeAllObjects];			 
			 
             for (NSDictionary *photo  in photos) {
                 NSString *title = [photo objectForKey:@"title"];
                 [m_photoTitles addObject:title];
                 
                 NSString *photoURLString = 
                 [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", 
                  [photo objectForKey:@"farm"], [photo objectForKey:@"server"], 
                  [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
                 
                 [m_photoSmallImageData addObject:photoURLString];
                 [m_imgLoaded addObject:[NSNumber numberWithInt:0]];
                 [m_cachedImageData addObject:@""];
             }             
             [m_activityIndicator stopAnimating];
             [m_activityIndicator removeFromSuperview];
             [m_overlay removeFromSuperview];
             m_overlay = nil;
             m_activityIndicator = nil;
             [m_tableView reloadData];
			 [self loadContentForVisibleCells];
         }];
        
        [request setFailedBlock:^{  
           // NSError *error = [request error];
            //NSLog(@"Failed %@ with code %d and with userInfo %@",[error domain],[error code],[error userInfo]);
        }];
        
        [request startAsynchronous];
        
        if (m_activityIndicator == nil) {
            
            m_activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            
            m_activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                                    UIViewAutoresizingFlexibleRightMargin |
                                                    UIViewAutoresizingFlexibleTopMargin |
                                                    UIViewAutoresizingFlexibleBottomMargin);
            [m_activityIndicator sizeToFit];
            m_activityIndicator.hidesWhenStopped = YES;
            [m_overlay addSubview:m_activityIndicator];
            [m_overlay release];
        }
        [m_activityIndicator startAnimating];
        [searchBar setShowsCancelButton:NO animated:YES];
        [searchBar resignFirstResponder];
	}
    m_tableView.allowsSelection = YES;
    m_tableView.scrollEnabled = YES;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [self loadContentForVisibleCells];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) 
	{
		[self loadContentForVisibleCells]; 
	}
}

-(void)AnimationFinished:(int)index
{
	
	
}


- (void)loadContentForVisibleCells
{
	
    NSArray *cells = [m_tableView visibleCells];
    
    for (UITableViewCell *cell in cells) {
        int index = [m_tableView indexPathForCell:cell].row;
        int isLoaded = [(NSNumber*)[m_imgLoaded objectAtIndex:index] intValue];
        
        if (isLoaded == 0)
		{
			//NSLog(@"ilk request index : %d", index);
			UIImageView *imgView =(UIImageView*)[cell viewWithTag:IMAGE_TAG];
			[m_imgLoaded replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:1]]; //loading
			
			UIActivityIndicatorView* activity = (UIActivityIndicatorView*)[imgView viewWithTag:ACTIVITY_TAG];
			[activity startAnimating];
			NSString *imgUrl = [m_photoSmallImageData objectAtIndex:index];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
            [request setCompletionBlock:
             ^{ 
				 [m_tableView beginUpdates];
				 
				 NSArray* arr = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:index inSection:0], nil];
				 [m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
				 [arr release];
				 //NSLog(@"load completed -> index: %d", index);
				 
				 UIImage *img = [UIImage imageWithData:[request responseData]];
				 [activity stopAnimating];
				 imgView.image = img;
				 [m_cachedImageData replaceObjectAtIndex:index withObject:img];
				 [m_imgLoaded replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:2]];
				 [m_tableView endUpdates];
				 
             }];
			
            
            [request setFailedBlock:^{
				[activity stopAnimating];
				//[m_imgLoaded replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:0]];
               // NSError *error = [request error];
                //NSLog(@"Failed %@ with code %d and with userInfo %@",[error domain],[error code],[error userInfo]);
            }];
            [[KaracaAppDelegate appDelegate].queue addOperation:request];
		}
		
    }
	
}

@end
