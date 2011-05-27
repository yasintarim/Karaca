//
//  FetchUrl.m
//  Karaca
//
//  Created by yasin on 3/12/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import "FetchUrl.h"


@implementation FetchUrl
@synthesize delegate;
@synthesize image;

- (id)initWithFrame:(CGRect)aRect 
{
    if ((self = [super initWithFrame:aRect])) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2)];
        label.text = @"Test";
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor redColor];
        [self addSubview:label];
        urlString = nil;
    }
    return  self;
}
-(id)init
{
    return [self initWithFrame:CGRectZero];
}
-(void)setUrlString:(NSString*)url delegate:(id)sender
{   
    urlString = url;
    delegate =  [sender conformsToProtocol:@protocol(FetchUrl)] ? sender :nil;
}

-(void)start
{
    if ([urlString length] != 0) {
    
        if (con != nil) {
            [con release];
        }
        
        if (receivedData != nil) {
            [receivedData release];
        }
        
        label.text = urlString;
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
        // create the connection with the request
        // and start loading the data
        con=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        if (con) {
            // Create the NSMutableData to hold the received data.
            // receivedData is an instance variable declared elsewhere.
            receivedData = [[NSMutableData data] retain];
        } else {
        // Inform the user that the connection failed.
        }   
    }
}

-(void)cancel
{
    // release the connection, and the data object
    if (con)
    {
        [con cancel];
        [con release];
        con = nil;
    }
    if (receivedData)
    {
        receivedData = nil;
        // receivedData is declared as a method instance elsewhere
        [receivedData release];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    con = connection;
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{   // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
     con = connection;
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
    
    con = nil;
    receivedData = nil;
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
        // release the connection, and the data object
    [connection release];
    self.image = [UIImage imageWithData:receivedData];
    [receivedData release];
    con = nil;
    receivedData = nil;
    [delegate finishedLoading:@"5 parmak bir olmaz derdin"];
}


-(void)dealloc{
    [receivedData release];
    [label release];
    self.image = nil;
    
    label = nil;
    delegate= nil;
    [super dealloc];
}
@end
