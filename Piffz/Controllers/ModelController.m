//
//  ModelController.m
//  BabyGoesToBeddy
//
//  Created by AppsCreationTech on 4/10/13.
//  Copyright (c) 2013 AppsCreationTech. All rights reserved.
//

#import "ModelController.h"
#import "DataViewController.h"


@interface ModelController()
@property (readonly, strong, nonatomic) NSArray *pageLabels;
@property (readonly, strong, nonatomic) NSArray *pageNumber;
@property (readonly, strong, nonatomic) NSArray *pageImages;
@property (readonly, strong, nonatomic) NSArray *pageSounds;
@property (readonly, strong, nonatomic) NSArray *recordNumber;

@end

@implementation ModelController

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data models
        
        _pageLabels = [NSArray arrayWithObjects:
                       @"Lorem ipsum dolor sit amet,\nconsectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",    //pg 1
                       @"Ut enim ad minim veniam,\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",                     //pg 2
                       @"Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ",                          //pg 3
                       @"Excepteur sint occaecat cupidatat non proident,\nsunt in culpa qui officia deserunt mollit anim id est laborum. ",                  //pg 4
                       @"The End ",         //pg 5
                       @"Lorem ipsum dolor sit amet,\nconsectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",    //pg 6
                       @"Ut enim ad minim veniam,\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",                     //pg 7
                       @"Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ",                          //pg 8
                       @"Excepteur sint occaecat cupidatat non proident,\nsunt in culpa qui officia deserunt mollit anim id est laborum. ",                  //pg 9
                       @"The End ",         //pg 10
                       nil];
        
        _pageNumber = [NSArray arrayWithObjects:
                       @"001",                //pg 1
                       @"002",                //pg 2
                       @"003",                //pg 3
                       @"004",                //pg 4
                       @"005",                //pg 5
                       @"006",                //pg 6
                       @"007",                //pg 7
                       @"008",                //pg 8
                       @"009",                //pg 9
                       @"010",                //pg 10
                       nil];
        
        _pageImages = [[NSArray alloc] initWithObjects:
                       [UIImage imageNamed:@"page_001.png"],
                       [UIImage imageNamed:@"page_002.png"],
                       [UIImage imageNamed:@"page_003.png"],
                       [UIImage imageNamed:@"page_004.png"],
                       [UIImage imageNamed:@"page_005.png"],
                       [UIImage imageNamed:@"page_001.png"],
                       [UIImage imageNamed:@"page_002.png"],
                       [UIImage imageNamed:@"page_003.png"],
                       [UIImage imageNamed:@"page_004.png"],
                       [UIImage imageNamed:@"page_005.png"],
                      nil];
        
        _pageSounds = [[NSArray alloc] initWithObjects:
                       [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"page_001" ofType:@"wav"]],
                       [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"page_002" ofType:@"wav"]],
                       [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"page_003" ofType:@"wav"]],
                       [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"page_004" ofType:@"wav"]],
                       [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"page_005" ofType:@"wav"]],
                       [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"page_006" ofType:@"wav"]],
                       [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"page_007" ofType:@"wav"]],
                       [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"page_008" ofType:@"wav"]],
                       [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"page_009" ofType:@"wav"]],
                       [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"page_010" ofType:@"wav"]],
                      nil];
        
        _recordNumber = [[NSArray alloc] initWithObjects:
                         @"record_001",
                         @"record_002",
                         @"record_003",
                         @"record_004",
                         @"record_005",
                         @"record_006",
                         @"record_007",
                         @"record_008",
                         @"record_009",
                         @"record_010",
                       nil];
        
        
    }
    return self;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    // Return the data view controller for the given index.
    
    //this if is for broken cases
    if (([self.pageLabels count] == 0) || (index >= [self.pageLabels count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.dataLabel = self.pageLabels[index];
    dataViewController.dataNumber = self.pageNumber[index];
    dataViewController.dataImage = self.pageImages[index];
    dataViewController.dataSound = self.pageSounds[index];
    dataViewController.dataRecord = self.recordNumber[index];
    
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageLabels indexOfObject:viewController.dataLabel];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageLabels count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
