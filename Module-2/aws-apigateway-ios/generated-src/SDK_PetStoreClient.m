/*
 Copyright 2010-2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License").
 You may not use this file except in compliance with the License.
 A copy of the License is located at

 http://aws.amazon.com/apache2.0

 or in the "license" file accompanying this file. This file is distributed
 on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 express or implied. See the License for the specific language governing
 permissions and limitations under the License.
 */
 


#import "SDK_PetStoreClient.h"
#import <AWSCore/AWSCore.h>
#import <AWSCore/AWSSignature.h>
#import <AWSCore/AWSSynchronizedMutableDictionary.h>

#import "SDK_Pets.h"
#import "SDK_NewPet.h"
#import "SDK_NewPetResponse.h"
#import "SDK_Empty.h"
#import "SDK_Pet.h"

@interface AWSAPIGatewayClient()

// Networking
@property (nonatomic, strong) NSURLSession *session;

// For requests
@property (nonatomic, strong) NSURL *baseURL;

// For responses
@property (nonatomic, strong) NSDictionary *HTTPHeaderFields;
@property (nonatomic, assign) NSInteger HTTPStatusCode;

- (AWSTask *)invokeHTTPRequest:(NSString *)HTTPMethod
                     URLString:(NSString *)URLString
                pathParameters:(NSDictionary *)pathParameters
               queryParameters:(NSDictionary *)queryParameters
              headerParameters:(NSDictionary *)headerParameters
                          body:(id)body
                 responseClass:(Class)responseClass;

@end

@interface SDK_PetStoreClient()

@property (nonatomic, strong) AWSServiceConfiguration *configuration;

@end

@interface AWSServiceConfiguration()

@property (nonatomic, strong) AWSEndpoint *endpoint;

@end

@implementation SDK_PetStoreClient

static NSString *const AWSInfoClientKey = @"SDK_PetStoreClient";

@synthesize configuration = _configuration;

static AWSSynchronizedMutableDictionary *_serviceClients = nil;

+ (instancetype)defaultClient {
    AWSServiceConfiguration *serviceConfiguration = nil;
    AWSServiceInfo *serviceInfo = [[AWSInfo defaultAWSInfo] defaultServiceInfo:AWSInfoClientKey];
    if (serviceInfo) {
        serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:serviceInfo.region
                                                           credentialsProvider:serviceInfo.cognitoCredentialsProvider];
    } else if ([AWSServiceManager defaultServiceManager].defaultServiceConfiguration) {
        serviceConfiguration = AWSServiceManager.defaultServiceManager.defaultServiceConfiguration;
    } else {
        serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown
                                                           credentialsProvider:nil];
    }

    static SDK_PetStoreClient *_defaultClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultClient = [[SDK_PetStoreClient alloc] initWithConfiguration:serviceConfiguration];
    });

    return _defaultClient;
}

+ (void)registerClientWithConfiguration:(AWSServiceConfiguration *)configuration forKey:(NSString *)key {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _serviceClients = [AWSSynchronizedMutableDictionary new];
    });
    [_serviceClients setObject:[[SDK_PetStoreClient alloc] initWithConfiguration:configuration]
                        forKey:key];
}

+ (instancetype)clientForKey:(NSString *)key {
    @synchronized(self) {
        SDK_PetStoreClient *serviceClient = [_serviceClients objectForKey:key];
        if (serviceClient) {
            return serviceClient;
        }

        AWSServiceInfo *serviceInfo = [[AWSInfo defaultAWSInfo] serviceInfo:AWSInfoClientKey
                                                                     forKey:key];
        if (serviceInfo) {
            AWSServiceConfiguration *serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:serviceInfo.region
                                                                                        credentialsProvider:serviceInfo.cognitoCredentialsProvider];
            [SDK_PetStoreClient registerClientWithConfiguration:serviceConfiguration
                                                    forKey:key];
        }

        return [_serviceClients objectForKey:key];
    }
}

+ (void)removeClientForKey:(NSString *)key {
    [_serviceClients removeObjectForKey:key];
}

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"`- init` is not a valid initializer. Use `+ defaultClient` or `+ clientForKey:` instead."
                                 userInfo:nil];
    return nil;
}

