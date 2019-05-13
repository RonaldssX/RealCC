DEBUG=0
FINALPACKAGE=1

RealCCXS_CFLAGS = -DTHEOS

include $(THEOS)/makefiles/common.mk
export ARCHS = arm64 arm64e
TWEAK_NAME = RealCCXS
RealCCXS_FILES = Tweak.xm
RealCCXS_FRAMEWORKS = UIKit
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
