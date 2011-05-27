//
//  KaracaAppDelegate.h
//  Karaca
//
//  Created by yasin on 2/12/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASINetworkQueue.h"

@class KaracaViewController;

@interface KaracaAppDelegate : NSObject <UIApplicationDelegate> {
        
        UIWindow* window;
        UITabBarController *tabBarController;
        ASINetworkQueue *queue;
}   

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) ASINetworkQueue *queue;
@property (nonatomic, retain) UITabBarController *tabBarController;
-(void)click:(id)sender;
+(KaracaAppDelegate*)appDelegate;
@end
