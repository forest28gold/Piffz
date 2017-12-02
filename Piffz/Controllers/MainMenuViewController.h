//
//  MainMenuViewController.h
//  Piffz
//
//  Created by AppsCreationTech on 4/7/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import "ViewController.h"

@interface MainMenuViewController : ViewController


@property (strong, nonatomic) IBOutlet UIButton *m_btnReadToMe;
@property (strong, nonatomic) IBOutlet UIButton *m_btnReadMyself;
@property (strong, nonatomic) IBOutlet UIButton *m_btnHelp;
@property (strong, nonatomic) IBOutlet UIButton *m_btnSettings;
@property (strong, nonatomic) IBOutlet UIButton *m_btnAbout;
@property (strong, nonatomic) IBOutlet UIButton *m_btnMoreBooks;

@property (strong, nonatomic) IBOutlet UIView *m_viewOverlay;

@property (strong, nonatomic) IBOutlet UIView *m_viewAbout;
@property (strong, nonatomic) IBOutlet UILabel *m_lblAboutTitle;
@property (strong, nonatomic) IBOutlet UILabel *m_lblAbout;
@property (strong, nonatomic) IBOutlet UIButton *m_btnClose;

- (IBAction)onClickBtnReadToMe:(id)sender;
- (IBAction)onClickBtnReadMyself:(id)sender;
- (IBAction)onClickBtnHelp:(id)sender;

- (IBAction)onClickBtnSettings:(id)sender;
- (IBAction)onClickBtnMoreBooks:(id)sender;

- (IBAction)onClickBtnAbout:(id)sender;
- (IBAction)onClickBtnClose:(id)sender;

- (IBAction)onBackHome:(UIStoryboardSegue *)segue;

@end
