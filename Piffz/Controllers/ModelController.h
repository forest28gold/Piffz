//
//  ModelController.h
//  BabyGoesToBeddy
//
//  Created by AppsCreationTech on 4/10/13.
//  Copyright (c) 2013 AppsCreationTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end
