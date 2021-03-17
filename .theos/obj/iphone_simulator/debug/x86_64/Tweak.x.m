#line 1 "Tweak.x"
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


#include <objc/message.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

__attribute__((unused)) static void _logos_register_hook(Class _class, SEL _cmd, IMP _new, IMP *_old) {
unsigned int _count, _i;
Class _searchedClass = _class;
Method *_methods;
while (_searchedClass) {
_methods = class_copyMethodList(_searchedClass, &_count);
for (_i = 0; _i < _count; _i++) {
if (method_getName(_methods[_i]) == _cmd) {
if (_class == _searchedClass) {
*_old = method_getImplementation(_methods[_i]);
*_old = method_setImplementation(_methods[_i], _new);
} else {
class_addMethod(_class, _cmd, _new, method_getTypeEncoding(_methods[_i]));
}
free(_methods);
return;
}
}
free(_methods);
_searchedClass = class_getSuperclass(_searchedClass);
}
}
@class PGPlaybackProgressIndicator; @class PGPictureInPictureControlsViewController; 
static Class _logos_superclass$_ungrouped$PGPictureInPictureControlsViewController; static void (*_logos_orig$_ungrouped$PGPictureInPictureControlsViewController$_manageControlsSize)(_LOGOS_SELF_TYPE_NORMAL PGPictureInPictureControlsViewController* _LOGOS_SELF_CONST, SEL);

#line 15 "Tweak.x"

static void _logos_method$_ungrouped$PGPictureInPictureControlsViewController$_manageControlsSize(_LOGOS_SELF_TYPE_NORMAL PGPictureInPictureControlsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    (_logos_orig$_ungrouped$PGPictureInPictureControlsViewController$_manageControlsSize ? _logos_orig$_ungrouped$PGPictureInPictureControlsViewController$_manageControlsSize : (__typeof__(_logos_orig$_ungrouped$PGPictureInPictureControlsViewController$_manageControlsSize))class_getMethodImplementation(_logos_superclass$_ungrouped$PGPictureInPictureControlsViewController, @selector(_manageControlsSize)))(self, _cmd);
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







static __attribute__((constructor)) void _logosLocalCtor_0f530806(int __unused argc, char __unused **argv, char __unused **envp) {
    {Class _logos_class$_ungrouped$PGPictureInPictureControlsViewController = objc_getClass("PGPictureInPictureControlsViewController"); _logos_superclass$_ungrouped$PGPictureInPictureControlsViewController = class_getSuperclass(_logos_class$_ungrouped$PGPictureInPictureControlsViewController); { _logos_register_hook(_logos_class$_ungrouped$PGPictureInPictureControlsViewController, @selector(_manageControlsSize), (IMP)&_logos_method$_ungrouped$PGPictureInPictureControlsViewController$_manageControlsSize, (IMP *)&_logos_orig$_ungrouped$PGPictureInPictureControlsViewController$_manageControlsSize);}}
}
