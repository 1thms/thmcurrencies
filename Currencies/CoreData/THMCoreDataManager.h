//
//  THMCoreDataManager.h
//  Currencies
//
//  Created by Krzysztof Jężak on 29.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface THMCoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectMasterContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (id)sharedManager;
- (void)saveData;

@end
