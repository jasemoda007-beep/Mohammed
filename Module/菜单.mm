//
//  menu.mm
//  Dolphins
//
//  Created by saudgl on 2023/7/29.
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
#include "engine/expermant.h"


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
bool AIMHEAD1 = false; //head
bool AIMNeck1 = false; //root
bool AIMcheat1 = true; //pelvis
bool IsShoot = true;
bool IsSCope = false;
bool IsBothaim =false;
bool IsAny=false;
bool AimBotStatus = false;
bool IsSilentAIM = false;
//bool MenDeal = true;
//bool hooked = true;
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

static int prevXSuits = preferences.Config.Skin.XSuits;
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
//UILabel *MMero;
int trigger;
const char* triggers[] = { "None", "Fire", "Scope", "Both", "Any" };
const char *optionItemName[] = {ICON_FA_HOME, ICON_FA_EYE, ICON_FA_BOXES, ICON_FA_CROSSHAIRS, ICON_FA_PALETTE,};
int optionItemCurrent = 0;
//自瞄部位文本
int aimbotIntensity;
const char *aimbotIntensityText[] = {"micro ","low", "Medium", "High", "Super High", "Strong Lock", "Super Lock"};
//自瞄部位文本
const char *aimbotModeText[] = {"Start with scope", "Start with fire", "Start with scope and fire", "Start with auto mode", "Start with touch position"};
//自瞄部位文本
const char *aimbotPartsText[] = {"Priority Head (Missed)", "Priority Body (Missed)", "Auto Mode (Missed)", "Fixed Head", "Fixed Body"};

OverlayView *overlayView;

- (instancetype)initWithFrame:(ModuleControl*)control {
    self.moduleControl = control;
    //获取Documents目录路径
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //初始化文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //拼接文件路径
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"dolphins.ini"];
    //文件不存在
    if(![fileManager fileExistsAtPath:filePath]){
        //创建文件
        [fileManager createFileAtPath:filePath contents:[NSData data] attributes:nil];
    }
    //获取ini文件数据
    config = ini_load((char*)filePath.UTF8String);
    //
    
    
    
    //
    return [super init];
    
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
        
        float sidebarWidth = 100.0f;  // jitna tu sidebar chhota chahta hai
        float totalWidth = 900.0f;   // window ka total width
        float spacing = 5.0f;        // beech ka spacing, isse tweak kar
        
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
        ImGui::EndChild(); // after left panel
        ImGui::SameLine(0.0f, spacing); // spacing fix
        ImGui::BeginChild("##surfaceLayout", {totalWidth - sidebarWidth - spacing - 20.0f, 0}, false, ImGuiWindowFlags_None);

        switch (optionItemCurrent) {
            case 0:
                [self showSystemInfo];
                break;
            case 1:
                [self showPlayerControl];
                break;
            case 2:
                [self showMaterialControl];
                break;
            case 3:
                [self showAimbotControl];
                break;
            case 4:
                [self Skin];
                break;
            case 5:
                [self Brutal];
                break;
            case 6:
                [self showsystemproclamation];
                break;
        }
        ImGui::EndChild();
        
        
        ImGui::End();
    }
}






