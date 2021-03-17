#import "PiPViewController.h"

@interface PiPViewController ()
@end

@implementation PiPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 470, 263)];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.view = containerView;
    
    self.exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.exitButton setImage:[UIImage systemImageNamed:@"xmark"] forState:UIControlStateNormal];
    self.exitButton.tintColor = UIColor.whiteColor;
    self.exitButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.returnToFullscreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.returnToFullscreenButton setImage:[UIImage imageNamed:@"pip.exit"] forState:UIControlStateNormal];
    self.returnToFullscreenButton.tintColor = UIColor.whiteColor;
    self.returnToFullscreenButton.translatesAutoresizingMaskIntoConstraints = NO;
    

    UIVisualEffectView *exitBlurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    exitBlurView.layer.cornerRadius = 6;
    exitBlurView.layer.cornerCurve = kCACornerCurveContinuous;
    exitBlurView.clipsToBounds = YES;
    exitBlurView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [containerView addSubview:exitBlurView];
    [containerView addSubview:self.exitButton];

    [self.exitButton.widthAnchor constraintEqualToConstant:32].active = YES;
    [self.exitButton.heightAnchor constraintEqualToConstant:25].active = YES;
    [self.exitButton.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor constant:5].active = YES;
    [self.exitButton.topAnchor constraintEqualToAnchor:containerView.topAnchor constant:5].active = YES;

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
    
    [containerView addSubview:returnToFullscreenBlurView];
    [containerView addSubview:self.returnToFullscreenButton];
    [self.returnToFullscreenButton.widthAnchor constraintEqualToConstant:32].active = YES;
    [self.returnToFullscreenButton.heightAnchor constraintEqualToConstant:25].active = YES;
    [self.returnToFullscreenButton.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor constant:-5].active = YES;
    [self.returnToFullscreenButton.topAnchor constraintEqualToAnchor:containerView.topAnchor constant:5].active = YES;
    
    [returnToFullscreenBlurView.widthAnchor constraintEqualToAnchor:self.returnToFullscreenButton.widthAnchor].active = YES;
    [returnToFullscreenBlurView.heightAnchor constraintEqualToAnchor:self.returnToFullscreenButton.heightAnchor].active = YES;
    [returnToFullscreenBlurView.leadingAnchor constraintEqualToAnchor:self.returnToFullscreenButton.leadingAnchor].active = YES;
    [returnToFullscreenBlurView.topAnchor constraintEqualToAnchor:self.returnToFullscreenButton.topAnchor].active = YES;
    
    /*
    UIView *gradientView = [[UIView alloc] initWithFrame:containerView.frame];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = @[(id)UIColor.clearColor.CGColor, (id)UIColor.clearColor.CGColor, (id)UIColor.clearColor.CGColor, (id)UIColor.clearColor.CGColor, (id)UIColor.clearColor.CGColor, (id)UIColor.clearColor.CGColor, (id)UIColor.clearColor.CGColor, (id)UIColor.blackColor.CGColor, (id)UIColor.blackColor.CGColor, (id)UIColor.blackColor.CGColor, (id)UIColor.blackColor.CGColor, (id)UIColor.blackColor.CGColor, (id)UIColor.blackColor.CGColor];
    layer.locations = @[@0, @0.125, @0.25, @0.3125, @0.375, @0.4375, @0.5, @0.5625, @0.625, @0.75, @0.8125, @0.875, @0.90625, @0.9735, @0.96875, @1];
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    layer.type = @"axial";
    layer.frame = gradientView.bounds;
    [gradientView.layer addSublayer:layer];
    [containerView addSubview:gradientView];*/
        
    self.transportControlsView = [[UIView alloc] init];
    self.transportControlsView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:self.transportControlsView];
    
    UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithScale:UIImageSymbolScaleLarge];
    
    self.leftSeekButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftSeekButton setImage:[UIImage systemImageNamed:@"gobackward.15" withConfiguration:configuration] forState:UIControlStateNormal];
    self.leftSeekButton.tintColor = UIColor.whiteColor;
    self.leftSeekButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.transportControlsView addSubview:self.leftSeekButton];
    
    self.playPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playPauseButton setImage:[UIImage systemImageNamed:@"play.fill" withConfiguration:configuration] forState:UIControlStateNormal];
    self.playPauseButton.tintColor = UIColor.whiteColor;
    self.playPauseButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.transportControlsView addSubview:self.playPauseButton];
    
    self.rightSeekButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightSeekButton setImage:[UIImage systemImageNamed:@"goforward.15" withConfiguration:configuration] forState:UIControlStateNormal];
    self.rightSeekButton.tintColor = UIColor.whiteColor;
    self.rightSeekButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.transportControlsView addSubview:self.rightSeekButton];
    
    [self.transportControlsView.widthAnchor constraintEqualToConstant:192].active = YES;
    [self.transportControlsView.heightAnchor constraintEqualToConstant:48].active = YES;
    [self.transportControlsView.centerXAnchor constraintEqualToAnchor:containerView.centerXAnchor].active = YES;
    [self.transportControlsView.topAnchor constraintEqualToAnchor:containerView.bottomAnchor constant:-55].active = YES;
    
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


@end

