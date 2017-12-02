//
//  SettingsViewController.m
//  Piffz
//
//  Created by AppsCreationTech on 4/7/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"

@interface SettingsViewController ()
{
    BOOL toggleKeyboardIsOn;
}

@end

@implementation SettingsViewController

@synthesize m_lblSettings, m_lblDescription;
@synthesize m_btnBackHome;
@synthesize m_viewSettings;
@synthesize m_btnShowPageText, m_btnSavemyRecordings, m_btnDeleteAll, m_lblDelete;
@synthesize m_viewSubscribe;
@synthesize m_lblSubDescription, m_txtName, m_txtEmail, m_btnSubscribe;
@synthesize m_lblTerms1, m_lblTerms2, m_lblTerms3, m_lblTerms4;
@synthesize m_btnPrivacy, m_btnTerms;
@synthesize m_viewSettingsOverlay;
@synthesize m_viewConfirm;
@synthesize m_lblConfirm, m_btnNo, m_btnYes, m_btnOK, m_lblConfirmContent;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [m_txtName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [m_txtEmail addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    toggleKeyboardIsOn = false;
    
    if (showPageIsOn) {
        [m_btnShowPageText setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    } else {
        [m_btnShowPageText setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
    
    if (saveRecordingsIsOn) {
        [m_btnSavemyRecordings setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    } else {
        [m_btnSavemyRecordings setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
    
    m_lblSettings.font = m_fontTitle;
    
    [m_btnBackHome.titleLabel setFont:m_fontHomeButton];
    
    [m_btnShowPageText.titleLabel setFont:m_fontDialogMenu];
    [m_btnSavemyRecordings.titleLabel setFont:m_fontDialogMenu];
    [m_btnDeleteAll.titleLabel setFont:m_fontDialogMenu];
    
    m_lblSubDescription.font = m_fontSubscribe;
    m_btnSubscribe.layer.cornerRadius = 5;
    
    m_viewSettings.layer.cornerRadius = 15;
    m_viewSettings.layer.shadowOpacity = 0.5;
    m_viewSettings.layer.shadowRadius = 5.0f;
    m_viewSettings.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    
    m_viewSettingsOverlay.hidden = YES;
    
    m_lblConfirm.font = m_fontTitle;
    
    m_viewConfirm.layer.cornerRadius = 15;
    m_viewConfirm.layer.shadowOpacity = 0.5;
    m_viewConfirm.layer.shadowRadius = 5.0f;
    m_viewConfirm.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    
    m_btnNo.layer.cornerRadius = 5;
    m_btnYes.layer.cornerRadius = 5;
    
    m_viewConfirm.hidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.m_txtName || textField == self.m_txtEmail) {
        [self.m_txtName resignFirstResponder];
        [self.m_txtEmail resignFirstResponder];
        [self dismissKeyboard];
    }
    
    return YES;
}

#pragma mark Keyboard

- (void)dismissKeyboard {
    [self.view endEditing:YES];
    
    if (toggleKeyboardIsOn) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y + 250.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        toggleKeyboardIsOn = false;
    }
    
}


- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    aView.hidden = NO;
    if (animated) {
        [self showAnimate];
    }
}

- (void)showAnimate
{
    m_viewConfirm.transform = CGAffineTransformMakeScale(1.3, 1.3);
    m_viewConfirm.alpha = 0;
    [UIView animateWithDuration:.15 animations:^{
        m_viewConfirm.alpha = 1;
        m_viewConfirm.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.15 animations:^{
        m_viewConfirm.transform = CGAffineTransformMakeScale(1.0, 1.0);
        m_viewConfirm.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            m_viewConfirm.hidden = YES;
        }
    }];
}

- (IBAction)onClickBtnHome:(id)sender
{
    [self performSegueWithIdentifier:TO_BACK_HOME sender:self];
}

- (IBAction)onClickBtnShowPageText:(id)sender
{
    if(showPageIsOn){
        //do anything else you want to do.
        
    } else {
        //do anything you want to do.
    }
    showPageIsOn = !showPageIsOn;
    [m_btnShowPageText setImage:[UIImage imageNamed:showPageIsOn ? @"checked.png" : @"unchecked.png"] forState:UIControlStateNormal];
}

- (IBAction)onClickBtnSavemyRecordings:(id)sender
{
    if(saveRecordingsIsOn){
        //do anything else you want to do.
        
    } else {
        //do anything you want to do.
    }
    saveRecordingsIsOn = !saveRecordingsIsOn;
    [m_btnSavemyRecordings setImage:[UIImage imageNamed:saveRecordingsIsOn ? @"checked.png" : @"unchecked.png"] forState:UIControlStateNormal];
}

- (IBAction)onClickBtnDeleteAll:(id)sender
{
    
    m_btnNo.hidden = NO;
    m_btnYes.hidden = NO;
    m_btnOK.hidden = YES;
    
    m_lblConfirm.text = NSLocalizedString(@"confirm_title", "");
    m_lblConfirmContent.text = NSLocalizedString(@"confirm_content", "");
    
    m_viewSettingsOverlay.hidden = NO;
    m_btnOK.hidden = YES;
    [self showInView:m_viewConfirm animated:YES];
}

- (IBAction)onClickBtnSubscribe:(id)sender
{
    NSString *strName = m_txtName.text;
    NSString *strEmail = m_txtEmail.text;
    
    NSLog(@"Name = %@", strName);
    NSLog(@"Email = %@", strEmail);
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if([strName isEqualToString:@""]) {
        
        m_txtName.text = NSLocalizedString(@"error_name", @"");
        m_txtName.textColor = [UIColor redColor];
        
        return;
    } else if([strEmail isEqualToString:@""]) {
        
        m_txtEmail.text = NSLocalizedString(@"error_email", @"");
        m_txtEmail.textColor = [UIColor redColor];
        
        return;
    } else if(![emailTest evaluateWithObject:strEmail]) {
        
        m_txtEmail.text = NSLocalizedString(@"error_correct_email", @"");
        m_txtEmail.textColor = [UIColor redColor];
        
        return;
    }
    
    [self dismissKeyboard];
    
    // API function...
    
    NSURL *url = [NSURL URLWithString:Subscribe_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            key_name, strName,
                            key_email, strEmail,
                            nil];
    [httpClient postPath:Subscribe_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
        
        if ([responseStr isEqualToString:@"success"]) {
            
            m_btnOK.hidden = NO;
            m_btnNo.hidden = YES;
            m_btnYes.hidden = YES;
            
            m_lblConfirm.text = NSLocalizedString(@"alert_title", "");
            m_lblConfirmContent.text = NSLocalizedString(@"alert_subscribe_success", "");
            
            m_viewSettingsOverlay.hidden = NO;
            [self showInView:m_viewConfirm animated:YES];

            
        } else {
            
            m_btnOK.hidden = NO;
            m_btnNo.hidden = YES;
            m_btnYes.hidden = YES;
            
            m_lblConfirm.text = NSLocalizedString(@"alert_title", "");
            m_lblConfirmContent.text = NSLocalizedString(@"alert_subscribe_error", "");
            
            m_viewSettingsOverlay.hidden = NO;
            [self showInView:m_viewConfirm animated:YES];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        
        m_btnOK.hidden = NO;
        m_btnNo.hidden = YES;
        m_btnYes.hidden = YES;
        
        m_lblConfirm.text = NSLocalizedString(@"alert_title", "");
        m_lblConfirmContent.text = NSLocalizedString(@"alert_network_error", "");
        
        m_viewSettingsOverlay.hidden = NO;
        [self showInView:m_viewConfirm animated:YES];
        
        return;
    }];
    

}

- (IBAction)onClickBtnConfirmNo:(id)sender
{
    [self removeAnimate];
    m_viewSettingsOverlay.hidden = YES;
}

- (IBAction)onClickBtnConfirmYes:(id)sender
{
    [self removeAnimate];
    m_viewSettingsOverlay.hidden = YES;
    
    NSArray* recordFile = [[NSArray alloc] initWithObjects:
                     @"record_001.m4a",
                     @"record_002.m4a",
                     @"record_003.m4a",
                     @"record_004.m4a",
                     @"record_005.m4a",
                     nil];
    
    for (int i = 0; i < [recordFile count]; i++) {
        [self removeRecord:recordFile[i]];
    }
    
}

- (IBAction)onClickBtnConfirmOK:(id)sender
{
    [self removeAnimate];
    m_viewSettingsOverlay.hidden = YES;

}

- (void)removeRecord:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    if (fileExists) {
        NSError *error;
        BOOL success = [fileManager removeItemAtPath:filePath error:&error];
        if (success) {
            NSLog(@"Successfully removed");
        } else {
            NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
        }
    }
}

- (IBAction)onClickBtnTerms:(id)sender
{
    m_webviewMode = terms_mode;
    [self performSegueWithIdentifier:TO_WebView sender:self];
}

- (IBAction)onClickBtnPrivacy:(id)sender
{
    m_webviewMode = privacy_mode;
    [self performSegueWithIdentifier:TO_WebView sender:self];
}

- (IBAction)onBackSettings:(UIStoryboardSegue *)segue
{
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == m_txtName) {
        m_txtName.text = @"";
        if (toggleKeyboardIsOn) {
            
        } else {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 250.0), self.view.frame.size.width, self.view.frame.size.height);
            [UIView commitAnimations];
            toggleKeyboardIsOn = true;
        }
    } else if (textField == m_txtEmail) {
        m_txtEmail.text = @"";
        if (toggleKeyboardIsOn) {
            
        } else {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationBeginsFromCurrentState:YES];
            self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 250.0), self.view.frame.size.width, self.view.frame.size.height);
            [UIView commitAnimations];
            toggleKeyboardIsOn = true;
        }
    }
}



-(void)onKeyboardHide:(NSNotification *)notification
{
    //keyboard will hide
    if (toggleKeyboardIsOn) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y + 250.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        toggleKeyboardIsOn = false;
    }
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    
    m_txtName.textColor = [UIColor blackColor];
    m_txtEmail.textColor = [UIColor blackColor];
    
}


@end
