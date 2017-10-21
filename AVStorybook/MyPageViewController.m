//
//  MyPageViewController.m
//  AVStorybook
//
//  Created by Aaron Johnson on 2017-10-20.
//  Copyright © 2017 Aaron Johnson. All rights reserved.
//

#import "MyPageViewController.h"
#import "DataModel.h"
#import "StoryPartViewController.h"

@interface MyPageViewController ()
@property NSArray *dataForVCs;
@property int index;
@end

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.dataSource = self;
    _dataForVCs = [[NSArray alloc] initWithObjects:[DataModel new],
              [DataModel new],
              [DataModel new],
              [DataModel new],
              [DataModel new], nil];
    for(int i = 0; i < self.dataForVCs.count; i++){
        NSString *name = [NSString stringWithFormat:@"myAudio%d.m4a", i];
        NSArray *path = [NSArray arrayWithObjects:
                         [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                          lastObject], name,  nil];
        
        [self.dataForVCs[i] setUrl:[NSURL fileURLWithPathComponents:path]];
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    StoryPartViewController *thisVC = [storyboard instantiateViewControllerWithIdentifier:@"StoryPartViewController"];
    thisVC.data = self.dataForVCs[0];
    [self setViewControllers:@[thisVC] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    StoryPartViewController *thisVC = [storyboard instantiateViewControllerWithIdentifier:@"StoryPartViewController"];
    self.index = (self.index + 4) % 5;
    thisVC.data = self.dataForVCs[self.index];
    return thisVC;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    StoryPartViewController *thisVC = [storyboard instantiateViewControllerWithIdentifier:@"StoryPartViewController"];
    self.index = (self.index + 1) % 5;
    thisVC.data = self.dataForVCs[self.index];
    return thisVC;
}

@end
