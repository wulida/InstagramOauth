//
//  ILSInstagramAuthorizeViewController.m
//  ILSLoginManager
//
//  Created by hupeng on 14-4-18.
//  Copyright (c) 2014年 toprankapps. All rights reserved.
//


#import "InstagramAuthorizeViewController.h"
#import "InstagramAccesstokenRequest.h"
#import "InstagramModel.h"

@interface InstagramAuthorizeViewController()<UIWebViewDelegate>
{
    UIWebView *_webview;
    UIActivityIndicatorView *_spinner;
}

@end

@implementation InstagramAuthorizeViewController

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
    // clear cookie
    NSHTTPCookieStorage *cookieStore = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieStore cookies]) {
        [cookieStore deleteCookie:cookie];
    }
    
    // set up webview
    CGRect iPadSheetRect = CGRectMake(0, 0, 540, 576);
    CGRect rect =  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? CGRectMake(0, -44, 540, 576) : CGRectMake(0, -44, self.view.bounds.size.width, self.view.bounds.size.height);
    CGPoint viewCenter =  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? CGPointMake(iPadSheetRect.size.width * 0.5, iPadSheetRect.size.height * 0.5) : CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    
    _webview = [[UIWebView alloc] initWithFrame:rect];
    _webview.scrollView.scrollEnabled = false;
    _webview.delegate = self;
    [self.view addSubview:_webview];
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinner.center = viewCenter;
    [self.view addSubview:_spinner];
    
    // set up back button
    self.title = @"Instagram";
    
    UIImage *image = [UIImage imageNamed:@"InstagramOauto.bundle/navigationbar_icon_back.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    
    if (self.navigationController) {
       
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    } else {
        [self.view addSubview:backButton];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:_url] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:30.0];
    [_webview loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)backButtonPressed:(id)sender
{
    _spinner = nil;
    _webview = nil;
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    } else {
        [self dismissViewControllerAnimated:true completion:^{
            
        }];
    }
}


#pragma mark - webView delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _spinner.hidden = FALSE;
    [_spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_spinner stopAnimating];
    _spinner.hidden = TRUE;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_spinner stopAnimating];
    _spinner.hidden = TRUE;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *urlString = request.URL.absoluteString;
    NSString *code = [self getParamForKey:INSTAGRAM_CODE_KEY fromURLString:urlString];
    if (code) {
        _instagramInstance.code = code;
        [self requestAuthorizeInfos];
    }
    return TRUE;
}

- (NSString *)getParamForKey:(NSString *)key fromURLString:(NSString *)sURL
{
    NSString *value = nil;
    NSString *pattern = [NSString stringWithFormat:@"%@=[^&]*", key];
    
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSTextCheckingResult *match = [regExp firstMatchInString:sURL options:0 range:NSMakeRange(0, [sURL length])];
    
    if (match) {
        NSRange matchRange = [match range];
        NSString *result = [sURL substringWithRange:matchRange];
        value = [result substringFromIndex:key.length+1];
    }
    
    return value;
}

- (void)requestAuthorizeInfos
{
    [InstagramAccesstokenRequest requestAuthorizeInfos:_instagramInstance completionHandler:_completionHandler];
}

@end
