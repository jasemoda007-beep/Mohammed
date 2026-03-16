ARCHS = arm64
#Add arm64e if it needed
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LancerPlays

LancerPlays_FRAMEWORKS = IOKit UIKit Foundation Security QuartzCore CoreGraphics CoreText AVFoundation Accelerate GLKit SystemConfiguration GameController
LancerPlays_LDFLAGS += JRMemory.framework/JRMemory

# تم إضافة -I. لحل مشكلة عدم العثور على ملفات الهيدر
LancerPlays_CCFLAGS = -I. -w -std=gnu++14 -fno-rtti -fno-exceptions -DNDEBUG -Wno-module-import-in-extern-c
LancerPlays_CFLAGS = -I. -w -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value

# تم حذف $(wildcard SDK/*.cpp) لأننا نعتمد على القراءة المباشرة
LancerPlays_FILES = Dolphins.mm $(wildcard View/*.mm) $(wildcard View/CustomView/*.mm) $(wildcard Module/*.mm) $(wildcard utils/*.cpp) $(wildcard utils/*.m) $(wildcard imgui/*.mm) $(wildcard imgui/*.cpp) $(wildcard engine/*.mm) $(wildcard engine/*.cpp)

#Dolphins_LIBRARIES += substrate
# GO_EASY_ON_ME = 1

include $(THEOS_MAKE_PATH)/tweak.mk