-(void)showSystemInfo {
    
    mach_port_t host_port;
            mach_msg_type_number_t host_size;
            vm_size_t pagesize;

            host_port = mach_host_self();
            host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
            host_page_size(host_port, &pagesize);

            vm_statistics_data_t vm_stat;

            if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
            //Lỗi
            }

            natural_t mem_used = (vm_stat.active_count +
                  vm_stat.inactive_count +
                  vm_stat.wire_count) * pagesize;
            natural_t mem_free = vm_stat.free_count * pagesize;
            natural_t mem_total = mem_used + mem_free;


            UIDevice *myDevice = [UIDevice currentDevice];
            [myDevice setBatteryMonitoringEnabled:YES];

            int state = [myDevice batteryState];
            NSLog(@"Battery Status: %d",state);
            int batLeft = (float)[myDevice batteryLevel] * 100;
           kern_return_t kr;
            task_info_data_t tinfo;
            mach_msg_type_number_t task_info_count;

            task_info_count = TASK_INFO_MAX;
            kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
            if (kr != KERN_SUCCESS)
            {

            }

            task_basic_info_t      basic_info;
            thread_array_t         thread_list;
            mach_msg_type_number_t thread_count;
            thread_info_data_t     thinfo;
            mach_msg_type_number_t thread_info_count;
            thread_basic_info_t basic_info_th;
            uint32_t stat_thread = 0; // Mach threads

            basic_info = (task_basic_info_t)tinfo;

            // get threads in the task
            kr = task_threads(mach_task_self(), &thread_list, &thread_count);
            if (kr != KERN_SUCCESS)
            {

            }
            if (thread_count > 0)
            stat_thread += thread_count;

            long tot_sec = 0;
            long tot_usec = 0;
            float tot_cpu = 0;
            int j;

            for (j = 0; j < thread_count; j++)
            {
            thread_info_count = THREAD_INFO_MAX;
            kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
             (thread_info_t)thinfo, &thread_info_count);
            if (kr != KERN_SUCCESS)
            {

            }

            basic_info_th = (thread_basic_info_t)thinfo;

            if (!(basic_info_th->flags & TH_FLAGS_IDLE))
            {
            //This is 0
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;

            //This is 0
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;

            //This is total
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
            }

            } // for each thread

            kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
            assert(kr == KERN_SUCCESS);

            //return [NSString stringWithFormat:@"%.2f",tot_cpu];






NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];

            [DateFormatter setDateFormat:@"hh:mm:ss , d MMMM, yyyy"];

            
            NSString *datetime=[NSString stringWithFormat:NSSENCRYPT("%@"),[DateFormatter stringFromDate:[NSDate date]]];

            char* sdatetime = (char*) [datetime cStringUsingEncoding:NSUTF8StringEncoding];

            ImGui::TextColored(ImColor(102,255,255), "%s", sdatetime);

            ImGui::Separator();




            ImGui::TextColored(ImColor(0,255,0), "Ram Total: %uMB", mem_total/(1024*1024));

                ImGui::SameLine();

ImGui::TextColored(ImColor(120,255,0), "ms/frame: %.3f", 500.0f / ImGui::GetIO().Framerate);



            ImGui::TextColored(ImColor(255,255,0), "Used: %uMB", mem_used/(1024*1024));
ImGui::SameLine();

            ImGui::TextColored(ImColor(0,255,0), "FPS: %.1f", ImGui::GetIO().Framerate);


            ImGui::TextColored(ImColor(255,178,102), "Free: %uMB", mem_free/(1024*1024));

ImGui::SameLine();
            ImGui::TextColored(ImColor(100,255,20), "Total CPU: %.2f", tot_cpu);


    ImGui::TextColored(ImColor(0,178,102), "Battery: %d", batLeft);
    ImGui::SameLine();
    if(state == 1){
    ImGui::TextColored(ImColor(102,255,102), "Unplegged");
    }else if(state == 2){
    ImGui::TextColored(ImColor(255,255,51), "Charging");
    }else if(state == 3){
    ImGui::TextColored(ImColor(0,255,0), "Full");
    }else if(state == 0){
    ImGui::TextColored(ImColor(255,0,0), "Unknown");
    }
    ImGui::Separator();
    
    //Perspective for show radar map and arrows
    

    // 60FPS framw
    ImGui::BulletColorText(ImColor(0, 255, 0, 255).Value, "Frame Rates");
    if (ImGui::RadioButton("60FPS", &self.moduleControl->fps, 0)) {
        configManager::putInteger(config,"mainSwitch", "fps",self.moduleControl->fps);
        overlayView.preferredFramesPerSecond = 60;
    }
    //90FPS frame
    ImGui::SameLine();
    if (ImGui::RadioButton("90FPS", &self.moduleControl->fps, 1)) {
        configManager::putInteger(config,"mainSwitch", "fps",self.moduleControl->fps);
        overlayView.preferredFramesPerSecond = 90;
    }
    ImGui::SameLine();
    //120FPS frame
    if (ImGui::RadioButton("120FPS", &self.moduleControl->fps, 2)) {
        configManager::putInteger(config,"mainSwitch", "fps",self.moduleControl->fps);
        overlayView.preferredFramesPerSecond = 120;
    }
    ImGui::Separator();
    if (ImGui::Checkbox("Hide ESP", &self.moduleControl->mainSwitch.hide)) {
        configManager::putBoolean(config,"mainSwitch", "gzb", self.moduleControl->mainSwitch.hide);
    }
    if (ImGui::Checkbox("Teleport enemy", &TeleportEnemy)){

    }
    

    
}

