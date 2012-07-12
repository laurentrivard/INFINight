//
//  MembersVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MembersVC : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
