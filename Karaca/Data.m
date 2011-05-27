//
//  Data.m
//  Karaca
//
//  Created by yasin on 3/12/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import "Data.h"
        

@implementation UIData

@synthesize textField;
- (void)dealloc
{
    [textField release];
    [imgView release];
    textField = nil;
    [fetch release];
    fetch = nil;
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
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    view.backgroundColor = [UIColor blueColor];
    self.view = view;
    
    
    CGRect textFieldFrame = CGRectMake(0.0, 0.0, frame.size.width, 30.0);
    textField = [[UITextField alloc] initWithFrame:textFieldFrame];
    [textField setBorderStyle:UITextBorderStyleBezel];
    [textField setTextColor:[UIColor blackColor]];
    [textField setFont:[UIFont systemFontOfSize:20]];
    [textField setDelegate:self];
    [textField setPlaceholder:@"Url Girin"];
    [textField setBackgroundColor:[UIColor whiteColor]];
   // [textField addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEven];
    textField.keyboardType = UIKeyboardTypeDefault;
    
    UIButton *btnStart = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, frame.size.width, 30   )];
    [btnStart setTitle:@"Baslat" forState:UIControlStateNormal];
    [btnStart addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    btnStart.backgroundColor = [UIColor redColor];
    
    fetch = [[FetchUrl alloc] initWithFrame:CGRectMake(0, 80, frame.size.width, 50) ];
    fetch.backgroundColor = [UIColor greenColor];
    
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, frame.size.width, frame.size.height - 130)];
    
    [view addSubview:imgView];
    [view addSubview:textField];
    [view addSubview:fetch];
    [view addSubview:btnStart];
    
    [btnStart release];
    [view release];
    
}

-(void)hideKeyboard
{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)field {

	[self hideKeyboard];
    
	return YES;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

-(void)start
{
    [fetch setUrlString:textField.text delegate:self];
    [fetch start];
}

-(void)finishedLoading:(NSString *)message
{
   
    //[fetch release]; 
    
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"Bir Ogretmene Agit" 
                          message:message 
                          delegate:nil 
                          cancelButtonTitle:@"Bugun" 
                          otherButtonTitles:nil, nil];
    
    [imgView setImage:fetch.image];
    
    [alert show];
    [alert release];
}

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
