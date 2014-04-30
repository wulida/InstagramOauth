//
//  ILSInstagramAuthorizeViewController.h
//  ILSLoginManager
//
//  Created by hupeng on 14-4-18.
//  Copyright (c) 2014年 toprankapps. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "InstagramMacro.h"

@class InstagramModel;

@interface InstagramAuthorizeViewController : UIViewController
@property (nonatomic ,copy) InstagramAuthorizeCompletionHandler completionHandler;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) InstagramModel *instagramInstance;

@end
