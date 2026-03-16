//
//  menu.mm - FIXED BY G3 - LANCERPLAYS
//

#import "Module/View.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "View/OverlayView.h"
#import "utils/obfuscate.h"
#import "utils/Icon.h"
#import "utils/fa_solid_900.h"
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <Metal/Metal.h>
#import "utils/mahoa.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

// --- تعريف الهيكل المفقود لمنع أخطاء البناء ---
struct PreferencesStruct {
    bool Outfit;
    bool Face;
    bool Bagg;
    int bag;
    bool Helmett;
    int helmet;
    bool Emote;
    bool Parachute;
    struct {
        struct {
            int XSuits;
            int Parachute;
        } Skin;
    } Config;
} preferences;

#ifndef ENCRYPT
#define ENCRYPT(str) OBFUSCATE(str)
#endif
// ------------------------------------------

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define ALPHA    ( ImGuiColorEditFlags_AlphaPreview | ImGuiColorEditFlags_NoTooltip | ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoLabel | ImGuiColorEditFlags_AlphaBar | ImGuiColorEditFlags_InputRGB | ImGuiColorEditFlags_Float | ImGuiColorEditFlags_NoDragDrop | ImGuiColorEditFlags_PickerHueBar | ImGuiColorEditFlags_NoBorder )
#define NO_ALPHA ( ImGuiColorEditFlags_NoTooltip    | ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoLabel | ImGuiColorEditFlags_NoAlpha | ImGuiColorEditFlags_InputRGB | ImGuiColorEditFlags_Float | ImGuiColorEditFlags_NoDragDrop | ImGuiColorEditFlags_PickerHueBar | ImGuiColorEditFlags_NoBorder )

using namespace ImGui;
extern ImFont* verdanFnt;
extern ImFont* main_font;
bool overlay;
float g_disstance = 150.f;
int Crosss = 370;
float AimSpeed = 4.0f;
bool TeleportEnemy = false;
bool isAimKnocked = false;
bool Igronebot = false;
bool VisCheck = false;
float Recc = 1.0f;
bool ReCo = false;
bool AIMHEAD1 = false; 
bool AIMNeck1 = false; 
bool AIMcheat1 = true; 
bool IsShoot = true;
bool IsSCope = false;
bool IsBothaim =false;
bool IsAny=false;
bool AimBotStatus = false;
bool IsSilentAIM = false;
bool 引擎绘制 = false;
bool WideView;
float WideValue;

namespace menu {
    float menu_scale = 1.f;
    int opentype = 0;
    namespace ESP {
        bool esp = false;
        int esptyp = 0;
        bool ESPBox = false;
        bool ESPLine = false;
        bool ESPSkeleton = false;
        bool skipAI;
        bool outoffov;
        bool boxOutline;
        bool textOutline;
        bool health = false;
        bool weapon = false;
        bool teamID;
        bool name = false;
        bool distance = false;
        bool NOUSECRASH;
        bool enemy_count = false;
        bool ipadview;
        int viewvalue = 120;
        bool ESPMob;
        float items_scale = 1.f;

        ImColor v_espcolor(1, 255, 74);
        ImColor nv_espcolor(255, 1, 1);
        ImColor nickcolor(255, 255, 255);
        ImColor hprcolor(0, 255, 0, 150);
        ImColor hprkcolor(128, 128, 128, 150);
        ImColor hpr1color(255, 0, 0, 150);
        ImColor itemcolor(255, 255, 255);
        ImColor distcolor(255, 255, 255);
        ImColor weapcolor(255, 255, 255);
        ImColor infocolor(1, 1, 1);
        ImColor linecolor(255, 255, 255);
        ImColor v_skelcolor(1, 255, 74);
        ImColor nv_skelcolor(255, 1, 1);
        ImColor v_hpcolor(255, 255, 255);
        ImColor nv_hpcolor(255, 1, 1);
        ImColor v_backcolor(255, 255, 255);
        ImColor nv_backvolor(255, 1, 1);
        ImColor hpbotcolor(255, 165, 0, 150);
        ImColor hpbot1color(0, 255, 255, 150);
        ImColor RPIVbone(255, 0, 0, 150);
        ImColor RPVbone(0, 255, 0, 255);
        ImColor BIVbone(0, 255, 255, 255);
        ImColor BVbone(255, 165, 0, 255);
    }

    namespace aimbot {
        bool enable = false;
        bool skipKnock = false;
        bool ReCo = false;
        float Recc = 1.0f;
        int trigger = 0;
        int target = 0;
        float smooth = 1.f;
        float v_recoil = 1.2f;
        float aimfov = 80.f;
        float distance = 300.f;
        bool skipAI = false;
        bool visCheck = false;
        float distances = 300.f;
    }
    namespace silent {
        bool enable;
        bool visCheck = true;
        bool skipAI = true;
        bool skipKnock = true;
        float distance = 300.f;
        float silfov = 80.f;
        int trigger = 0;
        int target = 0;
    }
    namespace memory {
        bool xhit;
        bool noshake;
        bool norecoil;
        bool rapidfire;
        bool crosshair;
        bool rapidshoot;
    }
}

