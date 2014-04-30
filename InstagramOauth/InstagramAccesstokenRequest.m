//
//  InstagramAccesstokenRequest.m
//  ILSLoginManager
//
//  Created by hupeng on 14-4-29.
//  Copyright (c) 2014年 toprankapps. All rights reserved.
//

#import "InstagramAccesstokenRequest.h"

@implementation InstagramAccesstokenRequest

+ (void)requestAuthorizeInfos:(InstagramModel *)instagramInstance completionHandler:(InstagramAuthorizeCompletionHandler)completionHandler{

    NSString *params = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",instagramInstance.clientID, instagramInstance.clientSecrect, instagramInstance.redirectURI, instagramInstance.code];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:INSTAGRAM_ACCESSTOKEN_ADDRESS]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            completionHandler(connectionError, nil);

        } else {
            
            // 1.清除私密信息
            instagramInstance.clientID = nil;
            instagramInstance.clientSecrect = nil;
            instagramInstance.code = nil;
            instagramInstance.redirectURI = nil;
            
            NSError *error = nil;
            NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            if (error) {
                completionHandler(error ,nil);
                return;
            }
            
            if ([result objectForKey:@"error_message"]) {
                error = [NSError errorWithDomain:[result objectForKey:@"error_message"] code:[[result objectForKey:@"code"] intValue] userInfo:nil];
                completionHandler(error ,nil);
                return;
            }
           
            instagramInstance.accessToken = [result objectForKey:@"access_token"];
        
            NSDictionary *userInfos = [result objectForKey:@"user"];
            if (userInfos) {
                instagramInstance.uid = [userInfos objectForKey:@"id"];
                instagramInstance.username = [userInfos objectForKey:@"username"];
                instagramInstance.bio = [userInfos objectForKey:@"bio"];
                instagramInstance.fullName = [userInfos objectForKey:@"full_name"];
                instagramInstance.website = [userInfos objectForKey:@"website"];
                instagramInstance.image = [userInfos objectForKey:@"profile_picture"];
            }
           completionHandler(nil, instagramInstance);
        }
    }];
}
@end
