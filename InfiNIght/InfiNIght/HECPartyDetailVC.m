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
@synthesize actInd;
@synthesize scrollView;

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
 //   NSLog(@"%@", self.eventInfo);
    
    self.title = [NSString stringWithFormat:@"%@", [self.eventInfo objectForKey:@"event_title"]];
    
    [actInd startAnimating ];
    [self getImageWithFileName:[self.eventInfo objectForKey:@"image_title"]];
    
    self.imagePhoto.userInteractionEnabled = YES;
    

    

    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 370);
    scrollView.userInteractionEnabled = YES;
    scrollView.bounces = YES;
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:scrollView];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EventDetail.png"]];
    [bg setFrame:CGRectMake(0, 0, self.view.frame.size.width, scrollView.frame.size.height)];
    
    self.imagePhoto = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"infinight.png"]];
    [self.imagePhoto setFrame:CGRectMake(7.5f, 7.5f, 120, 160)];
    self.imagePhoto.userInteractionEnabled = YES;
    self.imagePhoto.contentMode = UIViewContentModeScaleAspectFit;


    
    self.descriptionTF = [[UITextView alloc] initWithFrame:CGRectMake(7.5f, 177.5, scrollView.frame.size.width - 15, 1000)];
    self.descriptionTF.text = [self.eventInfo objectForKey:@"event_description"];
    self.descriptionTF.textColor = [UIColor whiteColor];
    self.descriptionTF.backgroundColor = [UIColor clearColor];
    self.descriptionTF.editable = NO;
    self.descriptionTF.userInteractionEnabled = NO;
    self.descriptionTF.textColor = [UIColor whiteColor];
    self.descriptionTF.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
    

    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.imagePhoto addGestureRecognizer:singleTap];
    
    self.dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(140, 20, 170, 50)];
    self.dateLbl.text = [self.eventInfo objectForKey:@"event_date_string"];
    self.dateLbl.textAlignment = UITextAlignmentLeft;
    self.dateLbl.backgroundColor = [UIColor clearColor];
    self.dateLbl.textColor = [UIColor whiteColor];
    self.dateLbl.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    
    UILabel *where = [[UILabel alloc] initWithFrame:CGRectMake(135, 95, 185, 20)];
    where.text = @"Lieu";
    where.textAlignment = UITextAlignmentCenter;
    where.backgroundColor = [UIColor clearColor];
    where.textColor = [UIColor whiteColor];
    where.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    
    UILabel *when = [[UILabel alloc] initWithFrame:CGRectMake(132.5f, 25, 185, 20)];
    when.text = @"Quand?";
//    when.textAlignment = UITextAlignmentCenter;
    when.backgroundColor = [UIColor clearColor];
    when.textColor = [UIColor whiteColor];
    when.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    
    
    self.locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(140, 90, 160, 50)];
//    self.locationLbl.text = [self.eventInfo objectForKey:@"event_location"];
    self.locationLbl.text = @"Bar Officiel - Commission des liqueurs";
    self.locationLbl.numberOfLines = 0;
   self.locationLbl.lineBreakMode = UILineBreakModeWordWrap;
    self.locationLbl.textAlignment = UITextAlignmentLeft;
    self.locationLbl.backgroundColor = [UIColor clearColor];
    self.locationLbl.textColor = [UIColor whiteColor];
    self.locationLbl.font = [UIFont fontWithName:@"Helvetica" size:14.0f];

    
                       
    [scrollView addSubview:bg];
    [scrollView addSubview: self.descriptionTF];
    [scrollView addSubview:self.imagePhoto];
//    [scrollView addSubview:where];
//    [scrollView addSubview:when];
    [scrollView addSubview:self.dateLbl];
    [scrollView addSubview:self.locationLbl];
    
    
    //resizing the textview
    CGRect frame = self.descriptionTF.frame;
    frame.size.height = self.descriptionTF.contentSize.height;
    self.descriptionTF.frame = frame;
    
    CGRect scrollViewFrame = scrollView.frame;
    scrollViewFrame.size.height = self.descriptionTF.frame.size.height + self.descriptionTF.frame.origin.y;
    if(scrollViewFrame.size.height > 460) {
        scrollView.contentSize = CGSizeMake(scrollViewFrame.size.width, scrollViewFrame.size.height);
    }
    
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
    [self setActInd:nil];
    [self setScrollView:nil];
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
            [actInd stopAnimating];
            [actInd removeFromSuperview];
        }];
    
    
    [op start];

}

@end
