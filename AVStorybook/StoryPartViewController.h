//
//  StoryPartViewController.h
//  AVStorybook
//
//  Created by Aaron Johnson on 2017-10-20.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DataModel.h"

@interface StoryPartViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIImagePickerControllerDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *myMicrophoneButton;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UIButton *myCameraButton;
@property AVAudioPlayer *player;
@property AVAudioRecorder *recorder;
@property DataModel *data;
@end
