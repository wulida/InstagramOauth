//
//  InstagramAccesstokenRequest.h
//  ILSLoginManager
//
//  Created by hupeng on 14-4-29.
//  Copyright (c) 2014年 toprankapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstagramMacro.h"

@interface InstagramAccesstokenRequest : NSObject

+ (void)requestAuthorizeInfos:(InstagramModel *)instagramInstance completionHandler:(InstagramAuthorizeCompletionHandler)completionHandler;

@end
