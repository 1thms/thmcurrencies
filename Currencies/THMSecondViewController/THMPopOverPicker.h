//
//  THMPopOverPicker.h
//  Currencies
//
//  Created by Krzysztof Jężak on 29.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface THMPopOverPicker : UITableViewController

@property(nonatomic) BOOL shouldDisplayCurrencyCode;

@property(strong, nonatomic) NSManagedObjectID *selectedObjectID;
@property (nonatomic, copy) void (^popoverDidDismiss)(NSManagedObjectID *);

@end
