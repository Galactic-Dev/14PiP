#import <UIKit/UIKit.h>
#include "PIPRootListController.h"
#include <RemoteLog.h>

@implementation PIPRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
    [super setPreferenceValue:value specifier:specifier];
    NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
    [settings setObject:value forKey:specifier.properties[@"key"]];
    [settings writeToFile:path atomically:YES];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStyleDone target:self action:@selector(respring)];
    self.navigationItem.rightBarButtonItem.tintColor = UIColor.systemRedColor;
}

-(void)respring {
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/sbreload"];
    [task launch];
}
@end
