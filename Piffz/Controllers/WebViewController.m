//
//  WebViewController.m
//  Piffz
//
//  Created by AppsCreationTech on 4/16/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import "WebViewController.h"
#import "AppDelegate.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize m_webView, m_btnClose;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [m_btnClose.titleLabel setFont:m_fontHomeButton];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:Terms_URL]];
    
    if ([m_webviewMode isEqualToString:terms_mode]) {
        
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:Terms_URL]];
        
    } else if ([m_webviewMode isEqualToString:privacy_mode]) {
        
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:Privacy_URL]];
        
    }
    
    [m_webView loadRequest:request];
    
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

- (IBAction)onClickBtnSettings:(id)sender
{
    [self performSegueWithIdentifier:TO_BACK_SETTINGS sender:self];
}

@end
