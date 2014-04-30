//
//  InstargramMacro.h
//  ILSLoginManager
//
//  Created by hupeng on 14-4-29.
//  Copyright (c) 2014年 toprankapps. All rights reserved.
//

#import "InstagramModel.h"

typedef void (^InstagramAuthorizeCompletionHandler)(NSError *error ,InstagramModel *instagramInstance);

#define INSTAGRAM_CODE_KEY @"code"

#define INSTAGRAM_AUTHORIZE_ADDRESS @"https://instagram.com/oauth/authorize"
#define INSTAGRAM_ACCESSTOKEN_ADDRESS @"https://api.instagram.com/oauth/access_token"