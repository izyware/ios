//
//  ViewController.m
//  izy-iOSHost
//
//  Created by Izyware
//

#import "ViewController.h"

@interface ViewController ()
    @property (nonatomic, assign) BOOL loadFromUrl;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    self.loadFromUrl = NO;
    if (self.loadFromUrl) {
        NSString *stringURL = @"https://izyware.com";
        NSURL *URL = [NSURL URLWithString:stringURL];
        NSURLRequest *requestURL = [NSURLRequest requestWithURL:URL];
        [self.webView loadRequest:requestURL];
        return;
    }

    NSString *pageContentString = @"\
        <!DOCTYPE html>\
        <html>\
            <head> \
                <meta charset='utf-8'> \
                <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'> \
                <meta http-equiv='Content-Type' content='text/html; charset=utf-8'> \
                <meta name='referrer' content='origin'>\
                <title>IzyWare</title>\
                <style type='text/css'>body { margin: 0; padding: 0; font-size: 15px; } </style>\
            </head>\
            <body>\
                <h1>Izy HTML Canvas</h1>\
                <div id='logwindow'>log window</div>\
                <script>function nativeCallInterface(dataString) { document.getElementById('logwindow').innerHTML = '[' + new Date() + '] ' + dataString; }</script>\
            </body>\
        </html>\
    ";
    NSData *data = [pageContentString dataUsingEncoding:NSUTF8StringEncoding];
    [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidesWhenStopped = YES;
    [self.webView stringByEvaluatingJavaScriptFromString:@"nativeCallInterface('native event')"];
}


@end
