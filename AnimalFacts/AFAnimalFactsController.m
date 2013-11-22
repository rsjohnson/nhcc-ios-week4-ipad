//
//  AFAnimalFactsController.m
//  AnimalFacts
//
//  Created by Jacob Good on 11/5/13.
//  Copyright (c) 2013 Jacob Good. All rights reserved.
//

#import "AFAnimalFactsController.h"
#import "AFAnimalViewController.h"
#import "AFAnimal.h"
#import "AFAnimalController.h"

@interface AFAnimalFactsController ()

@end

@implementation AFAnimalFactsController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sortAnimals];
    
    [[AFAnimalController sharedController] addObserver:self
                                            forKeyPath:@"animals" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"subject"]) {
        // trigger the reload of just the one cell
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [self.tableView reloadData];
    });
}

#pragma mark -
- (NSArray*) animals {
    return [AFAnimalController sharedController].animals;
}

- (void) removeAnimal:(AFAnimal *) animal {
    [self sortAnimals];
}

- (void) sortAnimals {
    NSArray *sortedArray;
    sortedArray = [self.animals sortedArrayUsingSelector:@selector(compare:)];
}

- (void) clearSubject:(id) sender {
    self.subject = nil;
}

- (void) saveSubject:(id) sender {
    if (self.subject != nil) {
        if (![self.animals containsObject:self.subject]) {
///            [self.animals addObject:self.subject];
            [self sortAnimals];
        }
        [self.animalTableView reloadData];
    }
}

- (void) dealloc {
    [[AFAnimalController sharedController] removeObserver:self forKeyPath:@"animals" context:NULL];
    [self clearSubject:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.animals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    AFAnimal * animal = self.animals[indexPath.row];
    [animal addObserver:self
             forKeyPath:@"subject"
                options:NSKeyValueObservingOptionNew context:NULL];
    cell.textLabel.text = animal.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AFAnimal * animal = [self.animals objectAtIndex:indexPath.row];
        [self removeAnimal:animal];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AFAnimalViewController *vc = (AFAnimalViewController*) [segue destinationViewController];
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        // Fetch animal out of list
        UITableViewCell * cell = (UITableViewCell*) sender;
        NSIndexPath * indexPath = [self.animalTableView indexPathForCell:cell];
        vc.animal = self.animals[indexPath.row];
    } else {
        self.subject = [[AFAnimal alloc] init];
        vc.animal = self.subject;
    }
}

@end