-(void) showPlayerControl {
    ImGui::BulletColorText(ImColor(0, 255, 0, 255).Value, "ESP Functions");
    if (ImGui::Checkbox("ESP", &self.moduleControl->mainSwitch.playerStatus)) {
        configManager::putBoolean(config,"mainSwitch", "player", self.moduleControl->mainSwitch.playerStatus);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Health", &self.moduleControl->playerSwitch.infoStatus)) {
        configManager::putBoolean(config,"playerSwitch", "playerSwitch_3", self.moduleControl->playerSwitch.infoStatus);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Resources", &self.moduleControl->mainSwitch.materialStatus)) {
        configManager::putBoolean(config,"mainSwitch", "material", self.moduleControl->mainSwitch.materialStatus);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Line", &self.moduleControl->playerSwitch.lineStatus)) {
        configManager::putBoolean(config,"playerSwitch", "playerSwitch_2", self.moduleControl->playerSwitch.lineStatus);
    }
    if (ImGui::Checkbox("Bone", &self.moduleControl->playerSwitch.boneStatus)) {
        configManager::putBoolean(config,"playerSwitch", "playerSwitch_1", self.moduleControl->playerSwitch.boneStatus);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Box player", &self.moduleControl->playerSwitch.boxStatus)) {
        configManager::putBoolean(config,"playerSwitch", "playerSwitch_0", self.moduleControl->playerSwitch.boxStatus);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Handheld Image", &self.moduleControl->playerSwitch.SCStatus)) {
        configManager::putBoolean(config,"playerSwitch", "playerSwitch_6", self.moduleControl->playerSwitch.SCStatus);
    }
    if (ImGui::Checkbox("Handheld Text", &self.moduleControl->playerSwitch.SCWZStatus)) {
        configManager::putBoolean(config,"playerSwitch", "playerSwitch_7", self.moduleControl->playerSwitch.SCWZStatus);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Arrow", &self.moduleControl->playerSwitch.backStatus)) {
        configManager::putBoolean(config,"playerSwitch", "playerSwitch_5", self.moduleControl->playerSwitch.backStatus);
    }
    
    ImGui::SameLine();
    if (ImGui::Checkbox("Vehicle", &self.moduleControl->materialSwitch[Vehicle])) {
        std::string str = "materialSwitch_" + std::to_string(Vehicle);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[Vehicle]);
    }
    ImGui::ColorEdit4("Real Player Visible", (float*)&menu::ESP::hprcolor);
    ImGui::ColorEdit4("Real Player Invisible", (float*)&menu::ESP::hpr1color);
    ImGui::Separator();
    ImGui::ColorEdit4("Bot Visible", (float*)&menu::ESP::hpbotcolor);
    ImGui::ColorEdit4("Bot Invisible", (float*)&menu::ESP::hpbot1color);
    ImGui::Separator();
    ImGui::ColorEdit4("Player Visbility Skeleton", (float*)&menu::ESP::RPVbone);
    ImGui::ColorEdit4("Player Invisible Skeleton", (float*)&menu::ESP::RPIVbone);
    ImGui::Separator();
    ImGui::ColorEdit4("Bot Visbility Skeleton", (float*)&menu::ESP::BVbone);
    ImGui::ColorEdit4("Bot Invisible Skeleton", (float*)&menu::ESP::BIVbone);
    
    ImGui::BulletColorText(ImColor(0, 0, 0, 255).Value, "Radar adjust");
    
    ImGui::SetNextItemWidth(ImGui::GetWindowContentRegionWidth() - calcTextSize("Radar X") - 32.0f);
    if (ImGui::SliderFloat("radar X##radarX", &self.moduleControl->playerSwitch.radarCoord.x, 0.0f, ([UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].nativeScale), "%.0f")) {
        configManager::putFloat(config,"playerSwitch", "radarX", self.moduleControl->playerSwitch.radarCoord.x);
    }
    
    ImGui::SetNextItemWidth(ImGui::GetWindowContentRegionWidth() - calcTextSize("Radar Y") - 32.0f);
    if (ImGui::SliderFloat("radar Y##radarY", &self.moduleControl->playerSwitch.radarCoord.y, 0.0f, ([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].nativeScale), "%.0f")) {
        configManager::putFloat(config,"playerSwitch", "radarY", self.moduleControl->playerSwitch.radarCoord.y);
    }
    ImGui::SetNextItemWidth(ImGui::GetWindowContentRegionWidth() - calcTextSize("Radar size") - 32.0f);
    if (ImGui::SliderFloat("radar size##radarSize", &self.moduleControl->playerSwitch.radarSize, 1.0f, 100, "%.0f%%")) {
        configManager::putFloat(config,"playerSwitch", "RadarSize", self.moduleControl->playerSwitch.radarSize);
    }
}
//item drawing
-(void) showMaterialControl {
    ImGui::BulletColorText(ImColor(0, 255, 0, 255).Value, "Item ESP");
    
    if (ImGui::Checkbox("Material Texture", &self.moduleControl->playerSwitch.WZStatus)) {
        configManager::putBoolean(config,"playerSwitch", "playerSwitch_8", self.moduleControl->playerSwitch.WZStatus);
    }
    ImGui::SameLine();    if (ImGui::Checkbox("Material texture", &self.moduleControl->playerSwitch.WZWZStatus)) {
        configManager::putBoolean(config,"playerSwitch", "playerSwitch_9", self.moduleControl->playerSwitch.WZWZStatus);
    }
    
    
    if (ImGui::Checkbox("Rifle Part", &self.moduleControl->materialSwitch[RifleParts])) {
        std::string str = "materialSwitch_" + std::to_string(RifleParts);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[RifleParts]);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Drug", &self.moduleControl->materialSwitch[Drug])) {
        std::string str = "materialSwitch_" + std::to_string(Drug);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[Drug]);
    }
    
    ImGui::SameLine();
    if (ImGui::Checkbox("Grip", &self.moduleControl->materialSwitch[Grip])) {
        std::string str = "materialSwitch_" + std::to_string(Grip);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[Grip]);
    }
    
    if (ImGui::Checkbox("Rifle", &self.moduleControl->materialSwitch[Rifle])) {
        std::string str = "materialSwitch_" + std::to_string(Rifle);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[Rifle]);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Short Gun", &self.moduleControl->materialSwitch[ShotGun])) {
        std::string str = "materialSwitch_" + std::to_string(ShotGun);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[ShotGun]);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Throw", &self.moduleControl->materialSwitch[Missile])) {
        std::string str = "materialSwitch_" + std::to_string(Missile);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[Missile]);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Armor", &self.moduleControl->materialSwitch[Armor])) {
        std::string str = "materialSwitch_" + std::to_string(Armor);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[Armor]);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Sniper Material", &self.moduleControl->materialSwitch[SniperParts])) {
        std::string str = "materialSwitch_" + std::to_string(Sniper);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[Sniper]);
    }
    
    
    if (ImGui::Checkbox("Airdrop", &self.moduleControl->materialSwitch[Airdrop])) {
        std::string str = "materialSwitch_" + std::to_string(Airdrop);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[Airdrop]);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Flare gun", &self.moduleControl->materialSwitch[FlareGun])) {
        std::string str = "materialSwitch_" + std::to_string(FlareGun);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[FlareGun]);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Sniper", &self.moduleControl->materialSwitch[Sniper])) {
        std::string str = "materialSwitch_" + std::to_string(Sniper);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[Sniper]);
    }
    
    if (ImGui::Checkbox("Sight", &self.moduleControl->materialSwitch[Sight])) {
        std::string str = "materialSwitch_" + std::to_string(Sight);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[Sight]);
    }
    ImGui::SameLine();
    if (ImGui::Checkbox("Grenade warning", &self.moduleControl->materialSwitch[Warning])) {
        std::string str = "materialSwitch_" + std::to_string(Warning);
        configManager::putBoolean(config,"materialSwitch", str.c_str(), self.moduleControl->materialSwitch[Warning]);
    }
    
}

