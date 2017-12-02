//
//  AppDelegate.m
//  Piffz
//
//  Created by AppsCreationTech on 4/4/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import "AppDelegate.h"

NSString *m_bookpageMode;
UIFont *m_fontHomeMenu;
UIFont *m_fontTitle;
UIFont *m_fontDialogMenu;
UIFont *m_fontHelp;
UIFont *m_fontSubscribe;
UIFont *m_fontHomeButton;
NSString *m_webviewMode;

NSMutableArray* moreBooksArray;

BOOL showPageIsOn;
BOOL saveRecordingsIsOn;
BOOL useRecordingsIsOn;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    m_bookpageMode = [[NSString alloc] init];
    m_bookpageMode = read_to_me;
    
    m_fontHomeMenu = [UIFont fontWithName:font_Schoolbell size:font_size_home_menu];
    m_fontTitle = [UIFont fontWithName:font_Schoolbell size:font_size_title];
    m_fontDialogMenu = [UIFont fontWithName:font_Schoolbell size:font_size_dialog_menu];
    m_fontHelp = [UIFont fontWithName:font_Schoolbell size:font_size_help];
    m_fontSubscribe = [UIFont fontWithName:font_Schoolbell size:font_size_subscribe];
    m_fontHomeButton = [UIFont fontWithName:font_Schoolbell size:font_size_home_button];
    
    m_webviewMode = terms_mode;
    
    showPageIsOn = true;
    saveRecordingsIsOn = true;
    useRecordingsIsOn = false;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    if (!saveRecordingsIsOn) {
        NSArray* recordFile = [[NSArray alloc] initWithObjects:
                               @"record_001.m4a",
                               @"record_002.m4a",
                               @"record_003.m4a",
                               @"record_004.m4a",
                               @"record_005.m4a",
                               @"record_006.m4a",
                               @"record_007.m4a",
                               @"record_008.m4a",
                               @"record_009.m4a",
                               @"record_010.m4a",
                               nil];
        
        for (int i = 0; i < [recordFile count]; i++) {
            [self removeAllRecords:recordFile[i]];
        }
    }
}

- (void)removeAllRecords:(NSString *)fileName
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


@end
