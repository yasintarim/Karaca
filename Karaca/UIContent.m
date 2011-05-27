//
//  UIContent.m
//  Karaca
//
//  Created by yasin on 3/6/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import "UIContent.h"


@implementation UIContent

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

//Implement loadView to create a view hierarchy programmatically, without using a nib.

- (void)loadView
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    UIView *view = [[UIView alloc] initWithFrame:bounds ];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cem.jpg"]];
    imgView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    //[imgView.image drawInRect: [imgView bounds]];
    imgView.contentMode = UIViewContentModeScaleToFill;
    imgView.backgroundColor = [UIColor redColor];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,bounds.size.width, 20)];
    lbl.textAlignment = UITextAlignmentCenter;
    lbl.text = @"Bes parmak bir olmaz derdin";
    lbl.textColor = [UIColor whiteColor];
    lbl.backgroundColor = [UIColor clearColor];
    
    [imgView addSubview:lbl];
    [view addSubview:imgView];
    
    self.view = view;
    
    [lbl release];
    [imgView release];
    [view release];
     
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
