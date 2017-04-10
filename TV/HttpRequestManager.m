//
//  HttpRequest.m
//  haipai
//
//  Created by Tom Yin on 2016/12/13.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "HttpRequestManager.h"

#define TIMEOUT 30

static HttpRequestManager *requestManager = nil;

@implementation HttpRequestManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [[self alloc] initWithBaseURL:nil];
        [requestManager.operationQueue setMaxConcurrentOperationCount:5];
        requestManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        requestManager.securityPolicy.allowInvalidCertificates = YES;
        requestManager.securityPolicy.validatesDomainName = NO;
        requestManager.requestSerializer.timeoutInterval = TIMEOUT;
    });
    AFJSONResponseSerializer *jsonSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    jsonSerializer.removesKeysWithNullValues = YES;
    jsonSerializer.acceptableContentTypes = [NSSet setWithObjects:@"image/jpeg",@"text/json",@"text/html",@"application/x-www-form-urlencoded",@"text/plain",nil];
    AFHTTPResponseSerializer *normalSerializer = [AFHTTPResponseSerializer serializer];
    NSArray *serizlizers = @[jsonSerializer,normalSerializer];
    requestManager.responseSerializer =  [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:serizlizers];
    return requestManager;
}
- (void)addPOSTURL:(NSString *)URL person:(RequestPerson)person parameters:(NSDictionary *)parameters success:(void (^)(id))success fail:(void (^)(NSError *))fail {
    NSString *baseURL = nil;
    //   http://xwmasd.server.ngrok.cc/FyHome 测试地址
    switch (person) {
        case RequestPersonWeiMing:
            baseURL = @"http://59.110.8.72/FyHome";
            break;
        case RequestPersonYuChuan:
            baseURL = @"http://59.110.8.72/FyHome";
            break;
        default:
            baseURL = @"http://59.110.8.72/FyHome";
            break;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@", baseURL, URL];
    [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        } else if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (result.length) {
                NSError *__autoreleasing error = nil;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
                if (!error) {
                    success(dic);
                }else{
                    success(nil);
                }
            } else {
                success(nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

- (void)addPOSTURL:(NSString *)URL parameters:(NSDictionary *)parameters constructingBody:(void (^)(id<AFMultipartFormData>))block success:(void (^)(id))success fail:(void (^)(NSError *))fail {
//    [self POST:[NSString stringWithFormat:@"%@%@", @"http://mayuchuan.ngrok.cc/FyHome", URL] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (fail) {
//            fail(error);
//        }
//    }];
    [self POST:[NSString stringWithFormat:@"%@%@", @"http://xwmasd.server.ngrok.cc/FyHome", URL] parameters:parameters constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        } else if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (result.length) {
                NSError *__autoreleasing error = nil;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
                if (!error) {
                    success(dic);
                }else{
                    success(nil);
                }
            } else {
                success(nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

@end
