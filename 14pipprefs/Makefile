TARGET := iphone:clang:14.4

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = 14PiPPrefs

14PiPPrefs_FILES = PIPRootListController.m
14PiPPrefs_FRAMEWORKS = UIKit
14PiPPrefs_PRIVATE_FRAMEWORKS = Preferences
14PiPPrefs_INSTALL_PATH = /Library/PreferenceBundles
14PiPPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
