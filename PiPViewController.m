#import "PiPViewController.h"
#include <RemoteLog.h>

@interface PiPViewController ()
@end


@implementation PiPViewController

-(instancetype)initWithControlsViewController:(PGPictureInPictureControlsViewController *)controlsViewController {
    self = [super init];
    if(self) {
        self.controlsViewController = controlsViewController;
        
        MRMediaRemoteRegisterForNowPlayingNotifications(dispatch_get_main_queue());    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isPlayingChanged) name:(__bridge NSString *)kMRMediaRemoteNowPlayingApplicationIsPlayingDidChangeNotification object:nil];        self.exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.exitButton setImage:[UIImage systemImageNamed:@"xmark"] forState:UIControlStateNormal];
        self.exitButton.tintColor = UIColor.whiteColor;
        self.exitButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.exitButton addTarget:controlsViewController action:@selector(_cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/14PiPPrefs.bundle"];
        self.returnToFullscreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.returnToFullscreenButton setImage:[UIImage imageNamed:@"pip.exit" inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        self.returnToFullscreenButton.tintColor = UIColor.whiteColor;
        self.returnToFullscreenButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.returnToFullscreenButton addTarget:controlsViewController action:@selector(_stopButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithScale:UIImageSymbolScaleLarge];
        
        self.leftSeekButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftSeekButton setImage:[UIImage systemImageNamed:@"gobackward.15" withConfiguration:configuration] forState:UIControlStateNormal];
        self.leftSeekButton.tintColor = UIColor.whiteColor;
        self.leftSeekButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.leftSeekButton addTarget:self action:@selector(goBack15:) forControlEvents:UIControlEventTouchUpInside];
        
        self.playPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        MRMediaRemoteGetNowPlayingApplicationIsPlaying(dispatch_get_main_queue(), ^(Boolean isPlaying){
            if(!isPlaying) {
                [self.playPauseButton setImage:[UIImage systemImageNamed:@"play.fill" withConfiguration:configuration] forState:UIControlStateNormal];
            }
            else {
                [self.playPauseButton setImage:[UIImage systemImageNamed:@"pause.fill" withConfiguration:configuration] forState:UIControlStateNormal];
            }
        });
        self.playPauseButton.tintColor = UIColor.whiteColor;
        self.playPauseButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.playPauseButton addTarget:controlsViewController action:@selector(_actionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

        self.rightSeekButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightSeekButton setImage:[UIImage systemImageNamed:@"goforward.15" withConfiguration:configuration] forState:UIControlStateNormal];
        self.rightSeekButton.tintColor = UIColor.whiteColor;
        self.rightSeekButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.rightSeekButton addTarget:self action:@selector(goForward15:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *containerView = [[UIView alloc] init];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.view = containerView;
    
    //Oh god this is awful. I literally copied how the properties were on iOS 14's PGGradientView's CAGradientLayer. There is most defintely a better way to do this, but hey this works. All the random decimals cause me physical pain
    self.gradientView = [[UIView alloc] init];
    CAGradientLayer *layer = [CAGradientLayer layer];
    CGColorRef color = UIColor.blackColor.CGColor;
    layer.colors = @[(__bridge id)CGColorCreateCopyWithAlpha(color, 0.00196), (__bridge id)CGColorCreateCopyWithAlpha(color, .00719), (__bridge id)CGColorCreateCopyWithAlpha(color, 0.0221), (__bridge id)CGColorCreateCopyWithAlpha(color, .0364), (__bridge id)CGColorCreateCopyWithAlpha(color, .0574), (__bridge id)CGColorCreateCopyWithAlpha(color, .0866), (__bridge id)CGColorCreateCopyWithAlpha(color, 0.125), (__bridge id)CGColorCreateCopyWithAlpha(color, 0.173), (__bridge id)CGColorCreateCopyWithAlpha(color, 0.229), (__bridge id)CGColorCreateCopyWithAlpha(color, 0.353), (__bridge id)CGColorCreateCopyWithAlpha(color, 0.411), (__bridge id)CGColorCreateCopyWithAlpha(color, 0.459), (__bridge id)CGColorCreateCopyWithAlpha(color, 0.476), (__bridge id)CGColorCreateCopyWithAlpha(color, 0.489), (__bridge id)CGColorCreateCopyWithAlpha(color, 0.497), (__bridge id)CGColorCreateCopyWithAlpha(color, 0.5)];
    layer.locations = @[@0, @0.125, @0.25, @0.3125, @0.375, @0.4375, @0.5, @0.5625, @0.625, @0.75, @0.8125, @0.875, @0.90625, @0.9735, @0.96875, @1];
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    layer.type = @"axial";
    [self.gradientView.layer addSublayer:layer];
    [self.view addSubview:self.gradientView];
    self.gradientView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.gradientView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.gradientView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [self.gradientView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.self.gradientView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;

    UIVisualEffectView *exitBlurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    exitBlurView.layer.cornerRadius = 6;
    exitBlurView.layer.cornerCurve = kCACornerCurveContinuous;
    exitBlurView.clipsToBounds = YES;
    exitBlurView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:exitBlurView];
    [self.view addSubview:self.exitButton];

    [self.exitButton.widthAnchor constraintEqualToConstant:32].active = YES;
    [self.exitButton.heightAnchor constraintEqualToConstant:25].active = YES;
    [self.exitButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:5].active = YES;
    [self.exitButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:5].active = YES;

    [exitBlurView.widthAnchor constraintEqualToAnchor:self.exitButton.widthAnchor].active = YES;
    [exitBlurView.heightAnchor constraintEqualToAnchor:self.exitButton.heightAnchor].active = YES;
    [exitBlurView.leadingAnchor constraintEqualToAnchor:self.exitButton.leadingAnchor].active = YES;
    [exitBlurView.topAnchor constraintEqualToAnchor:self.exitButton.topAnchor].active = YES;

    
    UIVisualEffectView *returnToFullscreenBlurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    returnToFullscreenBlurView.frame = self.returnToFullscreenButton.frame;
    returnToFullscreenBlurView.layer.cornerRadius = 6;
    returnToFullscreenBlurView.layer.cornerCurve = kCACornerCurveContinuous;
    returnToFullscreenBlurView.clipsToBounds = YES;
    returnToFullscreenBlurView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:returnToFullscreenBlurView];
    [self.view addSubview:self.returnToFullscreenButton];
    [self.returnToFullscreenButton.widthAnchor constraintEqualToConstant:32].active = YES;
    [self.returnToFullscreenButton.heightAnchor constraintEqualToConstant:25].active = YES;
    [self.returnToFullscreenButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-5].active = YES;
    [self.returnToFullscreenButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:5].active = YES;
    
    [returnToFullscreenBlurView.widthAnchor constraintEqualToAnchor:self.returnToFullscreenButton.widthAnchor].active = YES;
    [returnToFullscreenBlurView.heightAnchor constraintEqualToAnchor:self.returnToFullscreenButton.heightAnchor].active = YES;
    [returnToFullscreenBlurView.leadingAnchor constraintEqualToAnchor:self.returnToFullscreenButton.leadingAnchor].active = YES;
    [returnToFullscreenBlurView.topAnchor constraintEqualToAnchor:self.returnToFullscreenButton.topAnchor].active = YES;
        
    self.transportControlsView = [[UIView alloc] init];
    self.transportControlsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.transportControlsView];
    
    [self.transportControlsView addSubview:self.leftSeekButton];
    [self.transportControlsView addSubview:self.playPauseButton];
    [self.transportControlsView addSubview:self.rightSeekButton];

    [self.transportControlsView.widthAnchor constraintEqualToConstant:192].active = YES;
    [self.transportControlsView.heightAnchor constraintEqualToConstant:48].active = YES;
    [self.transportControlsView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.transportControlsView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-55].active = YES;
    
    [self.leftSeekButton.widthAnchor constraintEqualToConstant:48].active = YES;
    [self.leftSeekButton.heightAnchor constraintEqualToConstant:48].active = YES;
    [self.leftSeekButton.leadingAnchor constraintEqualToAnchor:self.transportControlsView.leadingAnchor].active = YES;
    
    [self.playPauseButton.widthAnchor constraintEqualToConstant:48].active = YES;
    [self.playPauseButton.heightAnchor constraintEqualToConstant:48].active = YES;
    [self.playPauseButton.leadingAnchor constraintEqualToAnchor:self.leftSeekButton.trailingAnchor constant:24].active = YES;
    
    [self.rightSeekButton.widthAnchor constraintEqualToConstant:48].active = YES;
    [self.rightSeekButton.heightAnchor constraintEqualToConstant:48].active = YES;
    [self.rightSeekButton.leadingAnchor constraintEqualToAnchor:self.playPauseButton.trailingAnchor constant:24].active = YES;
    
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.gradientView.layer.sublayers[0].frame = self.gradientView.bounds;
}

