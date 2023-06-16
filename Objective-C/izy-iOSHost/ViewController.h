//
//  ViewController.h
//  izy-iOSHost
//
//  Created by Izyware
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

