//
//  THMPopOverPicker.m
//  Currencies
//
//  Created by Krzysztof Jężak on 29.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import "THMPopOverPicker.h"
#import "AppDelegate.h"
#import "Currency.h"
#import "THMCoreDataManager.h"

@interface THMPopOverPicker () <NSFetchedResultsControllerDelegate>

@property(strong, nonatomic) Currency *selectedCurrency;
@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end

@implementation THMPopOverPicker

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.managedObjectContext = [[THMCoreDataManager sharedManager] managedObjectContext];;
    
    if (self.selectedObjectID) {
        self.selectedCurrency = [self.managedObjectContext objectWithID:self.selectedObjectID];
    }
    
    [[self fetchedResultsController] performFetch:nil];
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Currency" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *fetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = fetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    Currency *currency = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = self.shouldDisplayCurrencyCode ? [NSString stringWithFormat:@"%@ (%@)", currency.name, currency.code] : currency.name;
    
    cell.accessoryType = [currency.code isEqual:self.selectedCurrency.code] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSIndexPath *previousIndexPath = [self.fetchedResultsController indexPathForObject:self.selectedCurrency];
    
    self.selectedCurrency = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSMutableArray *indexPathsToReload = [[NSMutableArray alloc] initWithObjects:indexPath, nil];
    if (previousIndexPath) {
        [indexPathsToReload addObject:previousIndexPath];
    }
    
    [tableView reloadRowsAtIndexPaths:indexPathsToReload withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (self.popoverDidDismiss) {
        self.popoverDidDismiss(self.selectedCurrency.objectID);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationRight];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationLeft];
            break;
            
        case NSFetchedResultsChangeUpdate: {
            
            
        } break;
            
        case NSFetchedResultsChangeMove:
            if (![indexPath isEqual:newIndexPath]) {
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                 withRowAnimation:UITableViewRowAnimationFade];
                [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                 withRowAnimation:UITableViewRowAnimationFade];
            }
            if ([indexPath compare:newIndexPath] == NSOrderedSame) {
                [tableView reloadRowsAtIndexPaths:@[ indexPath ]
                                 withRowAnimation:UITableViewRowAnimationNone];
            }
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


@end
