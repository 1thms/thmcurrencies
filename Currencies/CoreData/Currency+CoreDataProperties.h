//
//  Currency+CoreDataProperties.h
//  Currencies
//
//  Created by Krzysztof Jężak on 29.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Currency.h"

NS_ASSUME_NONNULL_BEGIN

@interface Currency (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *code;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
