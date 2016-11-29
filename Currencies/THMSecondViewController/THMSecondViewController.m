//
//  THMSecondViewController.m
//  Currencies
//
//  Created by Krzysztof Jężak on 28.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import "THMSecondViewController.h"
#import "THMPopOverPicker.h"
#import "THMThirdViewController.h"

@interface THMSecondViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *buttonFindCurrency;
@property (weak, nonatomic) IBOutlet THMBaseButton *buttonBack;
@property (weak, nonatomic) IBOutlet THMBaseButton *buttonRoot;

- (IBAction)buttonFindCurrencyDidClick:(id)sender;
- (IBAction)buttonBackDidClick:(id)sender;
- (IBAction)buttonStartOverDidClick:(id)sender;

@end

@implementation THMSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.buttonFindCurrency setTitle:NSLocalizedString(@"Find currency", nil) forState:UIControlStateNormal];
    [self.buttonSelectChangeCurrency setTitle:NSLocalizedString(@"Confirm currency", nil) forState:UIControlStateNormal];
    [self.buttonBack setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateNormal];
    [self.buttonRoot setTitle:NSLocalizedString(@"Start Over", nil) forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.buttonSelectChangeCurrency.enabled = NO;
    self.selectedObjectId = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSelectedObjectId:(NSManagedObjectID *)selectedObjectId
{
    _selectedObjectId = selectedObjectId;
    if (selectedObjectId) {
        self.buttonSelectChangeCurrency.enabled = YES;
    }
}

- (IBAction)buttonFindCurrencyDidClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    THMPopOverPicker *controller = [storyboard instantiateViewControllerWithIdentifier:@"THMPopOverPicker"];
    controller.selectedObjectID = self.selectedObjectId;
    controller.popoverDidDismiss = ^(NSManagedObjectID *objectID) {
        self.selectedObjectId = objectID;
    };
    controller.modalPresentationStyle = UIModalPresentationPopover;
    controller.popoverPresentationController.delegate = self;
    self.popoverController = controller;
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (IBAction)buttonBackDidClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buttonStartOverDidClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UIPopoverPresentationControllerDelegate

-(void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController {
    popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popoverPresentationController.sourceView = self.buttonFindCurrency;
    popoverPresentationController.sourceRect = self.buttonFindCurrency.bounds;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"THMThirdViewController"])
    {
        THMThirdViewController *vc = [segue destinationViewController];
        vc.selectedObjectId = self.selectedObjectId;
    }
}

@end
