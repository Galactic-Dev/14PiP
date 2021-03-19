export PREFIX=$(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/
export ARCHS = arm64 arm64e

TARGET := iphone:clang:14.4
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = 14PiP

14PiP_FILES = Tweak.x $(wildcard *.m)
14PiP_CFLAGS = -fobjc-arc

14PiP_PRIVATE_FRAMEWORKS = MediaRemote

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += 14pipprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
