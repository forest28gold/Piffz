//
//  DataViewController.h
//  BookTest
//
//  Created by AppsCreationTech on 12/24/11.
//  Copyright (c) 2011 AppsCreationTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>

@interface DataViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (strong, nonatomic) IBOutlet UITextView *pageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *pagePicture;

@property (strong, nonatomic) IBOutlet UIButton *m_btnHome;
@property (strong, nonatomic) IBOutlet UIButton *m_btnRecord;
@property (strong, nonatomic) IBOutlet UIButton *m_btnPlay;

@property (strong, nonatomic) IBOutlet UIView *m_viewRecording;
@property (strong, nonatomic) IBOutlet UILabel *m_lblRecordings;
@property (strong, nonatomic) IBOutlet UIButton *m_btnRecordMyself;
@property (strong, nonatomic) IBOutlet UIButton *m_btnDeleteMyRecording;
@property (strong, nonatomic) IBOutlet UIButton *m_btnUseMyRecording;
@property (strong, nonatomic) IBOutlet UIButton *m_btnClose;

@property (strong, nonatomic) IBOutlet UIView *m_viewProgress;
@property (strong, nonatomic) IBOutlet UIProgressView *m_progressView;
@property (strong, nonatomic) IBOutlet UILabel *m_lblSecond;
@property (strong, nonatomic) IBOutlet UIButton *m_btnRecording;

@property (strong, nonatomic) id dataLabel;
@property (strong, nonatomic) id dataNumber;
@property (strong, nonatomic) id dataImage;
@property (strong, nonatomic) id dataSound;
@property (strong, nonatomic) id dataRecord;

@property (nonatomic, retain) AVAudioPlayer *player;

@property (nonatomic, strong) AVAudioRecorder *voiceRecorder;
@property (nonatomic, strong) AVAudioSession *voiceSession;

@property NSMutableAttributedString *pageString;

-(void)showHighlight;

- (IBAction)onClickBtnHome:(id)sender;
- (IBAction)onClickBtnRecord:(id)sender;
- (IBAction)onClickBtnPlay:(id)sender;

- (IBAction)onClickBtnRecordMyself:(id)sender;
- (IBAction)onClickBtnDeleteMyRecording:(id)sender;
- (IBAction)onClickBtnUseMyRecording:(id)sender;
- (IBAction)onClickBtnClose:(id)sender;

- (IBAction)onClickBtnRecording:(id)sender;

@end
