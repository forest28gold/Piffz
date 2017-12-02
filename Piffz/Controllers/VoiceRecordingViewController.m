//
//  VoiceRecordingViewController.m
//  Piffz
//
//  Created by AppsCreationTech on 4/7/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import "VoiceRecordingViewController.h"
#import "AppDelegate.h"
#import "ModelController.h"
#import "DataViewController.h"

@interface VoiceRecordingViewController ()

@property (readonly, strong, nonatomic) ModelController *modelController;
@end

@implementation VoiceRecordingViewController

@synthesize modelController = _modelController;

@synthesize m_viewHelp;
@synthesize m_btnClose;
@synthesize m_btnTouch, m_btnSwipeLeft, m_btnSwipeRight;
@synthesize m_btnHelpHome, m_btnHelpPlay, m_btnHelpRecord;

@synthesize m_viewBook;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [m_btnClose.titleLabel setFont:m_fontHomeButton];
    [m_btnTouch.titleLabel setFont:m_fontHelp];
    [m_btnSwipeLeft.titleLabel setFont:m_fontHelp];
    [m_btnSwipeRight.titleLabel setFont:m_fontHelp];
    [m_btnHelpHome.titleLabel setFont:m_fontHelp];
    [m_btnHelpPlay.titleLabel setFont:m_fontHelp];
    [m_btnHelpRecord.titleLabel setFont:m_fontHelp];
    
    
    if ([m_bookpageMode isEqualToString:read_to_me]) {
        m_viewHelp.hidden = YES;
    } else if ([m_bookpageMode isEqualToString:read_myself]) {
        m_viewHelp.hidden = YES;
    } else if ([m_bookpageMode isEqualToString:read_help]) {
        m_viewHelp.hidden = NO;
    }
    
    //     Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    
    DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    self.pageViewController.dataSource = self.modelController;
    
    [self addChildViewController:self.pageViewController];
    [self.m_viewBook addSubview:self.pageViewController.view];
        
    [self.pageViewController didMoveToParentViewController:self];
    
    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)onClickBtnHelpClose:(id)sender
{
    
    [self performSegueWithIdentifier:TO_BACK_HOME sender:self];
}

- (ModelController *)modelController
{
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[ModelController alloc] init];
    }
    return _modelController;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - UIPageViewController delegate methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{

    UIViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;

}


@end