-(void)goBack15:(UIButton *)sender {
    MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
        NSDictionary *info = (__bridge NSDictionary*)information;
        CGFloat duration = [info[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoDuration] floatValue];
        PGPlaybackProgressIndicator *progressIndicator = [self.controlsViewController valueForKey:@"_playbackProgressIndicator"];
        CGFloat progressPercentage = [[progressIndicator valueForKey:@"_currentProgress"] floatValue];
        CGFloat currentVideoTime = duration * progressPercentage;
        MRMediaRemoteSetElapsedTime(currentVideoTime - 15);
    });
}
-(void)goForward15:(UIButton *)sender {
    MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
        NSDictionary *info = (__bridge NSDictionary*)information;
        CGFloat duration = [info[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoDuration] floatValue];
        PGPlaybackProgressIndicator *progressIndicator = [self.controlsViewController valueForKey:@"_playbackProgressIndicator"];
        CGFloat progressPercentage = [[progressIndicator valueForKey:@"_currentProgress"] floatValue];
        CGFloat currentVideoTime = duration * progressPercentage;
        MRMediaRemoteSetElapsedTime(currentVideoTime + 15);
    });
}
-(void)isPlayingChanged {
    MRMediaRemoteGetNowPlayingApplicationIsPlaying(dispatch_get_main_queue(), ^(Boolean isPlaying){
        UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithScale:UIImageSymbolScaleLarge];
        if(!isPlaying) {
            [self.playPauseButton setImage:[UIImage systemImageNamed:@"play.fill" withConfiguration:configuration] forState:UIControlStateNormal];
        }
        else {
            [self.playPauseButton setImage:[UIImage systemImageNamed:@"pause.fill" withConfiguration:configuration] forState:UIControlStateNormal];
        }
    });
}
@end

