//
//  HECPartenairesDetailVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 8/13/12.
//
//

#import "HECPartenairesDetailVC.h"

@interface HECPartenairesDetailVC ()

@end

@implementation HECPartenairesDetailVC
@synthesize webView;
@synthesize urlString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    webView.delegate = self;
    
    
    _actInd = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:_actInd];
    
    // Set to Left or Right
    [[self navigationItem] setRightBarButtonItem:barButton];
    
    
    NSString *urlAddress = self.urlString;
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
}


- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_actInd stopAnimating];
    [_actInd removeFromSuperview];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_actInd startAnimating];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
