//
//  BaseURLRequestService.m
//  Currencies
//
//  Created by Krzysztof Jężak on 28.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseURLRequestService.h"
#import "AppDelegate.h"

@implementation BaseURLRequestService

+ (NSURL *)baseURL {
  NSURL *url = [NSURL URLWithString:kBaseURL];

  return url;
}

+ (NSTimeInterval)requestTimeout {
  return 30.f;
}

- (instancetype)init {
  self = [super init];
  if (self) {

    _manager = [[AFHTTPSessionManager alloc]
        initWithBaseURL:[BaseURLRequestService baseURL]];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes =
        [NSSet setWithObjects:@"application/json", nil];
    _manager.operationQueue.maxConcurrentOperationCount = 1;
    [_manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [self setHTTPHeaders];
      
    _localContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    _localContext.parentContext = [[THMCoreDataManager sharedManager] managedObjectContext];
    
  }
  return self;
}

- (void)setHTTPHeaders {
  //  _manager HTTP headers if needed
}

- (void)createOperation {
  // set AFOAuthCredential if needed
    
  /*AFOAuthCredential *credential = [AFOAuthCredential
      retrieveCredentialWithIdentifier:kCredentialIdentifier];
  if (credential) {
    [_manager.requestSerializer
        setAuthorizationHeaderFieldWithCredential:credential];
    if (credential.expired) {
      [self refreshTokenIfNeeded:credential];
      return;
    }
  }*/
}

- (void)start {
  [self createOperation];
}

- (void)stop {
  [_manager.operationQueue cancelAllOperations];
}

- (void)setCompletionBlock:(void (^)(NSError *error, id userInfo))completion {
  _completionBlock = completion;
}

- (void)serviceDidFinished:(NSError *)error userInfo:(id)userInfo {

  if (error != nil) {
    NSHTTPURLResponse *response;
    id errorData =
        error.userInfo[@"com.alamofire.serialization.response.error.response"];
    if (errorData) {
      response = errorData;
      if (response.statusCode == 401) {
        /*AFOAuthCredential *credential = [AFOAuthCredential
            retrieveCredentialWithIdentifier:kCredentialIdentifier];
        [self refreshTokenIfNeeded:credential];*/
      } else {
        id obj;
        id errorData =
            error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (errorData) {
          obj = [NSJSONSerialization
              JSONObjectWithData:errorData
                         options:NSJSONReadingMutableContainers
                           error:nil];
        }
        [self showErrorAlert:[NSString
                                 stringWithFormat:@"%@\n\nDetails:\n%@",
                                                  error.localizedDescription,
                                                  obj]];
      }
    } else {
        [self showErrorAlert:[error localizedDescription]];
    }
  }

#ifdef DEBUG
  NSLog(@"Service did finish: %@", NSStringFromClass([self class]));
  NSLog(@"Response:\n %@", userInfo);
#endif

  if (_completionBlock) {
    _completionBlock(error, userInfo);
  }
}

- (void)showErrorAlert:(NSString *)message {
    
  UIAlertController *alertController = [UIAlertController
                                        alertControllerWithTitle:NSLocalizedString(@"Error occured", nil)
                                        message:message
                                        preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *okAction =
  [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                           style:UIAlertActionStyleCancel
                         handler:nil];
    
  UIAlertAction *againAction =
  [UIAlertAction actionWithTitle:NSLocalizedString(@"Try again", nil)
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * _Nonnull action) {
                               [self createOperation];
                           }];
    
  [alertController addAction:okAction];
  [alertController addAction:againAction];
    
    
  AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
  [delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}

/*- (void)refreshTokenIfNeeded:(AFOAuthCredential *)credential {
  
}*/

@end
