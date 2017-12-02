//
//  DataViewController.m
//  BabyGoesToBeddy
//
//  Created by AppsCreationTech on 4/10/13.
//  Copyright (c) 2013 AppsCreationTech. All rights reserved.
//

#import "DataViewController.h"
#import "AppDelegate.h"
#import "WordModel.h"

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]


@interface DataViewController () 
{
    NSTimer* timer;
    BOOL toggleRecordingIsOn;
    double _ticks;
    BOOL recordedVoiceIsOn;
    BOOL togglePlayIsOn;
    
    NSMutableArray *timeArray;
    NSMutableArray *wordArray;
}

@end

@implementation DataViewController

@synthesize player, pagePicture, pageLabel;
@synthesize pageString;

@synthesize m_btnHome, m_btnRecord, m_btnPlay;

@synthesize m_viewRecording, m_lblRecordings;
@synthesize m_btnRecordMyself, m_btnDeleteMyRecording, m_btnUseMyRecording, m_btnClose;
@synthesize m_viewProgress;
@synthesize m_btnRecording, m_lblSecond, m_progressView;

@synthesize voiceSession, voiceRecorder;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    toggleRecordingIsOn = true;
    recordedVoiceIsOn = false;
    
    _ticks = 0.0;
    
    voiceSession = [AVAudioSession sharedInstance];
    
    if (useRecordingsIsOn) {
        [m_btnUseMyRecording setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    } else {
        [m_btnUseMyRecording setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
    
    m_lblRecordings.font = m_fontTitle;
    
    [m_btnRecordMyself.titleLabel setFont:m_fontDialogMenu];
    [m_btnDeleteMyRecording.titleLabel setFont:m_fontDialogMenu];
    [m_btnUseMyRecording.titleLabel setFont:m_fontDialogMenu];
    
    
    m_viewRecording.layer.cornerRadius = 15;
    m_viewRecording.layer.shadowOpacity = 0.5;
    m_viewRecording.layer.shadowRadius = 5.0f;
    m_viewRecording.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    
    if (toggleRecordingIsOn) {
        [m_btnRecording setImage:[UIImage imageNamed:@"recording.png"] forState:UIControlStateNormal];
    } else {
        [m_btnRecording setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
    }
    
    m_progressView.progress = 0.0;
    [m_progressView setTransform:CGAffineTransformMakeScale(1.0, 4.0)];
    [[m_progressView layer]setCornerRadius:8.0f];
    [[m_progressView layer]setMasksToBounds:TRUE];
    m_progressView.clipsToBounds = YES;
    
    if ([m_bookpageMode isEqualToString:read_to_me]) {
        
        togglePlayIsOn = true;
        
        m_viewRecording.hidden = YES;
        m_viewProgress.hidden = YES;
        
        m_btnPlay.enabled = YES;
        m_btnRecord.enabled = YES;
        
        [m_btnPlay setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
        
    } else if ([m_bookpageMode isEqualToString:read_myself]) {
        
        togglePlayIsOn = false;
        
        m_viewRecording.hidden = YES;
        m_viewProgress.hidden = YES;
        
        m_btnPlay.enabled = YES;
        m_btnRecord.enabled = YES;
        
    } else if ([m_bookpageMode isEqualToString:read_help]) {
        
        togglePlayIsOn = false;
        
        m_viewRecording.hidden = YES;
        m_viewProgress.hidden = YES;
        
        m_btnPlay.enabled = YES;
        m_btnRecord.enabled = YES;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self stopReadPlay];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([m_bookpageMode isEqualToString:read_to_me]) {
        
        togglePlayIsOn = true;
        
        m_viewRecording.hidden = YES;
        m_viewProgress.hidden = YES;
        
        m_btnPlay.enabled = YES;
        m_btnRecord.enabled = YES;
        
        [m_btnPlay setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
        
    } else {
        
        togglePlayIsOn = false;
        [m_btnPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
    
    timeArray = [[NSMutableArray alloc] init];
    wordArray = [[NSMutableArray alloc] init];
    
    self.pageLabel.text = [self.dataLabel description];
    self.pageLabel.font = m_fontHomeMenu;
    self.pagePicture.image = _dataImage;
    
    [self readWord:self.pageLabel pageNumber:[self.dataNumber intValue]];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageWordTapped:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.pageLabel addGestureRecognizer:gestureRecognizer];
    
    [self showReadToMe];

}

- (void)showReadToMe
{
    // Page Read...
    
    if (!showPageIsOn && [m_bookpageMode isEqualToString:read_to_me]) {
        self.pageLabel.hidden = YES;
        
        NSError *error;
        NSURL *backgroundMusicURL = _dataSound;
        
        NSString* recordedFilePath = [NSString stringWithFormat:@"%@/%@.m4a", DOCUMENTS_FOLDER, self.dataRecord];
        backgroundMusicURL = [NSURL fileURLWithPath:recordedFilePath];
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:recordedFilePath];
        
        if (fileExists) {
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
            [player prepareToPlay];
            [player play];
            
            player.delegate = self;
        } else {
            
            [m_btnPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
            return;
        }
        
    } else if (showPageIsOn && [m_bookpageMode isEqualToString:read_to_me]) {
        
        if (useRecordingsIsOn) {
            NSError *error;
            NSURL *backgroundMusicURL = _dataSound;
            
            NSString* recordedFilePath = [NSString stringWithFormat:@"%@/%@.m4a", DOCUMENTS_FOLDER, self.dataRecord];
            backgroundMusicURL = [NSURL fileURLWithPath:recordedFilePath];
            
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:recordedFilePath];
            
            if (fileExists) {
                player = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
                [player prepareToPlay];
                [player play];
                
                player.delegate = self;
            } else {
                
                [m_btnPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
                return;
            }
        } else {
            [self showHighlight];
        }
        
    }
}

- (void)showHighlight
{
    NSError *error;
    NSURL *backgroundMusicURL = _dataSound;
    
    if (useRecordingsIsOn) {
        NSString* recorderFilePath = [NSString stringWithFormat:@"%@/%@.m4a", DOCUMENTS_FOLDER, self.dataRecord];
        backgroundMusicURL = [NSURL fileURLWithPath:recorderFilePath];
    }
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    [player prepareToPlay];
    [player play];
    
    player.delegate = self;
    
    [self readToMe:self.pageLabel pageNumber:[self.dataNumber intValue]];

}

- (void)stopReadPlay
{
    [player stop];
    
    if (timeArray.count != 0) {
        for (int i = 0; i < timeArray.count; i ++) {
            
            [timeArray[i] invalidate];
        }
    }
}


- (void) pageWordTapped:(UITapGestureRecognizer *)recognizer{
    
    UITextView *textView =  (UITextView *)recognizer.view;
    
    CGPoint location = [recognizer locationInView:textView];
//    NSLog(@"Tap Gesture Coordinates: %.2f %.2f -- %@", location.x, location.y,textView.text);
    
    CGPoint position = CGPointMake(location.x, location.y);
    
    //get location in text from textposition at point
    UITextPosition *tapPosition = [textView closestPositionToPoint:position];
    
    //fetch the word at this position (or nil, if not available)
    UITextRange *textRange = [textView.tokenizer rangeEnclosingPosition:tapPosition withGranularity:UITextGranularityWord inDirection:UITextLayoutDirectionRight];
    
    NSString *tappedSentence = [textView textInRange:textRange];
    NSLog(@"selected :%@ -- %@",tappedSentence,tapPosition);
    
    if (!togglePlayIsOn) {
     
        for (int i = 0; i < wordArray.count; i ++) {
            
            WordModel *wordModel = wordArray[i];
            
            if ((wordModel.word.length - tappedSentence.length) < 3 && [wordModel.word containsString:tappedSentence]) {
                
                double timeInterval = [wordModel.endTime doubleValue] - [wordModel.startTime doubleValue];
                NSTimeInterval intervalForTimer = timeInterval;
                
                NSLog(@"timeInterval :%@,   %@,   %f", wordModel.startTime, wordModel.endTime, intervalForTimer);
                
                [NSTimer scheduledTimerWithTimeInterval:0.0
                                                 target:self
                                               selector:@selector(highlightWord:)
                                               userInfo:@{@"rangeLocation": wordModel.rangeLocation, @"rangeLength": wordModel.rangeLength}
                                                repeats:NO];
                
                [NSTimer scheduledTimerWithTimeInterval:intervalForTimer
                                                 target:self
                                               selector:@selector(unHighlightEndOfText:)
                                               userInfo:@{@"wordLength": [NSNumber numberWithInt:1]}
                                                repeats:NO];
                
                [self playWord:[wordModel.startTime doubleValue] endTime:[wordModel.endTime doubleValue]];
                
                return;
                
            }
            
        }
        
    }
    
}

- (void)playWord:(double)wordStartsAt endTime:(double)wordEndsAt
{
    NSError *error;
    NSURL *backgroundMusicURL = _dataSound;
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    
    if (player) {
        [player setCurrentTime:wordStartsAt];
        [player prepareToPlay];
        [player play];
        [NSTimer scheduledTimerWithTimeInterval:wordEndsAt-wordStartsAt target:self selector:@selector(stopWord) userInfo:nil repeats:NO];
        
    }
}

- (void)stopWord
{
    [player pause];
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
    m_viewRecording.transform = CGAffineTransformMakeScale(1.3, 1.3);
    m_viewRecording.alpha = 0;
    [UIView animateWithDuration:.15 animations:^{
        m_viewRecording.alpha = 1;
        m_viewRecording.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.15 animations:^{
        m_viewRecording.transform = CGAffineTransformMakeScale(1.3, 1.3);
        m_viewRecording.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            m_viewRecording.hidden = YES;
        }
    }];
}

- (IBAction)onClickBtnHome:(id)sender
{
    [self performSegueWithIdentifier:TO_BACK_HOME sender:self];
}

- (IBAction)onClickBtnRecord:(id)sender
{
    [self stopReadPlay];
    
    togglePlayIsOn = false;
    [m_btnPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];

    [self showInView:m_viewRecording animated:YES];
}

- (IBAction)onClickBtnPlay:(id)sender
{
    if(togglePlayIsOn){
        //do anything else you want to do.
        
        [self stopReadPlay];
        
    } else {
        //do anything you want to do.
        
        if (useRecordingsIsOn) {
            
            NSError *error;
            NSURL *backgroundMusicURL = _dataSound;
            
            NSString* recordedFilePath = [NSString stringWithFormat:@"%@/%@.m4a", DOCUMENTS_FOLDER, self.dataRecord];
            backgroundMusicURL = [NSURL fileURLWithPath:recordedFilePath];

            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:recordedFilePath];
            
            if (fileExists) {
                player = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
                [player prepareToPlay];
                [player play];
                
                player.delegate = self;
            } else {
                
                [m_btnPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
                return;
            }
            
        } else {
            
            [self showHighlight];
            
        }
        
    }
    togglePlayIsOn = !togglePlayIsOn;
    [m_btnPlay setImage:[UIImage imageNamed:togglePlayIsOn ? @"stop.png" : @"play.png"] forState:UIControlStateNormal];

}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        togglePlayIsOn = false;
        [m_btnPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)onClickBtnRecordMyself:(id)sender
{
    [self removeAnimate];
    
    m_viewProgress.hidden = NO;
    m_btnPlay.enabled = NO;
    m_btnRecord.enabled = NO;
    m_btnHome.enabled = NO;

}

- (IBAction)onClickBtnDeleteMyRecording:(id)sender
{
    [self removeAnimate];
    
    NSString* recorderFileName = [NSString stringWithFormat:@"%@.m4a", self.dataRecord];
    [self removeRecord:recorderFileName];
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

- (IBAction)onClickBtnUseMyRecording:(id)sender
{
    if(useRecordingsIsOn){
        //do anything else you want to do.
        
    } else {
        //do anything you want to do.
        
    }
    useRecordingsIsOn = !useRecordingsIsOn;
    [m_btnUseMyRecording setImage:[UIImage imageNamed:useRecordingsIsOn ? @"checked.png" : @"unchecked.png"] forState:UIControlStateNormal];
}

- (IBAction)onClickBtnClose:(id)sender
{
    [self removeAnimate];
    
}

- (IBAction)onClickBtnRecording:(id)sender
{
    // My Recording...
    
    if(toggleRecordingIsOn){
        //do anything else you want to do.
        
        // Set the audio file
        // make file path & start recording
        NSString* recorderFilePath = [NSString stringWithFormat:@"%@/%@.m4a", DOCUMENTS_FOLDER, self.dataRecord];
        NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
        
        // Setup audio session
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
        // Define the recorder setting
        NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
        
        [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        
        // Initiate and prepare the recorder
        voiceRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:NULL];
        voiceRecorder.delegate = self;
        voiceRecorder.meteringEnabled = YES;
        [voiceRecorder prepareToRecord];
        
        [session setActive:YES error:nil];
        
        [voiceRecorder record];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
        
    } else {
        //do anything you want to do.
        
        recordedVoiceIsOn = true;
        
        if (voiceRecorder != nil && voiceRecorder.isRecording) {
            [voiceRecorder stop];
            
//            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//            [audioSession setActive:NO error:nil];
            
        }
        [timer invalidate];
        
        [UIView animateWithDuration:.25 animations:^{
            m_viewProgress.transform = CGAffineTransformMakeScale(1.3, 1.3);
            m_viewProgress.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                m_viewProgress.hidden = YES;
            }
        }];
        
        m_btnHome.enabled = YES;
        m_btnPlay.enabled = YES;
        m_btnRecord.enabled = YES;
        
    }
    toggleRecordingIsOn = !toggleRecordingIsOn;
    [m_btnRecording setImage:[UIImage imageNamed:toggleRecordingIsOn ? @"recording.png" : @"stop.png"] forState:UIControlStateNormal];
    
}

- (void) handleTimer
{
    _ticks += 0.1;
    double seconds = fmod(_ticks, 60.0);
    self.m_lblSecond.text = [NSString stringWithFormat:@"%02d", (int)seconds];
    
    m_progressView.progress += .0033;
    if(m_progressView.progress == 1.0)
    {
        [timer invalidate];
        _ticks = 0.0;
        
        m_btnPlay.enabled = YES;
        m_btnRecord.enabled = YES;
        m_btnHome.enabled = YES;
        
        [m_btnRecording setImage:[UIImage imageNamed:@"recording.png"] forState:UIControlStateNormal];
        m_progressView.progress = 0.0;
        self.m_lblSecond.text = @"30";
        
        if (voiceRecorder != nil && voiceRecorder.isRecording) {
            [voiceRecorder stop];
            voiceRecorder = nil;
        }
        
        recordedVoiceIsOn = true;
        
    }
}


#pragma mark - Read to me methods


// Highlights words on the page as they are read by the narrator
- (void)readWord:(UITextView *)textView pageNumber:(NSUInteger)pageNumber
{
    
    // Parses the text in the textView into an array of words
    NSArray *wordList = [textView.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSArray *times = [self getReadToMeWordTimesForPageNumber:pageNumber Index:0];
    
    NSArray *endtimes = [self getReadToMeWordTimesForPageNumber:pageNumber Index:1];
    
    int indexToStartAt = 0; // an int that keeps track of the index in the textView's text where each word starts
    
    for (int i = 0; i < [wordList count]; i++) {
        
        WordModel *wordModel = [[WordModel alloc] init];
        
        NSString *word = wordList[i];
        if ([word length] > 0) {
            
            // The range of the word in the textView's text
            NSRange range = NSMakeRange(indexToStartAt, [word length]);
            NSString *rangeLength = [NSString stringWithFormat:@"%d",range.length];
            NSString *rangeLocation = [NSString stringWithFormat:@"%d",range.location];
            
            indexToStartAt += [word length] + 1;
            
            wordModel.word = word;
            wordModel.rangeLength = rangeLength;
            wordModel.rangeLocation = rangeLocation;
            wordModel.startTime = times[i];
            wordModel.endTime = endtimes[i];
            
            [wordArray addObject:wordModel];
        }
    }
    
}



// Highlights words on the page as they are read by the narrator
- (void)readToMe:(UITextView *)textView pageNumber:(NSUInteger)pageNumber
{
    
    // Parses the text in the textView into an array of words
    NSArray *wordList = [textView.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Get an array of times (floats) used for timing when words are highlighted
    NSArray *times = [self getReadToMeWordTimesForPageNumber:pageNumber Index:0];
    
    int indexToStartAt = 0; // an int that keeps track of the index in the textView's text where each word starts
    
    for (int i = 0; i < [wordList count]; i++) {
        
        NSString *word = wordList[i];
        if ([word length] > 0) {
            
            // The range of the word in the textView's text
            NSRange range = NSMakeRange(indexToStartAt, [word length]);
            NSString *rangeLength = [NSString stringWithFormat:@"%d",range.length];
            NSString *rangeLocation = [NSString stringWithFormat:@"%d",range.location];
            
            // A timer to highlight each word at the appropriate time (when it is read by the narrator)
            NSTimer *timerWord = [NSTimer scheduledTimerWithTimeInterval:[times[i] doubleValue]
                                             target:self
                                           selector:@selector(highlightWord:)
                                           userInfo:@{@"rangeLocation": rangeLocation, @"rangeLength": rangeLength}
                                            repeats:NO];
            
            indexToStartAt += [word length] + 1;
            
            [timeArray addObject:timerWord];
        }
    }
    [self unHighlightLastWord:wordList withDelay:([[times lastObject] doubleValue] + 0.5)];
    
    pageLabel.font = m_fontHomeMenu;
    
}

// Parses the appropriate .txt file based on page number to return an array of times (floats) used for timing when words are highlighted
- (NSArray *)getReadToMeWordTimesForPageNumber:(NSUInteger)pageNumber Index:(NSInteger)index
{
    // Parses the file into individual lines
    NSString *filepath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"page_%d_time",pageNumber] ofType:@"txt"];
    NSString *fileText = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:NULL];
    NSArray *lines = [fileText componentsSeparatedByString:@"\n"];
    
    // Gets the first number on each line, which is the start time of each word
    NSMutableArray *times = [[NSMutableArray alloc] init];
    for (NSString *line in lines) {
        NSArray *words = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [times addObject:words[index]];
    }
    return times;
}

// Highlights a range of characters in the textView - the range is passed in through the userInfo dictionary of a timer
- (void)highlightWord:(NSTimer *)timer
{
    NSRange range = NSMakeRange([timer.userInfo[@"rangeLocation"] intValue], [timer.userInfo[@"rangeLength"] intValue]);
    NSMutableAttributedString *mutableText = [[NSMutableAttributedString alloc] initWithString:self.pageLabel.text];
    [mutableText addAttributes:@{NSBackgroundColorAttributeName: [UIColor greenColor]} range:range];
    
    [self.pageLabel setAttributedText:mutableText];
    pageLabel.font = m_fontHomeMenu;
}

// Unhighlights the last word in the textView after a specified time delay
- (void)unHighlightLastWord:(NSArray *)wordList withDelay:(NSTimeInterval)delay
{
    NSString *lastWord = [wordList lastObject];
    
    [NSTimer scheduledTimerWithTimeInterval:delay
                                     target:self
                                   selector:@selector(unHighlightEndOfText:)
                                   userInfo:@{@"wordLength": [NSNumber numberWithInt:[lastWord length]]}
                                    repeats:NO];
}

// Unhighlights the last word in the textView - length of the last word in the textView is passed in through the userInfo of a timer
- (void)unHighlightEndOfText:(NSTimer *)timer
{
    NSDictionary *userInfo = [timer userInfo];
    int wordLength = [userInfo[@"wordLength"] intValue];
    
    // finds the range by backtracking from the end of the textViews' text
    NSRange range = NSMakeRange([self.pageLabel.text length] - wordLength, wordLength);
    
    NSMutableAttributedString *mutableText = [[NSMutableAttributedString alloc] initWithString:self.pageLabel.text];
    [mutableText addAttributes:@{NSBackgroundColorAttributeName: [UIColor clearColor]} range:range];
    [self.pageLabel setAttributedText:mutableText];
    
    pageLabel.font = m_fontHomeMenu;
}


@end
