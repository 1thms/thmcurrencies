//
//  THMBaseViewController.m
//  Currencies
//
//  Created by Krzysztof Jężak on 28.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import "THMBaseViewController.h"
#import "THMUIUtils.h"
#import "THMCoreDataManager.h"

@interface THMBaseViewController ()

@end

@implementation THMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [THMUIUtils defaultBackgroundColor];
    
    self.managedObjectContext = [[THMCoreDataManager sharedManager] managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
