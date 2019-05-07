THEOS_DEVICE_IP = 192.168.0.103

include $(THEOS)/makefiles/common.mk
export ARCHS = arm64 arm64e
TWEAK_NAME = RealCCXS
RealCCXS_FILES = Tweak.xm
RealCCXS_FRAMEWORKS = UIKit
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
