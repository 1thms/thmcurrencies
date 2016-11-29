//
//  THMFirstViewController.m
//  Currencies
//
//  Created by Krzysztof Jężak on 28.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import "THMFirstViewController.h"
#import "CurrenciesURLRequestService.h"
#import "THMBaseButton.h"

@interface THMFirstViewController ()

@property (weak, nonatomic) IBOutlet THMBaseButton *buttonDownloadData;
@property (weak, nonatomic) IBOutlet THMBaseButton *buttonUseOffline;

- (IBAction)buttonDownloadDataDidClick:(id)sender;
- (IBAction)buttonUseOfflineDidClick:(id)sender;

@end

@implementation THMFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.buttonDownloadData setTitle:NSLocalizedString(@"Download currencies", nil) forState:UIControlStateNormal];
    [self.buttonUseOffline setTitle:NSLocalizedString(@"Use offline currencies", nil) forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFetchRequest *fr =
    [NSFetchRequest fetchRequestWithEntityName:@"Currency"];
    NSArray *currencies = [self.managedObjectContext executeFetchRequest:fr error:NULL];
    
    self.buttonUseOffline.enabled = currencies.count ? YES : NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonDownloadDataDidClick:(id)sender {
    CurrenciesURLRequestService *service = [[CurrenciesURLRequestService alloc] init];
    [service setCompletionBlock:^(NSError *error, id userInfo) {
        [SVProgressHUD dismiss];
        if (!error) {
            [self performSegueWithIdentifier:@"secondViewControllerSegue" sender:nil];
        }
    }];
    [service start];
}

- (IBAction)buttonUseOfflineDidClick:(id)sender {
     [self performSegueWithIdentifier:@"secondViewControllerSegue" sender:nil];
}

@end