-(void) showAimbotControl {
    ImGui::BulletColorText(ImColor(0, 255, 0, 255).Value, "Aim Features");
    if (Checkbox(ENCRYPT("Aimbot Enabled"), &menu::aimbot::enable)) {
        configManager::putBoolean(config, ENCRYPT("Aimbot"), ENCRYPT("Aimbot"), menu::aimbot::enable);
    }
    ImGui::SameLine();
    if (Checkbox(ENCRYPT("Bullet Track (Shortgun Only)"), &menu::silent::enable)) {
        configManager::putBoolean(config, ENCRYPT("Silent"), ENCRYPT("Enabled"), menu::silent::enable);
    }
    if (Checkbox(ENCRYPT("Ignore knocked"), &menu::silent::skipKnock)) {
        configManager::putBoolean(config, ENCRYPT("Silent"), ENCRYPT("Ignore knocked"), menu::silent::skipKnock);
    }
    ImGui::SameLine();
    if (Checkbox(ENCRYPT("Ignore Bot"), &menu::silent::skipAI)) {
        configManager::putBoolean(config, ENCRYPT("Silent"), ENCRYPT("Ignore AI"), menu::silent::skipAI);
    }
    ImGui::SameLine();
    if (Checkbox(ENCRYPT("Visible check"), &menu::silent::visCheck)) {
        configManager::putBoolean(config, ENCRYPT("Silent"), ENCRYPT("Visible check"), menu::silent::visCheck);
        
    }
    static const char* targets[] = { ("Head"), ("Body") };
    
    // Silent aim target selection
    if (ImGui::Combo(ENCRYPT("Silent Aim Hitbox"), (int*)&menu::silent::target, targets, 2, -1)) {
        // Save the silent aim target
        configManager::putInteger(config, ENCRYPT("Silent"), ENCRYPT("Hitbox"), menu::silent::target);
    }

    // Aimbot target selection
    if (ImGui::Combo(ENCRYPT("Aimbot Hitbox"), (int*)&menu::aimbot::target, targets, 2, -1)) {
        // Save the aimbot target
        configManager::putInteger(config, ENCRYPT("Aimbot"), ENCRYPT("Hitbox"), menu::aimbot::target);
    }

    
    static const char *triggers[] = {("None"), ("Fire"), ("Scope"), ("Both"), ("Any")};
    if (ImGui::Combo(ENCRYPT("Silent Triggers"), (int*)&menu::silent::trigger, triggers, 5, -1)) {
        configManager::putInteger(config, ENCRYPT("Silent"), ENCRYPT("Trigger"), menu::silent::trigger);
    }
    
    if (ImGui::Combo(ENCRYPT("Aimbot Triggers"), (int*)&menu::aimbot::trigger, triggers, 5, -1)) {
        configManager::putInteger(config, ENCRYPT("Aimbot"), ENCRYPT("Trigger"), menu::aimbot::trigger);
    }
    
    if (SliderFloat(ENCRYPT("FOV"), &menu::silent::silfov, 0.f, 360.f)) {
        menu::aimbot::aimfov = menu::silent::silfov; // set both to same
        configManager::putFloat(config, ENCRYPT("Silent"), ENCRYPT("Field of View"), menu::silent::silfov);
        configManager::putFloat(config, ENCRYPT("Aimbot"), ENCRYPT("Field of View"), menu::aimbot::aimfov);
    }
    if (SliderFloat(ENCRYPT("Max Distance"), &menu::silent::distance, 0.f, 500.f)) {
        menu::aimbot::distance = menu::silent::distance;
        configManager::putFloat(config, ENCRYPT("Silent"), ENCRYPT("Distance"), menu::silent::distance);
        configManager::putFloat(config, ENCRYPT("Aimbot"), ENCRYPT("Distance"), menu::aimbot::distance);
    }
    
    
    
    if (ImGui::Combo("Speed", &aimbotIntensity, aimbotIntensityText, IM_ARRAYSIZE(aimbotIntensityText))) {
        configManager::putInteger(config,"aimbotControl", "speed",aimbotIntensity);
        switch (aimbotIntensity) {
            case 0:
                AimSpeed = 10.0f;
                break;
            case 1:
                AimSpeed = 8.0f;
                break;
            case 2:
                AimSpeed = 6.0f;
                break;
            case 3:
                AimSpeed = 4.0f;
                break;
            case 4:
                AimSpeed = 3.0f;
                break;
            case 5:
                AimSpeed = 2.0f;
                break;
            case 6:
                AimSpeed = 1.0f;
                break;
        }
    }
    if (ImGui::Checkbox("Macro", &menu::aimbot::ReCo)) {
        
    }
    if(menu::aimbot::ReCo){
        if (ImGui::SliderFloat("Rate   ", &menu::aimbot::Recc, 0.0f, 10.0f, "%.1f")) {
            configManager::putFloat(config,"aimbotControl", "valuelessrecoil", menu::aimbot::Recc);
        }}
}

