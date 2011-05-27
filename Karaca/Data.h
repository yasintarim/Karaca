//
//  Data.h
//  Karaca
//
//  Created by yasin on 3/12/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchUrl.h"

@interface UIData : UIViewController<FetchUrl, UITextFieldDelegate> {
    FetchUrl *fetch;
    UIImageView *imgView;
}
 
@property (retain) UITextField* textField;
-(void)start;
-(void)hideKeyboard;
-(void)finishedLoading:(NSString *)message;
@end
