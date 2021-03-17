#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <RemoteLog.h>
#import "PiPViewController.h"

@interface PGPictureInPictureControlsViewController : UIViewController
-(void)_stopButtonTapped:(id)arg1;
-(void)_actionButtonTapped:(id)arg1;
-(void)_cancelButtonTapped:(id)arg1;
@end

@interface PGPlaybackProgressIndicator : UIView
@end

%hook PGPictureInPictureControlsViewController
-(void)_manageControlsSize {
    %orig;
    PGPlaybackProgressIndicator *progressIndicator = [self valueForKey:@"_playbackProgressIndicator"];

    progressIndicator.translatesAutoresizingMaskIntoConstraints = YES;
    progressIndicator.frame = CGRectMake(8, self.view.frame.size.height-7, self.view.frame.size.width-16, 4);

    progressIndicator.subviews[0].layer.cornerRadius = 2;

    PiPViewController *newControlsViewController = [[PiPViewController alloc] init];
    [self addChildViewController:newControlsViewController];
    [self.view addSubview:newControlsViewController.view];
    UIView *view = newControlsViewController.view;
    [view.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [view.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [view.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [view.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
}
%end



%hook PGPlaybackProgressIndicator
%end

%ctor {
    %init;
}
