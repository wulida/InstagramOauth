//
//  InstagramModel.h
//  ILSLoginManager
//
//  Created by hupeng on 14-4-29.
//  Copyright (c) 2014年 toprankapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramModel : NSObject

// 在返回信息中将被清空
@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *clientSecrect;
@property (nonatomic, strong) NSString *redirectURI;
@property (nonatomic, strong) NSString *code;
// 返回信息
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *uid;

@end
