//
//  HECPartyDetailVC.m
//  InfiNIght
//
//  Created by Laurent Rivard on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HECPartyDetailVC.h"
#import "AFImageRequestOperation.h"
#import "HECEventImageDetailVC.h"


@interface HECPartyDetailVC ()

@end

@implementation HECPartyDetailVC
@synthesize eventInfo;
@synthesize titleLbl;
@synthesize dateLbl;
@synthesize locationLbl;
@synthesize descriptionTF;
@synthesize imagePhoto;

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
 //   NSLog(@"%@", self.eventInfo);
    
    self.title = [NSString stringWithFormat:@"%@", [self.eventInfo objectForKey:@"event_title"]];
    self.titleLbl.text = [self.eventInfo objectForKey:@"event_title"];
    self.descriptionTF.text = [self.eventInfo objectForKey:@"event_description"];
    self.dateLbl.text = [self.eventInfo objectForKey:@"event_date_string"];
    self.locationLbl.text = [self.eventInfo objectForKey:@"event_location"];
    
    
    [self getImageWithFileName:[self.eventInfo objectForKey:@"image_title"]];
    
    self.imagePhoto.userInteractionEnabled = YES;
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"EventDetail.png"]];
    
    self.view.backgroundColor = background;

    //self.view.backgroundColor = [UIImage imageNamed:@"EventDetail.png"];
    

        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self.imagePhoto addGestureRecognizer:singleTap];
}
-(void) handleSingleTap: (UIGestureRecognizer *) gesture {
    HECEventImageDetailVC *eventImage = [[HECEventImageDetailVC alloc] initWithNibName:@"HECEventImageDetailVC" bundle:[NSBundle mainBundle]];
    eventImage.imageName = [self.eventInfo objectForKey:@"image_title"];
    [self.navigationController pushViewController:eventImage animated:YES];
}

- (void)viewDidUnload
{
    [self setTitleLbl:nil];
    [self setDateLbl:nil];
    [self setLocationLbl:nil];
    [self setDescriptionTF:nil];
    [self setImagePhoto:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
} 

-(void) getImageWithFileName: (NSString *) name{
    
    UIActivityIndicatorView *photoIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    photoIndicator.frame = CGRectMake(self.imagePhoto.frame.origin.x + 20, self.imagePhoto.frame.origin.y + 20, 20, 20);
    
    [photoIndicator startAnimating];
    
    
    NSString *filePath = [NSString stringWithFormat:@"http://50.116.56.171/api/pictures/ios_%@", name];
    NSLog(@"filepath :%@" , filePath);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
    
    
        
                             
        AFImageRequestOperation *op = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
        [photoIndicator stopAnimating];
        
        self.imagePhoto.image = image;
    }];
    
    
    [op start];

}

@end