- (instancetype)initWithConfiguration:(AWSServiceConfiguration *)configuration {
    if (self = [super init]) {
        _configuration = [configuration copy];

        NSString *URLString = @"https://dmsemlab85.execute-api.us-west-2.amazonaws.com/demo";
        if ([URLString hasSuffix:@"/"]) {
            URLString = [URLString substringToIndex:[URLString length] - 1];
        }
        _configuration.endpoint = [[AWSEndpoint alloc] initWithRegion:_configuration.regionType
                                                              service:AWSServiceAPIGateway
                                                                  URL:[NSURL URLWithString:URLString]];

        AWSSignatureV4Signer *signer =  [[AWSSignatureV4Signer alloc] initWithCredentialsProvider:_configuration.credentialsProvider
                                                                                         endpoint:_configuration.endpoint];

        _configuration.baseURL = _configuration.endpoint.URL;
        _configuration.requestInterceptors = @[[AWSNetworkingRequestInterceptor new], signer];
    }
    
    return self;
}

- (AWSTask *)rootGet {
    NSDictionary *headerParameters = @{
                                       @"Content-Type": @"application/json",
                                       @"Accept": @"application/json",
                                       
                                       };
    NSDictionary *queryParameters = @{
                                      
                                      };
    NSDictionary *pathParameters = @{
                                     
                                     };
    
    return [self invokeHTTPRequest:@"GET"
                         URLString:@"/"
                    pathParameters:pathParameters
                   queryParameters:queryParameters
                  headerParameters:headerParameters
                              body:nil
                     responseClass:nil];
}

- (AWSTask *)petsGet:(NSString *)type page:(NSString *)page {
    NSDictionary *headerParameters = @{
                                       @"Content-Type": @"application/json",
                                       @"Accept": @"application/json",
                                       
                                       };
    NSDictionary *queryParameters = @{
                                      @"type": type,
                                     @"page": page
                                      };
    NSDictionary *pathParameters = @{
                                     
                                     };
    
    return [self invokeHTTPRequest:@"GET"
                         URLString:@"/pets"
                    pathParameters:pathParameters
                   queryParameters:queryParameters
                  headerParameters:headerParameters
                              body:nil
                     responseClass:[SDK_Pets class]];
}

- (AWSTask *)petsPost:(SDK_NewPet *)body {
    NSDictionary *headerParameters = @{
                                       @"Content-Type": @"application/json",
                                       @"Accept": @"application/json",
                                       
                                       };
    NSDictionary *queryParameters = @{
                                      
                                      };
    NSDictionary *pathParameters = @{
                                     
                                     };
    
    return [self invokeHTTPRequest:@"POST"
                         URLString:@"/pets"
                    pathParameters:pathParameters
                   queryParameters:queryParameters
                  headerParameters:headerParameters
                              body:body
                     responseClass:[SDK_NewPetResponse class]];
}

- (AWSTask *)petsOptions {
    NSDictionary *headerParameters = @{
                                       @"Content-Type": @"application/json",
                                       @"Accept": @"application/json",
                                       
                                       };
    NSDictionary *queryParameters = @{
                                      
                                      };
    NSDictionary *pathParameters = @{
                                     
                                     };
    
    return [self invokeHTTPRequest:@"OPTIONS"
                         URLString:@"/pets"
                    pathParameters:pathParameters
                   queryParameters:queryParameters
                  headerParameters:headerParameters
                              body:nil
                     responseClass:[SDK_Empty class]];
}

- (AWSTask *)petsPetIdGet:(NSString *)petId {
    NSDictionary *headerParameters = @{
                                       @"Content-Type": @"application/json",
                                       @"Accept": @"application/json",
                                       
                                       };
    NSDictionary *queryParameters = @{
                                      
                                      };
    NSDictionary *pathParameters = @{
                                     @"petId": petId
                                     };
    
    return [self invokeHTTPRequest:@"GET"
                         URLString:@"/pets/{petId}"
                    pathParameters:pathParameters
                   queryParameters:queryParameters
                  headerParameters:headerParameters
                              body:nil
                     responseClass:[SDK_Pet class]];
}

- (AWSTask *)petsPetIdOptions:(NSString *)petId {
    NSDictionary *headerParameters = @{
                                       @"Content-Type": @"application/json",
                                       @"Accept": @"application/json",
                                       
                                       };
    NSDictionary *queryParameters = @{
                                      
                                      };
    NSDictionary *pathParameters = @{
                                     @"petId": petId
                                     };
    
    return [self invokeHTTPRequest:@"OPTIONS"
                         URLString:@"/pets/{petId}"
                    pathParameters:pathParameters
                   queryParameters:queryParameters
                  headerParameters:headerParameters
                              body:nil
                     responseClass:[SDK_Empty class]];
}



@end
