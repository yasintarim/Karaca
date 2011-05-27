//
//  FetchUrl.h
//  Karaca
//
//  Created by yasin on 3/12/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FetchUrl
@optional   
-(void) finishedLoading:(NSString*)message;
@end

@interface FetchUrl : UIView {
    NSString *urlString;
    NSMutableData *receivedData;
    NSURLConnection *con;
    UILabel* label;
}
@property (assign) id<FetchUrl> delegate;
@property (retain) UIImage *image;

-(void)setUrlString:(NSString*)url delegate:(id)sender;
-(void)dealloc;
-(void)start;
-(void)cancel;
-(id)init;
-(id)initWithFrame:(CGRect)aRect;
@end