-(void)Skin{
    ImGui::BulletColorText(ImColor(0, 255, 0, 255).Value, "Skin Features");
    
    Checkbox(ENCRYPT("Enabled Skins"), &ModSkinn);
    ImGui::SameLine();
    Checkbox(ENCRYPT("Enabled Kill Message"), &KillMessage);
    ImGui::SameLine();
    Checkbox(ENCRYPT("Enabled DeadBox"), &DeadBox);
    
    Checkbox(ENCRYPT("Enabled X-Suits"), &preferences.Outfit);
    if (preferences.Outfit) {
        if (SliderInt(ENCRYPT("X-Suits"), &preferences.Config.Skin.XSuits, 0, 21)) {
            if (prevXSuits != preferences.Config.Skin.XSuits) {
                callFunction = true;
                prevXSuits = preferences.Config.Skin.XSuits;
            }
        }
    }
    Checkbox(ENCRYPT("Enabled Face"), &preferences.Face);
    if (preferences.Face) SliderInt(ENCRYPT("Face"), &preferences.Config.Skin.XSuits, 0, 21);
    Checkbox(ENCRYPT("Enabled Bag"), &preferences.Bagg);
    if (preferences.Bagg) SliderInt(ENCRYPT("Bag"), &preferences.bag, 0, 9);
    Checkbox(ENCRYPT("Enabled Helmet"), &preferences.Helmett);
    if (preferences.Helmett) SliderInt(ENCRYPT("Helmet"), &preferences.helmet, 0, 8);
    Checkbox(ENCRYPT("Enabled Emote"), &preferences.Emote);
    if (preferences.Emote) SliderInt(ENCRYPT("Emote"), &ModEmote1, 0, 8);
    Checkbox(ENCRYPT("Enabled Parachute"), &preferences.Parachute);
    if (preferences.Parachute) SliderInt(ENCRYPT("Parachute"), &preferences.Config.Skin.Parachute, 0, 16);
    
    
    ENCRYPT("Weapons"), ImVec2(GetWindowWidth(), GetWindowHeight()); {
        
        Checkbox(ENCRYPT("Enabled M416"), &preferences.M416);
        if (preferences.M416) SliderInt(ENCRYPT("M416"), &preferences.Config.Skin.M416, 0, 10);
        
        Checkbox(ENCRYPT("Enabled AKM"), &preferences.AKM);
        if (preferences.AKM) SliderInt(ENCRYPT("AKM"), &preferences.Config.Skin.AKM, 0, 10);
        
        Checkbox(ENCRYPT("Enabled SCAR-L"), &preferences.SCARL);
        if (preferences.SCARL) SliderInt(ENCRYPT("SCAR-L"), &preferences.Config.Skin.Scar, 0, 10);
        
        Checkbox(ENCRYPT("Enabled M762"), &preferences.M762);
        if (preferences.M762) SliderInt(ENCRYPT("M762"), &preferences.Config.Skin.M762, 0, 8);
        Checkbox(ENCRYPT("Enabled Groza"), &preferences.GROZA);
        if (preferences.GROZA) SliderInt(ENCRYPT("Groza"), &preferences.Config.Skin.Groza, 0, 6);
        
        Checkbox(ENCRYPT("Enabled AUG"), &preferences.AUG);
        if (preferences.AUG) SliderInt(ENCRYPT("AUG"), &preferences.Config.Skin.AUG, 0, 3);
        
        Checkbox(ENCRYPT("Enabled M16A4"), &preferences.M16);
        if (preferences.M16) SliderInt(ENCRYPT("M16A4"), &preferences.Config.Skin.M16A4, 0, 5);
        
        Checkbox(ENCRYPT("Enabled ACE32"), &preferences.ACE32);
        if (preferences.ACE32) SliderInt(ENCRYPT("ACE32"), &preferences.Config.Skin.ACE32, 0, 2);
        
        Checkbox(ENCRYPT("Enabled Kar98-k"), &preferences.KAR98);
        if (preferences.KAR98) SliderInt(ENCRYPT("Kar98-k"), &preferences.Config.Skin.K98, 0, 6);
        
        Checkbox(ENCRYPT("Enabled M24"), &preferences.M24);
        if (preferences.M24) SliderInt(ENCRYPT("M24"), &preferences.Config.Skin.M24, 0, 5);
        
        Checkbox(ENCRYPT("Enabled AWM"), &preferences.AWM);
        if (preferences.AWM) SliderInt(ENCRYPT("AWM"), &preferences.Config.Skin.AWM, 0, 5);
        
        Checkbox(ENCRYPT("Enabled DP28"), &preferences.DP28);
        if (preferences.DP28) SliderInt(ENCRYPT("DP28"), &preferences.Config.Skin.DP28, 0, 4);
        
        Checkbox(ENCRYPT("Enabled M249"), &preferences.M249);
        if (preferences.M249) SliderInt(ENCRYPT("M249"), &preferences.Config.Skin.M249, 0, 4);
        
        Checkbox(ENCRYPT("Enabled UZI"), &preferences.UZI);
        if (preferences.UZI) SliderInt(ENCRYPT("UZI"), &preferences.Config.Skin.UZI, 0, 6);
        
        Checkbox(ENCRYPT("Enabled UMP-45"), &preferences.UMP);
        if (preferences.UMP) SliderInt(ENCRYPT("UMP-45"), &preferences.Config.Skin.UMP, 0, 7);
        
        Checkbox(ENCRYPT("Enabled Tommy"), &preferences.TOMMY);
        if (preferences.TOMMY) SliderInt(ENCRYPT("Tommy"), &preferences.Config.Skin.Thompson, 0, 2);
        
        Checkbox(ENCRYPT("Enabled Vector"), &preferences.VECTOR);
        if (preferences.VECTOR) SliderInt(ENCRYPT("Vector"), &preferences.Config.Skin.Vector, 0, 4);
        
        Checkbox(ENCRYPT("Enabled Bizon"), &preferences.BIZON);
        if (preferences.BIZON) SliderInt(ENCRYPT("Bizon"), &preferences.Config.Skin.Bizon, 0, 3);
        
        Checkbox(ENCRYPT("Enabled Pan"), &preferences.PAN);
        if (preferences.PAN) SliderInt(ENCRYPT("Pan"), &preferences.Config.Skin.Pan, 0, 9);
        
        ImGui::Separator();
        
        (ENCRYPT("Vehicle"), ImVec2(GetWindowWidth(), GetWindowHeight())); {
            
            Checkbox(ENCRYPT("Enabled Dacia"), &preferences.Dacia);
            if (preferences.Dacia) SliderInt(ENCRYPT("Dacia"), &preferences.Config.Skin.Dacia, 0, 21);
            
            Checkbox(ENCRYPT("Enabled Coupe RB"), &preferences.CoupeRB);
            if (preferences.CoupeRB) SliderInt(ENCRYPT("Coupe RB"), &preferences.Config.Skin.CoupeRP, 0, 42);
            
            Checkbox(ENCRYPT("Enabled UAZ"), &preferences.UAZ);
            if (preferences.UAZ) SliderInt(ENCRYPT("UAZ"), &preferences.Config.Skin.UAZ, 0, 17);
            
            Checkbox(ENCRYPT("Enabled MotoBike"), &preferences.Moto);
            if (preferences.Moto) SliderInt(ENCRYPT("MotoBike"), &preferences.Config.Skin.Moto, 0, 9);
            
            Checkbox(ENCRYPT("Enabled BigFoot"), &preferences.BigFoot);
            if (preferences.BigFoot) SliderInt(ENCRYPT("BigFoot"), &preferences.Config.Skin.Bigfoot, 0, 1);
            
            Checkbox(ENCRYPT("Enabled Mirado"), &preferences.Mirado);
            if (preferences.Mirado) SliderInt(ENCRYPT("Mirado"), &preferences.Config.Skin.Mirado, 0, 1);
            
            Checkbox(ENCRYPT("Enabled Buggy"), &preferences.Buggy);
            if (preferences.Buggy) SliderInt(ENCRYPT("Buggy"), &preferences.Config.Skin.Buggy, 0, 37);
            
            Checkbox(ENCRYPT("Enabled MiniBus"), &preferences.MiniBus);
            if (preferences.MiniBus) SliderInt(ENCRYPT("MiniBus"), &preferences.Config.Skin.MiniBus, 0, 12);
            
            Checkbox(ENCRYPT("Enabled PG-117"), &preferences.Boat);
            if (preferences.Boat) SliderInt(ENCRYPT("PG-117"), &preferences.Config.Skin.Boat, 0, 11);
        }
    }
}
    

