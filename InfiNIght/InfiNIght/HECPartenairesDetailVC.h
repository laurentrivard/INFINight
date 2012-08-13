//
//  HECPartenairesDetailVC.h
//  InfiNIght
//
//  Created by Laurent Rivard on 8/13/12.
//
//

#import <UIKit/UIKit.h>

@interface HECPartenairesDetailVC : UIViewController <UIWebViewDelegate> {
    UIActivityIndicatorView *_actInd;
}

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *urlString;

@end
