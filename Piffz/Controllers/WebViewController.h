//
//  WebViewController.h
//  Piffz
//
//  Created by AppsCreationTech on 4/16/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import "ViewController.h"

@interface WebViewController : ViewController

@property (strong, nonatomic) IBOutlet UIWebView *m_webView;
@property (strong, nonatomic) IBOutlet UIButton *m_btnClose;

- (IBAction)onClickBtnSettings:(id)sender;

@end