bool ModSkinn = false;
bool KillMessage = false;
bool DeadBox = false;
int ModEmote1 = 1;

// تم تعريف الهيكل أعلاه لذا لن يعطي خطأ هنا
static int prevXSuits = 0; 
static bool callFunction = false;
static int Target = 0;

INI* config;

NSString *textshow,*endtimetext,*namenear;
NSUserDefaults *check1 = [NSUserDefaults standardUserDefaults];
UILabel *MMero;
bool _humanBar;
bool magic,bighit,fastlanding,antena,HideGrass,nguoitrang,playerYallow,fastmove,ipadview,longjump,flyplayer;
BOOL magicactive,bighitactive,fastlandingactive,AntenaStatus,HideGrassStatus,nguoitrangactive,playerYallowStatus,fastmoveactive,longjumpactive,ipadviewactive,flyplayeractive;

@interface mi ()  {
    ImFont *_espFont;
}
@end

@implementation mi

int trigger;
const char* triggers[] = { "None", "Fire", "Scope", "Both", "Any" };
const char *optionItemName[] = {ICON_FA_HOME, ICON_FA_EYE, ICON_FA_BOXES, ICON_FA_CROSSHAIRS, ICON_FA_PALETTE,};
int optionItemCurrent = 0;
int aimbotIntensity;
const char *aimbotIntensityText[] = {"micro ","low", "Medium", "High", "Super High", "Strong Lock", "Super Lock"};
const char *aimbotModeText[] = {"Start with scope", "Start with fire", "Start with scope and fire", "Start with auto mode", "Start with touch position"};
const char *aimbotPartsText[] = {"Priority Head (Missed)", "Priority Body (Missed)", "Auto Mode (Missed)", "Fixed Head", "Fixed Body"};

OverlayView *overlayView;

- (instancetype)initWithFrame:(ModuleControl*)control {
    self = [super init];
    if (self) {
        self.moduleControl = control;
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"dolphins.ini"];
        if(![fileManager fileExistsAtPath:filePath]){
            [fileManager createFileAtPath:filePath contents:[NSData data] attributes:nil];
        }
        config = ini_load((char*)filePath.UTF8String);
    }
    return self;
}

-(void)setOverlayView:(OverlayView*)ov{
    overlayView = ov;
    [self readIniConfig];
}

-(void)drawMenuWindow {
    ImGui::SetNextWindowSize({900, 550}, ImGuiCond_FirstUseEver);
    ImGui::SetNextWindowPos({170, 250}, ImGuiCond_FirstUseEver);
    
    if (ImGui::Begin(OBFUSCATE("                                                         LancerPlays"), &self.moduleControl->menuStatus, ImGuiWindowFlags_NoCollapse)) {
        
        ImGuiContext& g = *GImGui;
        if(g.NavWindow == NULL){
            self.moduleControl->menuStatus = !self.moduleControl->menuStatus;
        }
        
        float sidebarWidth = 100.0f;
        float totalWidth = 900.0f;
        float spacing = 5.0f;
        
        ImGui::BeginChild("##optionLayout", {sidebarWidth, 0}, false, ImGuiWindowFlags_None);
        ImGui::SetWindowFontScale(1.9f);
        for (int i = 0; i < IM_ARRAYSIZE(optionItemName); ++i) {
            if (optionItemCurrent != i) {
                ImGui::PushStyleColor(ImGuiCol_Button, ImColor(0, 0, 0, 0).Value);
                ImGui::PushStyleColor(ImGuiCol_ButtonHovered, ImColor(0, 0, 0, 0).Value);
                ImGui::PushStyleColor(ImGuiCol_ButtonActive, ImColor(0, 0, 0, 0).Value);
            }
            bool isClick = ImGui::Button(optionItemName[i]);
            if (optionItemCurrent != i) {
                ImGui::PopStyleColor(3);
            }
            if (isClick) {
                optionItemCurrent = i;
            }
        }
        ImGui::EndChild();
        ImGui::SameLine(0.0f, spacing);
        ImGui::BeginChild("##surfaceLayout", {totalWidth - sidebarWidth - spacing - 20.0f, 0}, false, ImGuiWindowFlags_None);

        switch (optionItemCurrent) {
            case 0: [self showSystemInfo]; break;
            case 1: [self showPlayerControl]; break;
            case 2: [self showMaterialControl]; break;
            case 3: [self showAimbotControl]; break;
            case 4: [self Skin]; break;
            case 5: [self Brutal]; break;
            case 6: [self showsystemproclamation]; break;
        }
        ImGui::EndChild();
        ImGui::End();
    }
}

// ... بقية الدوال (SystemInfo, PlayerControl الخ) تبقى كما هي لديك ...

@end
