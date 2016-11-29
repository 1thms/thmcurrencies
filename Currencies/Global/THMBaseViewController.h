//
//  THMBaseViewController.h
//  Currencies
//
//  Created by Krzysztof Jężak on 28.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface THMBaseViewController : UIViewController

@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
