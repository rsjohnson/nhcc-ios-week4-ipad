//
//  AFAnimalFactsController.h
//  AnimalFacts
//
//  Created by Jacob Good on 11/5/13.
//  Copyright (c) 2013 Jacob Good. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFAnimal.h"

@interface AFAnimalFactsController : UITableViewController

@property (nonatomic,strong, readonly) NSArray * animals;
@property (nonatomic,strong) AFAnimal * subject;
@property (nonatomic,weak) IBOutlet UITableView * animalTableView;

@end
