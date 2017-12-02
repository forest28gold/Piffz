//
//  VoiceRecordingViewController.h
//  Piffz
//
//  Created by AppsCreationTech on 4/7/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface VoiceRecordingViewController : ViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIView *m_viewHelp;
@property (strong, nonatomic) IBOutlet UIButton *m_btnClose;
@property (strong, nonatomic) IBOutlet UIButton *m_btnTouch;
@property (strong, nonatomic) IBOutlet UIButton *m_btnSwipeLeft;
@property (strong, nonatomic) IBOutlet UIButton *m_btnSwipeRight;
@property (strong, nonatomic) IBOutlet UIButton *m_btnHelpHome;
@property (strong, nonatomic) IBOutlet UIButton *m_btnHelpRecord;
@property (strong, nonatomic) IBOutlet UIButton *m_btnHelpPlay;

@property (strong, nonatomic) IBOutlet UIView *m_viewBook;

@property (strong, nonatomic) UIPageViewController *pageViewController;


- (IBAction)onClickBtnHelpClose:(id)sender;

@end
