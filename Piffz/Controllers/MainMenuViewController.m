//
//  MainMenuViewController.m
//  Piffz
//
//  Created by AppsCreationTech on 4/7/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AppDelegate.h"


@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

@synthesize m_btnReadToMe, m_btnReadMyself, m_btnHelp;
@synthesize m_btnSettings, m_btnAbout, m_btnMoreBooks;
@synthesize m_viewOverlay;
@synthesize m_viewAbout;
@synthesize m_lblAboutTitle, m_lblAbout;
@synthesize m_btnClose;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [m_btnReadToMe.titleLabel setFont:m_fontHomeMenu];
    [m_btnReadMyself.titleLabel setFont:m_fontHomeMenu];
    [m_btnHelp.titleLabel setFont:m_fontHomeMenu];
    [m_btnSettings.titleLabel setFont:m_fontHomeMenu];
    [m_btnAbout.titleLabel setFont:m_fontHomeMenu];
    [m_btnMoreBooks.titleLabel setFont:m_fontHomeMenu];
    
    m_viewOverlay.hidden = YES;
    
    m_lblAboutTitle.font = m_fontTitle;
    
    m_viewAbout.layer.cornerRadius = 15;
    m_viewAbout.layer.shadowOpacity = 0.5;
    m_viewAbout.layer.shadowRadius = 5.0f;
    m_viewAbout.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    
    m_viewAbout.hidden = YES;
    
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

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    
    aView.hidden = NO;
    if (animated) {
        [self showAnimate];
    }
}

- (void)showAnimate
{
    m_viewAbout.transform = CGAffineTransformMakeScale(1.3, 1.3);
    m_viewAbout.alpha = 0;
    [UIView animateWithDuration:.30 animations:^{
        m_viewAbout.alpha = 1;
        m_viewAbout.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.20 animations:^{
        m_viewAbout.transform = CGAffineTransformMakeScale(1.3, 1.3);
        m_viewAbout.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            m_viewAbout.hidden = YES;
        }
    }];
}

- (IBAction)onClickBtnReadToMe:(id)sender
{
    m_bookpageMode = read_to_me;
    [self performSegueWithIdentifier:TO_READ_BOOK sender:self];
}

- (IBAction)onClickBtnReadMyself:(id)sender
{
    m_bookpageMode = read_myself;
    [self performSegueWithIdentifier:TO_READ_BOOK sender:self];
}

- (IBAction)onClickBtnHelp:(id)sender
{
    m_bookpageMode = read_help;
    [self performSegueWithIdentifier:TO_READ_BOOK sender:self];
}

- (IBAction)onClickBtnSettings:(id)sender
{
    [self performSegueWithIdentifier:TO_SETTINGS_VIEW sender:self];
}

- (IBAction)onClickBtnMoreBooks:(id)sender
{
    [self performSegueWithIdentifier:TO_MORE_BOOKS sender:self];
}

- (IBAction)onBackHome:(UIStoryboardSegue *)segue
{
    
}

- (IBAction)onClickBtnAbout:(id)sender
{
    m_viewOverlay.hidden = NO;
    [self showInView:m_viewAbout animated:YES];
    
}

- (IBAction)onClickBtnClose:(id)sender
{
    [self removeAnimate];
    m_viewOverlay.hidden = YES;
}

@end
