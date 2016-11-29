//
//  THMSecondViewController.h
//  Currencies
//
//  Created by Krzysztof Jężak on 28.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import "THMBaseViewController.h"
#import "THMBaseButton.h"
#import "THMPopOverPicker.h"

@import CoreData;

@interface THMSecondViewController : THMBaseViewController

@property(strong, nonatomic) THMPopOverPicker *popoverController;
@property (strong, nonatomic) NSManagedObjectID *selectedObjectId;

@property (weak, nonatomic) IBOutlet THMBaseButton *buttonSelectChangeCurrency;

@end
