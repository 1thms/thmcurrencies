//
//  BaseURLRequestService.h
//  Currencies
//
//  Created by Krzysztof Jężak on 28.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>
#import "THMCoreDataManager.h"

#define kBaseURL @"https://openexchangerates.org/api/"

typedef void (^ServiceCompletionBlock)(NSError *error, id userInfo);

@interface BaseURLRequestService : NSObject {
@protected
  AFHTTPSessionManager *_manager;
@private
  ServiceCompletionBlock _completionBlock;
}

@property(strong, nonatomic) NSManagedObjectContext *localContext;
@property(strong, nonatomic) NSDictionary *paramsDictionary;

- (void)setHTTPHeaders;
- (void)createOperation;
- (void)start;
- (void)stop;
- (void)serviceDidFinished:(NSError *)error userInfo:(id)userInfo;
- (void)setCompletionBlock:(void (^)(NSError *error, id userInfo))completion;

@end
