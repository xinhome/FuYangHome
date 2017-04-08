//
//  HttpRequest.h
//  haipai
//
//  Created by Tom Yin on 2016/12/13.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, RequestPerson) {
    RequestPersonWeiMing = 0,
    RequestPersonYuChuan,
    RequestPersonKaiKang
};

@interface HttpRequestManager : AFHTTPSessionManager
+ (instancetype)shareManager;

//请求
- (void)addPOSTURL:(NSString *)URL // 请求URL
            person:(RequestPerson)person // 请求人    因为基地址不一致
        parameters:(NSDictionary *)parameters // 参数
           success:(void (^)(id successResponse))success
              fail:(void (^)(NSError *error))fail;

- (void)addPOSTURL:(NSString *)URL
        parameters:(NSDictionary *)parameters
  constructingBody:(void (^)(id <AFMultipartFormData> formData))block
           success:(void (^)(id successResponse))success
              fail:(void (^)(NSError *error))fail;

- (void)addGETURL:(NSString *)URL
       parameters:(NSDictionary *)parameters
          success:(void (^)(id successResponse))success
             fail:(void (^)(NSError *error))fail;
@end
