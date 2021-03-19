#import <UIKit/UIKit.h>
#import "MediaRemote.h"

@interface PGPlaybackProgressIndicator : UIView
@end

@interface PGPictureInPictureControlsViewController : UIViewController
-(void)_stopButtonTapped:(UIButton *)arg1;
-(void)_actionButtonTapped:(UIButton *)arg1;
-(void)_cancelButtonTapped:(UIButton *)arg1;
@end

@interface PiPViewController : UIViewController
@property (strong, nonatomic) UIButton *exitButton;
@property (strong, nonatomic) UIButton *returnToFullscreenButton;
@property (strong, nonatomic) UIView *transportControlsView;
@property (strong, nonatomic) UIButton *playPauseButton;
@property (strong, nonatomic) UIButton *leftSeekButton;
@property (strong, nonatomic) UIButton *rightSeekButton;
-(instancetype)initWithControlsViewController:(PGPictureInPictureControlsViewController *)controlsViewController;
@property (strong, nonatomic) PGPictureInPictureControlsViewController *controlsViewController;
@property (strong, nonatomic) UIView *gradientView;
@end


