//
//  AppDelegate.h
//  Piffz
//
//  Created by AppsCreationTech on 4/4/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)removeAllRecords:(NSString *)fileName;

@end

extern NSString *m_bookpageMode;
extern UIFont *m_fontHomeMenu;
extern UIFont *m_fontTitle;
extern UIFont *m_fontDialogMenu;
extern UIFont *m_fontHelp;
extern UIFont *m_fontSubscribe;
extern UIFont *m_fontHomeButton;
extern NSString *m_webviewMode;

extern NSMutableArray* moreBooksArray;

extern BOOL showPageIsOn;
extern BOOL saveRecordingsIsOn;
extern BOOL useRecordingsIsOn;
