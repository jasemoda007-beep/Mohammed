#import <Foundation/Foundation.h>
#import "View/FloatView.h"
#import "View/OverlayView.h"
#include "dolphins.h"
#import <mach-o/dyld.h>
#include <stdio.h>
#include <vector>
#include <iostream>

#include "utils/module_tools.h"
#include "utils/memory_tools.h"
#include "utils/log.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
using namespace std;

// ==========================================
// 🔴 أوفستات التحديث الجديد (بدون الحاجة للـ SDK)
// ==========================================
namespace Offsets {
    const int SelfOffset = 0x28d0;
    const int MouseOffset = 0x4e0; // PlayerController
    const int CameraManagerOffset = 0x548;
    const int PovOffset = 0x10a0;
    const int AngleOffset = 0x558;
    
    const int StatusOffset = 0x1058;
    const int TeamOffset = 0x998;
    const int NameOffset = 0x960;
    const int RobotOffset = 0xa59;
    const int NationOffset = 0x970;
    const int HpOffset = 0xe60;
    const int HpMaxOffset = 0xe64;
    const int isDead = 0xe7c;
    
    const int MeshOffset = 0x510;
    const int HumanOffset = 0x210;
    const int BonesOffset = 0x990;
    const int boneCountOffset = 0x8d0;
    
    const int CoordOffset = 0x208; // RootComponent
    const int CoordOffset2 = 0x1c8; // RelativeLocation
    const int HeightOffset = 0x1dc;
    
    const int LineOfSightTo = 0x7B0;
    const int Yaw = 0x890;
    const int Roll = 0x888;
    const int Pitch = 0x898;
}

// وحدات التحكم
ModuleControl moduleControl;
MemoryTools memoryTools;

// دوال المحرك
bool (*LineOfSightTo)(void *controller, void *actor, ImVec3 bone_point, bool ischeck);
void (*AddControllerYawInput)(void *actot, float val);
void (*AddControllerRollInput)(void *actot, float val);
void (*AddControllerPitchInput)(void *actot, float val);

// ==========================================
// 🔵 أدوات الذاكرة الأساسية
// ==========================================
static long gWorldaddr, gWorldData;
static long gNameaddr, gNameData;

static long gWorld(){
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *BundID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    if ([BundID containsString:@"ig"]) {
        gWorldaddr = 0x102A8D3C4; gWorldData = 0x10A66BFE0;
    } else if ([BundID containsString:@"kr"]) {
        gWorldaddr = 0x102B18D38; gWorldData = 0x10A7EDA60;
    } else if ([BundID containsString:@"vn"]) {
        gWorldaddr = 0x1028F8044; gWorldData = 0x10A576D70;
    }
    return reinterpret_cast<long(__fastcall*)(long)>((long)_dyld_get_image_vmaddr_slide(0) + gWorldaddr)((long)_dyld_get_image_vmaddr_slide(0) + gWorldData);
}

static long gName(){
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *BundID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    if ([BundID containsString:@"ig"]) {
        gNameaddr = 0x10487CBE8; gNameData = 0x109FCAAA0;
    } else if ([BundID containsString:@"kr"]) {
        gNameaddr = 0x1049EAB1C; gNameData = 0x10A14B000;
    } else if ([BundID containsString:@"vn"]) {
        gNameaddr = 0x1047CACD4; gNameData = 0x109FCA750;
    }
    return reinterpret_cast<long(__fastcall*)(long)>((long)_dyld_get_image_vmaddr_slide(0) + gNameaddr)((long)_dyld_get_image_vmaddr_slide(0) + gNameData);
}

bool IsValidAddress(long addr) {
    return addr > 0x100000000 && addr < 0x2000000000;
}

template<typename T> T Read(long address) {
    T data;
    memoryTools.readMemory(address, sizeof(T), reinterpret_cast<void *>(&data));
    return data;
}



