//
//  InstagramAuthorizeManager.h
//  ILSLoginManager
//
//  Created by hupeng on 14-4-29.
//  Copyright (c) 2014年 toprankapps. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "InstagramMacro.h"

@interface InstagramAuthorizeManager : NSObject

+ (InstagramAuthorizeManager *)sharedManager;

+ (void)authorizeWithClientID:(NSString *)clientID
                clientSecrect:(NSString *)clientSecrect
                  redirectURI:(NSString *)redirectURI
            completionHandler:(InstagramAuthorizeCompletionHandler)completionHandler;

@end
