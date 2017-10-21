//
//  StoryPartViewController.m
//  AVStorybook
//
//  Created by Aaron Johnson on 2017-10-20.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import "StoryPartViewController.h"
#import "DataModel.h"


@interface StoryPartViewController ()
@property bool recorderSetup;

@end

@implementation StoryPartViewController

- (IBAction)myImageViewTapped:(UITapGestureRecognizer *)sender {
    if (!_recorder.recording){
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.data.url error:nil];
        [_player setDelegate:self];
        [_player play];
    }
}
- (IBAction)myCameraButton:(UIButton *)sender {
    UIAlertController* alert;
    alert= [UIAlertController alertControllerWithTitle:@"Photo"
                                               message:@"Would you like to take a new photo or select an old one?"
                                        preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Camera"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action)
                      {
                          [self takePhoto];
                      }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Camera Roll"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action)
                      {
                          [self selectPhoto];
                      }]];
    
    [self presentViewController:alert animated:true completion:nil];
}
-(void)takePhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
-(void)selectPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)myMicrophoneButton:(id)sender {
    if (_player.playing) {
        [_player stop];
    }
    if (!_recorder.recording) {
        [self.myMicrophoneButton setTitle:@"Recording..." forState:UIControlStateNormal];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [_recorder record];
        
    } else {
        //stop recording
        [_recorder stop];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.data.image = chosenImage;
    self.myImageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    [self.myMicrophoneButton setTitle:@"Microphone" forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myImageView.image = self.data.image;
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt: kAudioFormatMPEG4AAC] forKey: AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat: 44100.0] forKey: AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey: AVNumberOfChannelsKey];
    // Initiate and prepare the recorder
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.data.url
                                            settings:recordSetting
                                               error:NULL];
    _recorder.delegate = self;
    _recorder.meteringEnabled = YES;
    //[_recorder prepareToRecord]; This overwrites the audio file to nothing which took me forever to find
}
@end
