//
//  HECEventImageDetailVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 8/2/12.
//
//

#import "HECEventImageDetailVC.h"
#import "AFImageRequestOperation.h"

@interface HECEventImageDetailVC ()

@end

@implementation HECEventImageDetailVC
@synthesize image;
@synthesize imageName;
@synthesize actInd;

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
    [self loadImage];
    [self.actInd startAnimating];
}

- (void)viewDidUnload
{
    [self setImage:nil];
    [self setActInd:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void) loadImage {
        
        UIActivityIndicatorView *photoIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        photoIndicator.frame = CGRectMake(self.image.frame.origin.x + 20, self.image.frame.origin.y + 20, 20, 20);
        
        [photoIndicator startAnimating];
        
        
        NSString *filePath = [NSString stringWithFormat:@"http://50.116.56.171/api/pictures/%@", self.imageName];
        NSLog(@"filepath :%@" , filePath);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
        
        
        
        
        AFImageRequestOperation *op = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *imageLoaded) {
            [photoIndicator stopAnimating];
            
            self.image.image = imageLoaded;
            [self.actInd stopAnimating];
            [self.actInd removeFromSuperview];
        }];
        
        
        [op start];
}
@end
