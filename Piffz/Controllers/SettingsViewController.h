//
//  SettingsViewController.h
//  Piffz
//
//  Created by AppsCreationTech on 4/7/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import "ViewController.h"

@interface SettingsViewController : ViewController

@property (strong, nonatomic) IBOutlet UILabel *m_lblSettings;
@property (strong, nonatomic) IBOutlet UILabel *m_lblDescription;
@property (strong, nonatomic) IBOutlet UIButton *m_btnBackHome;

@property (strong, nonatomic) IBOutlet UIView *m_viewSettings;
@property (strong, nonatomic) IBOutlet UIButton *m_btnShowPageText;
@property (strong, nonatomic) IBOutlet UIButton *m_btnSavemyRecordings;
@property (strong, nonatomic) IBOutlet UIButton *m_btnDeleteAll;
@property (strong, nonatomic) IBOutlet UILabel *m_lblDelete;

@property (strong, nonatomic) IBOutlet UIView *m_viewSubscribe;
@property (strong, nonatomic) IBOutlet UILabel *m_lblSubDescription;
@property (strong, nonatomic) IBOutlet UITextField *m_txtName;
@property (strong, nonatomic) IBOutlet UITextField *m_txtEmail;
@property (strong, nonatomic) IBOutlet UIButton *m_btnSubscribe;
@property (strong, nonatomic) IBOutlet UILabel *m_lblTerms1;
@property (strong, nonatomic) IBOutlet UILabel *m_lblTerms2;
@property (strong, nonatomic) IBOutlet UILabel *m_lblTerms3;
@property (strong, nonatomic) IBOutlet UILabel *m_lblTerms4;
@property (strong, nonatomic) IBOutlet UIButton *m_btnTerms;
@property (strong, nonatomic) IBOutlet UIButton *m_btnPrivacy;

@property (strong, nonatomic) IBOutlet UIView *m_viewSettingsOverlay;

@property (strong, nonatomic) IBOutlet UIView *m_viewConfirm;
@property (strong, nonatomic) IBOutlet UILabel *m_lblConfirm;
@property (strong, nonatomic) IBOutlet UILabel *m_lblConfirmContent;
@property (strong, nonatomic) IBOutlet UIButton *m_btnNo;
@property (strong, nonatomic) IBOutlet UIButton *m_btnYes;
@property (strong, nonatomic) IBOutlet UIButton *m_btnOK;


- (IBAction)onClickBtnHome:(id)sender;

- (IBAction)onClickBtnShowPageText:(id)sender;
- (IBAction)onClickBtnSavemyRecordings:(id)sender;
- (IBAction)onClickBtnDeleteAll:(id)sender;

- (IBAction)onClickBtnSubscribe:(id)sender;

- (IBAction)onClickBtnConfirmNo:(id)sender;
- (IBAction)onClickBtnConfirmYes:(id)sender;
- (IBAction)onClickBtnConfirmOK:(id)sender;

- (IBAction)onClickBtnTerms:(id)sender;
- (IBAction)onClickBtnPrivacy:(id)sender;

- (IBAction)onBackSettings:(UIStoryboardSegue *)segue;


@end
