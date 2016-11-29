//
//  THMThirdViewController.m
//  Currencies
//
//  Created by Krzysztof Jężak on 28.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import "THMThirdViewController.h"
#import "Currency.h"

@interface THMThirdViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelSelectedCurrency;

@property(strong, nonatomic) Currency *selectedCurrency;
@property(strong, nonatomic) Currency *temporaryCurrency;

@end

@implementation THMThirdViewController

@synthesize selectedObjectId = _selectedObjectId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.buttonSelectChangeCurrency setTitle:NSLocalizedString(@"Change currency", nil) forState:UIControlStateNormal];
    
    if (self.selectedObjectId) {
        self.selectedCurrency = [self.managedObjectContext objectWithID:self.selectedObjectId];
    }

    self.labelSelectedCurrency.hidden = NO;
    [self setTextLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTextLabel {
    self.labelSelectedCurrency.text = [NSString stringWithFormat:@"%@ %@ (%@)", NSLocalizedString(@"Selected currency:", nil), self.selectedCurrency.name, self.selectedCurrency.code];
}

-(void)setSelectedObjectId:(NSManagedObjectID *)selectedObjectId
{
    _selectedObjectId = selectedObjectId;
}

- (IBAction)buttonFindCurrencyDidClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    THMPopOverPicker *controller = [storyboard instantiateViewControllerWithIdentifier:@"THMPopOverPicker"];
    controller.shouldDisplayCurrencyCode = YES;
    controller.selectedObjectID = self.temporaryCurrency.objectID ? self.temporaryCurrency.objectID : self.selectedCurrency.objectID;
    controller.popoverDidDismiss = ^(NSManagedObjectID *objectID) {
        self.temporaryCurrency = [self.managedObjectContext objectWithID:objectID];
        if (self.temporaryCurrency) {
            self.buttonSelectChangeCurrency.enabled = YES;
        }
    };
    controller.modalPresentationStyle = UIModalPresentationPopover;
    controller.popoverPresentationController.delegate = self;
    self.popoverController = controller;
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (IBAction)buttonChangeCurrencyDidClick:(id)sender {
    self.selectedCurrency = self.temporaryCurrency;
    self.temporaryCurrency = nil;
    [self setTextLabel];
    self.buttonSelectChangeCurrency.enabled = NO;
}

@end