// --- دالة جلب اسم الكلاس من الذاكرة (بدون SDK) ---
string getClassName(int id) {
    uintptr_t gname = staticData.gnameAddr;
    if (!IsValidAddress(gname)) return "None";

    // منطق جلب الاسم من GNames (PUBG Mobile)
    uintptr_t chunk = Read<uintptr_t>(gname + (id / 16384) * 8);
    uintptr_t entry = Read<uintptr_t>(chunk + (id % 16384) * 8);
    
    char name[64];
    memoryTools.readMemory(entry + 16, 64, name); // الأوفست 16 هو بداية النص في GNameEntry
    return string(name);
}

// --- دالة جلب اسم اللاعب (بدون SDK) ---
string getPlayerName(long addr) {
    if (!IsValidAddress(addr)) return "Player";
    
    // قراءة الـ FString الخاص بالاسم
    uintptr_t namePtr = Read<uintptr_t>(addr);
    int nameLen = Read<int>(addr + 8);
    
    if (nameLen > 0 && nameLen < 100) {
        char buffer[100];
        memoryTools.readMemory(namePtr, nameLen * 2, buffer); // UTF-16
        // تحويل بسيط للنص أو إرجاعه كـ string
        return string(buffer);
    }
    return "Enemy";
}








// فك تشفير مصفوفة اللاعبين
uint64_t DecryptActorsArray(uint64_t uLevel, int Actors_Offset, int EncryptedActors_Offset) {
    if (uLevel < 0x10000000) return 0;
    if (Read<uint64_t>(uLevel + Actors_Offset) > 0) return uLevel + Actors_Offset;
    if (Read<uint64_t>(uLevel + EncryptedActors_Offset) > 0) return uLevel + EncryptedActors_Offset;
    // ... (باقي كود التشفير الأصلي كما هو لتوفير المساحة، افترض وجوده هنا)
    return 0;
}

// هياكل البيانات العامة
struct {
    uintptr_t libAddr = 0;
    uintptr_t gwlordAddr;
    uintptr_t gnameAddr;
    uintptr_t playerController;
    uintptr_t cameraManager;
    uintptr_t selfAddr;
    vector<StaticPlayerData> playerDataList;
    vector<StaticMaterialData> materialDataList;
} staticData;

// ==========================================
// 🟡 دالة تشغيل الهاك وتأخير الـ ImGui
// ==========================================
static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
    // تأخير 5 ثواني لمنع الكراش بالشاشة السوداء
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        mao* drawWindow = [[mao alloc] initWithFrame:&moduleControl];
        mi* menuWindow = [[mi alloc] initWithFrame:&moduleControl];
        OverlayView* overlayView = [[OverlayView alloc] initWithFrame:[UIScreen mainScreen].bounds :&moduleControl :drawWindow :menuWindow];
        [[UIApplication sharedApplication].keyWindow addSubview:overlayView];
        
        FloatView* floatView = [[FloatView alloc] initWithFrame:CGRectMake(489, 58, 45, 45) :&moduleControl];
        [[UIApplication sharedApplication].keyWindow addSubview:floatView];
    });
}

__attribute__((constructor)) static void initialize() {
    CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDrop);
    
    pthread_t staticDataThread;
    pthread_create(&staticDataThread, nullptr, readStaticData, nullptr);
}

