//
//  CurrenciesURLRequestService.m
//  Currencies
//
//  Created by Krzysztof Jężak on 28.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import "CurrenciesURLRequestService.h"
#import "SVProgressHUD.h"
@import CoreData;
#import "Currency.h"

@implementation CurrenciesURLRequestService

-(void)createOperation
{
    [super createOperation];
    
    [SVProgressHUD show];
    [_manager GET:@"currencies.json" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [self.localContext performBlock:^{
            
        NSFetchRequest *fr =
        [NSFetchRequest fetchRequestWithEntityName:@"Currency"];
        NSArray *currencies = [self.localContext executeFetchRequest:fr error:NULL];
        NSMutableSet *currenciesToDelete = [NSMutableSet setWithArray:currencies];
        NSArray *currencyIDs = [currencies valueForKeyPath:@"code"];
        NSUInteger index;
        Currency *currency;

        NSString *currencyID;
        
        NSArray *allKeys = [responseObject allKeys];
        
        for (NSString *key in allKeys) {
            currencyID = key;
            index = [currencyIDs indexOfObject:currencyID];
            if (index == NSNotFound) {
                currency = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Currency"
                             inManagedObjectContext:self.localContext];
                currency.code = currencyID;
            } else {
                currency = [currencies objectAtIndex:index];
            }
            
            currency.name = [responseObject objectForKey:key];
            
            [currenciesToDelete removeObject:currency];
        }
        
        for (Currency *currencyToDelete in currenciesToDelete) {
            [self.localContext deleteObject:currencyToDelete];
        }
            
        NSError *error;
        [self.localContext save:&error];
            
        [[THMCoreDataManager sharedManager] saveData];
            
        }];
        
        
        [self serviceDidFinished:nil userInfo:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self serviceDidFinished:error userInfo:nil];
    }];
}

@end
