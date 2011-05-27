//
//  KaracaAppDelegate.m
//  Karaca
//
//  Created by yasin on 2/12/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import "KaracaAppDelegate.h"
#import "UIContent.h"
#import "Data.h"
#import "PictureViewController.h"

@implementation KaracaAppDelegate
@synthesize window;
@synthesize tabBarController;
@synthesize queue;

+(KaracaAppDelegate*)appDelegate
{
    return (KaracaAppDelegate*)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //
    queue = [[ASINetworkQueue alloc] init];
    window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor redColor];
    
    tabBarController = [[UITabBarController alloc] init];
    UITabBarItem* tab1 = [[UITabBarItem alloc] 
                          initWithTitle:@"Tab1" 
                          image:[UIImage imageNamed:@"radio.png"]
                          tag:1];
    
    UITabBarItem* tab2 = [[UITabBarItem alloc] 
                          initWithTitle:@"Tab2" 
                          image:[UIImage imageNamed:@"tv.png"]
                          tag:2];
    
    UITabBarItem* tab3 = [[UITabBarItem alloc] 
                          initWithTitle:NSLocalizedString(@"Life", @"Hayati") 
                          image:[UIImage imageNamed:@"tv.png"] 
                          tag:3];
    
    UITabBarItem *tab4 = [[UITabBarItem alloc] 
                          initWithTitle:  NSLocalizedString(@"test", @"test")
                          image:[UIImage imageNamed:@"tv.png"] 
                          tag:4];
    
    
    
    UIViewController *view1 = [[UIViewController alloc] init];
    UIViewController *view2 = [[PictureViewController alloc] init];
    UIContent *view3 = [[UIContent alloc] init];
    UIData *view4 = [[UIData alloc] init];
    
    view1.view.backgroundColor = [UIColor redColor];
    //view2.view.backgroundColor = [UIColor yellowColor];
    view3.view.backgroundColor = [UIColor blueColor];

    
    view1.tabBarItem = tab1;
    view2.tabBarItem = tab2;
    view3.tabBarItem = tab3;
    view4.tabBarItem = tab4;
    
    int frameWidth = view1.view.frame.size.width;
    UILabel *lbl1 = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, frameWidth , 20) ];
    [lbl1 setBackgroundColor:[UIColor blueColor]];
    lbl1.text = @"Annammmmmmmmmmmmm :D";
    
    [view1.view addSubview:lbl1];
    
    tabBarController.viewControllers = [NSArray arrayWithObjects:view1, view2, view3, view4, nil];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, lbl1.frame.size.height, frameWidth, 20)];
    [btn setTitle:@"Merhaba" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor magentaColor]];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [view1.view addSubview:btn ];
    
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
    
    [btn autorelease];
    [lbl1 release];
    [tab1 release];
    [tab2 release];
    [tab3 release];
    [tab4 release];
    [view1 release];
    [view2 release];
    [view3 release];
    [view4 release];
    return YES;
}

-(void)click:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"Merhaba" 
                          message:@"Cem" 
                          delegate:nil 
                          cancelButtonTitle:@"Tamam"
                          otherButtonTitles:nil, nil];
    
    [alert show];
    [alert release];

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [queue cancelAllOperations];
    [window release];
    [queue release];
    [tabBarController release];
    [super dealloc];
}

@end
