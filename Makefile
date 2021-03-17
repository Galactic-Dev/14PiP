PREFIX=$(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/
export ARCHS = x86_64
TARGET := simulator:clang:latest
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = 14PiP

14PiP_FILES = Tweak.x $(wildcard *.m)
14PiP_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
