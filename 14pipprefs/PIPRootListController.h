#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

//This is a very stripped down interface of NSTask
@interface NSTask : NSObject
@property (copy) NSString *launchPath;
- (void)launch;
@end

@interface PIPRootListController : PSListController

@end