-(void)readIniConfig{
    self.moduleControl->fps = configManager::readInteger(config,"mainSwitch", "fps", 0);
    switch(self.moduleControl->fps){
        case 0:
            overlayView.preferredFramesPerSecond = 60;
            break;
        case 1:
            overlayView.preferredFramesPerSecond = 90;
            break;
        case 2:
            overlayView.preferredFramesPerSecond = 120;
            break;
        default:
            overlayView.preferredFramesPerSecond = 60;
            break;
    }
    self.moduleControl->mainSwitch.hide = configManager::readBoolean(config, "mainSwitch", "gzb", false);
    //主开关
    self.moduleControl->mainSwitch.playerStatus = configManager::readBoolean(config,"mainSwitch", "player", false);
    self.moduleControl->mainSwitch.materialStatus = configManager::readBoolean(config,"mainSwitch", "material", false);
    self.moduleControl->mainSwitch.aimbotStatus = configManager::readBoolean(config,"mainSwitch", "aimbot", false);

    //人物开关
    for (int i = 0; i < 10; ++i) {
        std::string str = "playerSwitch_" + std::to_string(i);
        *((bool *) &self.moduleControl->playerSwitch + sizeof(bool) * i) = configManager::readBoolean(config,"playerSwitch", str.c_str(), false);
    }
    //雷达坐标
    self.moduleControl->playerSwitch.radarSize = configManager::readFloat(config,"playerSwitch", "radarSize", 70);
    self.moduleControl->playerSwitch.radarCoord.x = configManager::readFloat(config,"playerSwitch", "radarX", 500);
    self.moduleControl->playerSwitch.radarCoord.y = configManager::readFloat(config,"playerSwitch", "radarY", 500);
    //物资开关
    for (int i = 0; i < All; ++i) {
        std::string str = "materialSwitch_" + std::to_string(i);
        self.moduleControl->materialSwitch[i] = configManager::readBoolean(config,"materialSwitch", str.c_str(), false);
    }
    //倒地不瞄
    self.moduleControl->aimbotController.fallNotAim = configManager::readBoolean(config,"aimbotControl", "fall", false);
    self.moduleControl->aimbotController.showAimbotRadius = configManager::readBoolean(config,"aimbotControl", "showRadius", true);
    self.moduleControl->aimbotController.aimbotRadius = configManager::readFloat(config,"aimbotControl", "radius", 500);
    
    self.moduleControl->aimbotController.smoke = configManager::readBoolean(config,"aimbotControl", "smoke", true);
    
    //自瞄模式
    self.moduleControl->aimbotController.aimbotMode = configManager::readInteger(config,"aimbotControl", "mode", 0);
    //自瞄部位
    self.moduleControl->aimbotController.aimbotParts = configManager::readInteger(config,"aimbotControl", "parts", 0);
    //自瞄强度
    aimbotIntensity = configManager::readInteger(config,"aimbotControl", "intensity", 2);
    switch (aimbotIntensity) {
        case 0:
            self.moduleControl->aimbotController.aimbotIntensity = 0.1f;
            break;
        case 1:
            self.moduleControl->aimbotController.aimbotIntensity = 0.2f;
            break;
        case 2:
            self.moduleControl->aimbotController.aimbotIntensity = 0.3f;
            break;
        case 3:
            self.moduleControl->aimbotController.aimbotIntensity = 0.4f;
            break;
        case 4:
            self.moduleControl->aimbotController.aimbotIntensity = 0.5f;
            break;
        case 5:
            self.moduleControl->aimbotController.aimbotIntensity = 1.0f;
            break;
        case 6:
            self.moduleControl->aimbotController.aimbotIntensity = 1.2f;
            break;
    }
    //自瞄距离
    self.moduleControl->aimbotController.distance = configManager::readFloat(config,"aimbotControl", "distance", 300);
}




@end