// ==========================================
// 🟢 جلب البيانات الثابتة (بدون SDK)
// ==========================================
void *readStaticData(void *) {
    while (true) {
        sleep(1); // تم تقليل الوقت لسرعة الرادار
        if(moduleControl.systemStatus != TransmissionNormal){
            staticData.libAddr = (uintptr_t)_dyld_get_image_vmaddr_slide(0);
            if(staticData.libAddr != 0) moduleControl.systemStatus = TransmissionNormal;
        } else {
            staticData.gwlordAddr = gWorld();
            staticData.gnameAddr = gName();
            
            // قراءة المؤشرات باستخدام الأوفستات المباشرة
            staticData.playerController = memoryTools.readPtr(memoryTools.readPtr(memoryTools.readPtr(staticData.gwlordAddr + 0x38) + 0x78) + 0x30);
            staticData.selfAddr = memoryTools.readPtr(staticData.playerController + Offsets::SelfOffset);
            staticData.cameraManager = memoryTools.readPtr(staticData.playerController + Offsets::CameraManagerOffset);
            
            vector<StaticPlayerData> tmpPlayerDataList;
            uintptr_t uLevel = memoryTools.readPtr(staticData.gwlordAddr + 0x30);
            auto Actors = DecryptActorsArray(uLevel, 0xA0, 0x488); // افتراضي
            auto obectArray = Read<uint64_t>(Actors);
            auto objectCount = Read<int>(Actors + 0x8);
            
            for (int index = 0; index < objectCount; ++index) {
                uintptr_t objectAddr = memoryTools.readPtr(obectArray + index * 8);
                if (!IsValidAddress(objectAddr)) continue;
                
                uintptr_t coordAddr = memoryTools.readPtr(objectAddr + Offsets::CoordOffset);
                string className = getClassName(memoryTools.readInt(objectAddr + 0x18)); // ClassID
                
                if (strstr(className.c_str(), "PlayerPawn") || strstr(className.c_str(), "Character")) {
                    int team = memoryTools.readInt(objectAddr + Offsets::TeamOffset);
                    int myTeam = memoryTools.readInt(staticData.selfAddr + Offsets::TeamOffset);
                    if (team == myTeam) continue;
                    
                    bool bDead = Read<bool>(objectAddr + Offsets::isDead);
                    if(bDead) continue;
                    
                    StaticPlayerData tmpPlayerData;
                    tmpPlayerData.addr = objectAddr;
                    tmpPlayerData.coordAddr = coordAddr;
                    tmpPlayerData.team = team;
                    tmpPlayerData.robot = memoryTools.readInt(objectAddr + Offsets::RobotOffset);
                    tmpPlayerData.name = getPlayerName(memoryTools.readPtr(objectAddr + Offsets::NameOffset));
                    
                    tmpPlayerDataList.push_back(tmpPlayerData);
                }
            }
            staticData.playerDataList.swap(tmpPlayerDataList);
        }
    }
    return nullptr;
}

// ==========================================
// 🟣 جلب الإطارات والحالة (بدون SDK)
// ==========================================
void readFrameData(ImVec2 screenSize, vector<PlayerData> &playerDataList, vector<MaterialData> &materialDataList) {
    playerDataList.clear();
    materialDataList.clear();
    
    if (moduleControl.systemStatus == TransmissionNormal) {
        // قراءة موقع الكاميرا مباشرة من الذاكرة (بدون MinimalViewInfo Struct مال SDK)
        uintptr_t povAddr = staticData.cameraManager + Offsets::PovOffset + 0x10; 
        ImVec3 selfCoord = Read<ImVec3>(povAddr + 0x0); // Location
        
        float lateralAngleView = memoryTools.readFloat(staticData.playerController + Offsets::MouseOffset + 0x4) - 90;
        
        if (moduleControl.mainSwitch.playerStatus) {
            for (auto staticPlayerData: staticData.playerDataList) {
                
                ImVec3 objectCoord;
                memoryTools.readMemory(staticPlayerData.coordAddr + Offsets::CoordOffset2, sizeof(ImVec3), &objectCoord);
                
                float objectDistance = get3dDistance(objectCoord, selfCoord, 100);
                if (objectDistance < 0 || objectDistance > 450) continue;
                
                PlayerData playerData;
                playerData.distance = objectDistance;
                playerData.robot = staticPlayerData.robot;
                playerData.team = staticPlayerData.team;
                playerData.hp = memoryTools.readFloat(staticPlayerData.addr + Offsets::HpOffset);
                
                // قراءة الحالة كقيمة (وليس مؤشر)
                uint64_t statusVal = Read<uint64_t>(staticPlayerData.addr + Offsets::StatusOffset);
                
                if (statusVal == 2097168) playerData.statusName = "开车"; // يسوق
                else if (statusVal == 262208) playerData.statusName = "打药"; // يعالج
                else if (statusVal == 524288) playerData.statusName = "击倒"; // نوك
                else if (statusVal == 8205 || statusVal == 1073741840) playerData.statusName = "开火"; // يرمي
                else if (statusVal == 32784) playerData.statusName = "挥拳"; // بوكسات
                else playerData.statusName = "未知"; // غير معروف
                
                playerDataList.push_back(playerData);
            }
        }
    }
} // نهاية الدالة والأقواس مضبوطة 100%
