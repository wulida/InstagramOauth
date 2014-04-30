//
//  InstagramAuthorizeManager.m
//  ILSLoginManager
//
//  Created by hupeng on 14-4-29.
//  Copyright (c) 2014年 toprankapps. All rights reserved.
//

#import "InstagramAuthorizeManager.h"
#import "InstagramAuthorizeViewController.h"

@interface InstagramAuthorizeManager()
{
    InstagramAuthorizeCompletionHandler _completionHandler;
}

@end

@implementation InstagramAuthorizeManager

+ (InstagramAuthorizeManager *)sharedManager
{
    static InstagramAuthorizeManager *instagramAuthorizeManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        instagramAuthorizeManager = [[InstagramAuthorizeManager alloc] init];
    });
    return instagramAuthorizeManager;
}

+ (void)authorizeWithClientID:(NSString *)clientID
                clientSecrect:(NSString *)clientSecrect
                  redirectURI:(NSString *)redirectURI
            completionHandler:(InstagramAuthorizeCompletionHandler)completionHandler
{
    [[InstagramAuthorizeManager sharedManager] authorizeWithClientID:clientID
                                                       clientSecrect:clientSecrect
                                                         redirectURI:redirectURI
                                                   completionHandler:completionHandler];
}

- (void)authorizeWithClientID:(NSString *)clientID
                clientSecrect:(NSString *)clientSecrect
                  redirectURI:(NSString *)redirectURI
            completionHandler:(InstagramAuthorizeCompletionHandler)completionHandler
{
    InstagramModel *instagramInstance = [[InstagramModel alloc] init];
    instagramInstance.clientID = clientID;
    instagramInstance.clientSecrect = clientSecrect;
    instagramInstance.redirectURI = redirectURI;
    
    _completionHandler = completionHandler;
    NSString *authorizeURL = [NSString stringWithFormat:@"%@?response_type=code&client_id=%@&redirect_uri=%@", INSTAGRAM_AUTHORIZE_ADDRESS, clientID, redirectURI];
    
    InstagramAuthorizeViewController *controller = [[InstagramAuthorizeViewController alloc] init];
    controller.url = authorizeURL;
    controller.instagramInstance = instagramInstance;
    controller.completionHandler = completionHandler;
    
    UIViewController *topViewController = [self getTopViewController];
    
    
    if (topViewController.navigationController) {
        [topViewController.navigationController pushViewController:controller animated:true];
    } else {
    
        [topViewController presentViewController:controller animated:true completion:^{
        }];
    }
  
}

- (UIViewController *)getTopViewController
{
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topViewController = rootController;
    
    while (1) {
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        }
        
        UIViewController *tempViewController;
        if (topViewController.navigationController) {
            tempViewController = [topViewController.navigationController topViewController];
            if ([tempViewController isEqual:topViewController]) {
                topViewController = tempViewController;
                break;
            }
            topViewController = tempViewController;
            
        } else {
            tempViewController = topViewController.presentedViewController;
            if (!tempViewController) {
                break;
            }
            topViewController = tempViewController;
        }
    }
    return topViewController;
}

@end
