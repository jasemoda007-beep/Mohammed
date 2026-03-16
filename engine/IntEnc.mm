//
//Pubg 2.5 GL
//
// Created by Saudgl on 3/22/23.
// Updated 15/7/2023

#import "JHCJDrawView.h"
//#import "ITSVIEW.h"
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>
#import <stdio.h>
#import <mach-o/dyld.h>
#import <mach/vm_region.h>
#import <malloc/malloc.h>
#import <objc/runtime.h>
#import <mach/mach.h>
#include "string.h"
#import <sys/socket.h>
#import <Foundation/Foundation.h>
#import <mach/mach_traps.h>
#include <math.h>

#import <array>
#include "Tools.h"
#include <cstdint>
#include <string>
#include <iterator>
#include <iostream>
#include <algorithm>
#include <vector>
#include <array>
#include "Vector3.hpp"
#include "Vector2.hpp"
extern bool overlay;
#include "UE4.h"

#import "CountDownTDM.h"
//#import "ITSVIEW.h"
#include <codecvt>
#include <locale>
#include "obfuscate.h"
#include "ne_null09.h"
#include "expermant.h"

#include <assert.h>
#define IM_ASSERT(_EXPR)assert(_EXPR)
#define kLogOpen 1
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define timer(sec) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, sec * NSEC_PER_SEC), dispatch_get_main_queue(), ^

#define E(str) _xor_(str).c_str()

#define iPhone8P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

/*uint64_t GUObjectArray;
uint64_t GNameFun;*/

//  GL 3.5
//#define gName
//#define gObject

NSString *bundle;
uint64_t GUObjectArray;
uint64_t GNameFun;


@interface JHCJDrawView()
@property (nonatomic,  weak) NSTimer *timer;
@property (nonatomic,  assign) NSInteger aimcir;
@property (nonatomic,  assign) NSInteger rpr;
@end
BOOL BULLETIBOTNO =true;
BOOL BUlletvisabuilty =false;
UIWindow *mainwin;
@implementation JHCJDrawView
static JHCJDrawView *extraInfo;
+ (instancetype)cjDrawView
{
    return [[JHCJDrawView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        _aimcir= 50;
        _rpr= 50;
        //NSInteger myInteger = 42;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rectChange:) name:@"AimRadiusNoti" object:nil];
        [
            [NSNotificationCenter defaultCenter] addObserverForName: @"AimRadiusNoti"
            object: nil
            queue: nil
            usingBlock: ^ (NSNotification * note) {
            }
        ];
    }
    return self;
}
- (void)rectChange:(NSNotification *)noti
{
    NSInteger val = [noti.object integerValue];
    _aimcir = val;
    _rpr = (int) val;
    _rpr = val;
}

static uintptr_t Get_module_base() {
    uint32_t count = _dyld_image_count();
    for (int i = 0; i < count; i++) {
        std::string path = (const char *)_dyld_get_image_name(i);
        if (path.find("ShadowTrackerExtra.app/ShadowTrackerExtra") != path.npos) {
            return (uintptr_t)_dyld_get_image_vmaddr_slide(i);
        }
    }
    return 0;
}

bool IsValidAddress(kaddr addr) {
    return addr > 0x100000000 && addr < 0x2000000000;
}

//hook no jb
bool anti1 =false;
bool anti2 =false;
bool anti3 =false;
bool anti4 =false;
extern bool TeleportEnemy;
extern float AimSpeed;

bool giamgiat = false;

bool init1 = false;
bool init2 = false;
bool init3 = false;
bool init4 = false;
bool init5 = false;
extern bool WideView;
extern int WideValue;
namespace menu {
    namespace ESP {
        extern bool ESPBox;
        extern bool ESPLine;
        extern bool ESPSkeleton;
        extern bool skipAI;
        extern bool outoffov;
        extern bool boxOutline;
        extern bool textOutline;
        extern bool health;
        extern bool weapon;
        extern bool teamID;
        extern bool name;
        extern bool distance;
        extern bool NOUSECRASH;
        extern bool ipadview;
        extern int viewvalue;
        extern bool ESPMob;
    }
    namespace aimbot {
        extern bool enable;
        extern bool skipKnock;
        extern bool skipAI;
        extern int target;
        extern int trigger;
        extern float smooth;
        extern float v_recoil;
        extern float aimfov;
        extern bool visCheck;
        extern float distances;
        extern bool ReCo;
        extern float Recc;
    }
    namespace silent {
        extern bool enable;
        extern bool Prediction;
        extern bool BulletTrack;
        extern bool visCheck;
        extern bool skipAI;
        extern bool skipKnock;
        extern float distance;
        extern float silfov;
        extern int target;
        extern int trigger;
    }
    namespace memory {
        extern bool xhit;
        extern bool noshake;
        extern bool norecoil;
        extern bool rapidfire;
        extern bool crosshair;
        extern bool rapidshoot;
    }
}

int name_pos = 7;
int distance_pos = 17;
int weap_pos = 7;
float ESP_scale = 12.f;

uintptr_t UE4;
kaddr module= (unsigned long)Get_module_base();

extern bool ModSkinn;
extern bool KillMessage;
extern bool DeadBox;

static bool callFunction = false;
static int helmett3 = 1;
static int bag3 = 1;
int sEmote1 = 2200101;
int sEmote2 = 2200201;
int sEmote3 = 2200301;
extern int ModEmote1;
namespace Active {
  inline int SkinCarDefault = 0;
  inline int SkinCarMod = 0;
  inline int SkinCarNew = 0;
}
UISlider * Auto1;//autofire
UISlider * Auto1Interval;//autofire interval
UISlider * sliderrr;//aimpos
extern float TurnRate; //No scope turn rate - aim speed
extern float NoScopeAimDisSliderVal;
extern float HiddenFOVSliderVal;// with scope Filed of view slider value /NOT ACTIVE/
extern float NoScopeFOVSliderVal;//No scope FOV size slider value
//Slider_Sniper * Aimbot1;//fov
//extern float FovRadousVal;
UISlider * aimspeed;//aimbot speed
CGSize AutoFireCircelSize;// CGSizeMake(w, h);
bool IsAirDrop = false;
int Interval = 1;
int counter;
int iAwareTexSiz = 20;
bool iAwareText = true;
int EspTextSiz = 9;
float EspBoxThik = 2.0f;
float EspSktonThik = 1.5f;
float IsfovSlider = 150.0f;
float AimSmooth = 5.0f;
bool AimTouch = false;
bool antibypass = false;
//UISlider * Aimbot2;
//aimbot bool
extern float g_disstance;


int boxtype = 1;
int healthbartype = 0;
int Nationtype = 2;
int DirectionLineSize = 70;
int VehicleDirectionLineSize = 100;
int offscreen_range = 40;
int max_distance_offscreen = 400;
int playersdistancessize = 600;
bool esp_Outline = true;
int distance_Radar = 150;

uintptr_t ProcessEvent_Offset,AimBullet_Offset,AimBullet_Offset2,SetControlRotation_Offset;
#define SLEEP_TIME 1000LL / 60LL
#define TORAD(x) ((x) * (M_PI / 180.f))
int g_screenWidth ;
int g_screenHeight ;
int screenWidth ;
int screenHeight ;
int screenDensity = 0;
int getEspFramerate;
int SCOLOR;
int scc;


char extra[30];
float density = -1;
float gDistance;
int localFiring{0};
BOOL kaiguan1 = NO;
BOOL kaiguan2 = NO;
BOOL kaiguan3 = NO;
BOOL kaiguan4 = NO;
#define PI 3.14159265358979323846
#define __fastcall
bool ARWP = false;
bool SMGWP =false;
bool SNPWP = false;
bool otherWP =false;
bool AmmoWP =false;
bool LIGHTMW = false;
bool SHOTGUNWP = false;
bool scopewp = false;
bool POSTOLWP = false;
bool ARMORWP =false;
//extern float FovRadousVal;
float IsAimBotRecc = 1.183f;
bool IsRecoilComparison = false;
static int Istargets = 2;

static int loaixe = 0;
static int xedacia = 0;
bool modxe = false;
bool tamnho = false;

//hiệu ứng bắn
bool effectm44 = false;

float dorong = 88.0f;

float IsDistance = 68;
/*
float add() // circle radius size
{
   // if(FovRadousVal==0){
    float FovRadousVal = 230;
    
    return FovRadousVal;
}
*/

float aimspeedsl()
{
    // return aimspeed.value;
    float val1 = 20;//50
    //return TurnRate;// aim speed from slider
    return val1;
}
int aimpos()
{
    float speedVal = 25;//100
    //return sliderrr.value;//maybe speed
    return speedVal;
}
int autodiss()
{
    return Auto1.value;
}

static auto start = std::chrono::steady_clock::now();
static auto noww = std::chrono::high_resolution_clock::now();
auto elapsedd = std::chrono::duration_cast<std::chrono::milliseconds>(noww - start).count();
namespace Settings
{
    static int Tab = 0;
}
int newUAZID = 0;
int lastUAZID = 0;
int newDaciaID = 0;
int lastDaciaID = 0;
int newCoupeID = 0;
int lastCoupeID = 0;
struct snew_Skin {
  int XSuits = 403003;
  int XSuits1 = 40604002;
  int Balo1 = 501001;
  int Balo2 = 501002;
  int Balo3 = 501003;
  int Balo4 = 501004;
  int Balo5 = 501005;
  int Balo6 = 501006;
  int Helmet1 = 502001;
  int Helmet2 = 502002;
  int Helmet3 = 502003;
  int Helmet4 = 502004;
  int Helmet5 = 502005;

  int Helmet6 = 502114;
  int Helmet7 = 502115;
  int Helmet8 = 502116;
  int Parachute = 703001;

  int AKM = 101001;
  int AKM_Mag = 291001;
  int M16A4 = 101002;
  int M16A4_Stock = 205007;
  int M16A4_Mag = 291002;
  int Scar = 101003;
  int Scar_Mag = 291003;
  int Pan = 108004;

  int M416_1 = 101004;
  int M416_2 = 291004;
  int M416_3 = 203008;
  int M416_4 = 205005;
  int M416_flash = 201010;
  int M416_compe = 201009;
  int M416_silent = 201011;
  int M416_reddot = 203001;
  int M416_holo = 203001;
  int M416_x2 = 203003;
  int M416_x3 = 203014;
  int M416_x4 = 203004;
  int M416_x6 = 203015;
  int M416_quickMag = 204012;
  int M416_extendedMag = 204011;
  int M416_quickNextended = 204013;
  int M416_stock = 205002;
  int M416_verical = 203015;
  int M416_angle = 202001;
  int M416_lightgrip = 202004;
  int M416_pink = 202005;
  int M416_lazer = 202007;
  int M416_thumb = 202006;

  int Groza = 101005;
  int QBZ = 101007;
  int AUG = 101006;
  int M762 = 101008;
  int M762_Mag = 291008;
  int ACE32 = 101102;
  int Honey = 101012;
  int UZI = 102001;
  int UMP = 102002;
  int Vector = 102003;
  int Thompson = 102004;
  int Bizon = 102005;
  int K98 = 103001;
  int M24 = 103002;
  int AWM = 103003;
  int AMR = 103012;
  int VSS = 103005;
  int SKS = 103004;
  int Mini14 = 103006;
  int MK14 = 103007;
  int SLR = 103009;
  int S1897 = 104002;
  int DP28 = 105002;
  int M249 = 105001;
  int MG3 = 105010;
  int Skorpion = 106008;
  int Moto = 1901001;
  int CoupeRP = 1961001;
  int Dacia = 1903001;
  int UAZ = 1908001;
  int Bigfoot = 1953001;
  int Mirado = 1914004;
  int OMirado = 1915001;
  int Buggy = 1907001;
  int MiniBus = 1904001;
  int Boat = 1911001;
  int M249s = 205009;
};

inline snew_Skin new_Skin;



std::chrono::steady_clock::time_point lastChangeTime;
std::chrono::steady_clock::time_point lastWeaponChangeTime;
void updateSkin() {
if (preferences.bag == 1)
                    bag3 = 1501003174; //blood raven x suit
                    if (preferences.bag == 2)
                    bag3 = 1501003220; //Golden Pharaoh X-Suit
                    if (preferences.bag == 3)
                    bag3 = 1501003051; //Avalanche
                    if (preferences.bag == 4)
                    bag3 = 1501003443; //Irresidence
                    if (preferences.bag == 5)
                    bag3 = 1501003265; //Poseidon
                    if (preferences.bag == 6)
                    bag3 = 1501003321; //Arcane Jester X-suit
                    if (preferences.bag == 7)
                    bag3 = 1501003277; //Silvanus X-Suit
                    if (preferences.bag == 8)
                    bag3 = 1501003550;
                    if (preferences.bag == 9)
                    bag3 = 1501003550;
                    if (preferences.xsuit == 10)
                    bag3 = 0;
                    if (preferences.xsuit == 11)
                    bag3 = 0;
                    if (preferences.xsuit == 12)//todo
                    bag3 = 0;
                    //Helmet
                    if (preferences.helmet == 1)
                    helmett3 = 1502003014; //blood raven x suit
                    if (preferences.helmet == 2)
                    helmett3 = 1502003028; //Golden Pharaoh X-Suit
                    if (preferences.helmet == 3)
                    helmett3 = 1502003023; //Avalanche
                    if (preferences.helmet == 4)
                    helmett3 = 1501002443; //Irresidence
                    if (preferences.helmet == 5)
                    helmett3 = 1502003031; //Poseidon
                    if (preferences.helmet == 6)
                    helmett3 = 1502003033; //Arcane Jester X-suit
                    if (preferences.helmet == 7)
                    helmett3 = 1502003069; //Silvanus X-Suit
                    if (preferences.helmet == 8)
                    helmett3 = 1502003069;
                    if (preferences.helmet == 8)
                    helmett3 = 1502003261;
                    if (preferences.xsuit == 10)
                    helmett3 = 0;
                    if (preferences.xsuit == 11)
                    helmett3 = 0;
                    if (preferences.xsuit == 12)//todo
                    helmett3 = 0;
                    
if (ModEmote1 == 0)
sEmote1 = 2200101;
if (ModEmote1 == 1)
sEmote1 = 12220023;
if (ModEmote1 == 2)
sEmote1 = 12219677;
if (ModEmote1 == 3)
sEmote1 = 12219716;
if (ModEmote1 == 4)
sEmote1 = 12209401;
if (ModEmote1 == 5)
sEmote1 = 12209501;
if (ModEmote1 == 6)
sEmote1 = 12209701;
if (ModEmote1 == 7)
sEmote1 = 12209801;
if (ModEmote1 == 8)
sEmote1 = 12209901;


if (ModEmote1 == 0)
sEmote2 = 2200201;
if (ModEmote1 == 1)
sEmote2 = 12210201;
if (ModEmote1 == 2)
sEmote2 = 12210601;
if (ModEmote1 == 3)
sEmote2 = 12220028;
if (ModEmote1 == 4)
sEmote2 = 12219819;
if (ModEmote1 == 5)
sEmote2 = 12211801;
if (ModEmote1 == 6)
sEmote2 = 12212001;
if (ModEmote1 == 7)
sEmote2 = 12212201;
if (ModEmote1 == 8)
sEmote2 = 12212401;


if (ModEmote1 == 0)
sEmote3 = 2200301;
if (ModEmote1 == 1)
sEmote3 = 12212601;
if (ModEmote1 == 2)
sEmote3 = 12213201;
if (ModEmote1 == 3)
sEmote3 = 12219715;
if (ModEmote1 == 4)
sEmote3 = 12219814;
if (ModEmote1 == 5)
sEmote3 = 12213601;
if (ModEmote1 == 6)
sEmote3 = 12213801;
if (ModEmote1 == 7)
sEmote3 = 12214001;
if (ModEmote1 == 8)
sEmote3 = 12214201;



  if (preferences.Config.Skin.Parachute == 0)
    new_Skin.Parachute = 703001;
  if (preferences.Config.Skin.Parachute == 16)
    new_Skin.Parachute = 1401619; //Pharaoh's Scarab Parachute
  if (preferences.Config.Skin.Parachute == 1)
    new_Skin.Parachute = 1401619; //Pharaoh's Scarab Parachute
  if (preferences.Config.Skin.Parachute == 2)
    new_Skin.Parachute = 1401625; // Enigmatic Nomad Parachute
  if (preferences.Config.Skin.Parachute == 3)
    new_Skin.Parachute = 1401624; //parashot Parachute
  if (preferences.Config.Skin.Parachute == 4)
    new_Skin.Parachute = 1401836; //Paperfold Gambit Parachute
  if (preferences.Config.Skin.Parachute == 5)
    new_Skin.Parachute = 1401833; //Labyrinth Beast Parachute
  if (preferences.Config.Skin.Parachute == 6)
    new_Skin.Parachute = 1401287; //Flamewraith Parachute
  if (preferences.Config.Skin.Parachute == 7)
    new_Skin.Parachute = 1401282; //Mega Kitty Parachute
  if (preferences.Config.Skin.Parachute == 8)
    new_Skin.Parachute = 1401385; //Mega Yeti Parachute
  if (preferences.Config.Skin.Parachute == 9)
    new_Skin.Parachute = 1401549; //Endless Glory Parachute
  if (preferences.Config.Skin.Parachute == 10)
    new_Skin.Parachute = 1401336; //Magma Skull Parachute
  if (preferences.Config.Skin.Parachute == 11)
    new_Skin.Parachute = 1401335; //Aquatic Fury Parachute
  if (preferences.Config.Skin.Parachute == 12)
    new_Skin.Parachute = 1401629; //CyberGen: Zero Parachute
  if (preferences.Config.Skin.Parachute == 13)
    new_Skin.Parachute = 1401628; //Radiant Phoenix Adarna Parachute
  if (preferences.Config.Skin.Parachute == 14)
    new_Skin.Parachute = 1401615; //Will of Horus
  if (preferences.Config.Skin.Parachute == 15)
    new_Skin.Parachute = 1401613; //Anubian Magistrate Parachute

  if (preferences.Config.Skin.Pan == 0)
    new_Skin.Pan = 108004; // 108004 - Pan
  if (preferences.Config.Skin.Pan == 1)
    new_Skin.Pan = 1108004125; // Honeypot - Pan
  if (preferences.Config.Skin.Pan == 2)
    new_Skin.Pan = 1108004145; // Night of Rock - Pan
  if (preferences.Config.Skin.Pan == 3)
    new_Skin.Pan = 1108004160; // Crocodile - Pan
  if (preferences.Config.Skin.Pan == 4)
    new_Skin.Pan = 1108004283; // Accolade - Pan
  if (preferences.Config.Skin.Pan == 5)
    new_Skin.Pan = 1108004337; // Break Pad - Pan
  if (preferences.Config.Skin.Pan == 6)
    new_Skin.Pan = 1108004356; // Chicken Hot - Pan
  if (preferences.Config.Skin.Pan == 7)
    new_Skin.Pan = 1108004365; // Faerie Luster - Pan
  if (preferences.Config.Skin.Pan == 8)
    new_Skin.Pan = 1108004054; // Chicken Hot - Pan
  if (preferences.Config.Skin.Pan == 9)
    new_Skin.Pan = 1108004008;
    
    
  if (preferences.Config.Skin.XSuits == 0) {
    new_Skin.XSuits = 403003;
    new_Skin.XSuits1 = 40604002;
  }
  if (preferences.Config.Skin.XSuits == 1) {
    new_Skin.XSuits = 1405628;
    new_Skin.XSuits1 = 1402578;
  }
  if (preferences.Config.Skin.XSuits == 2) {
    new_Skin.XSuits = 1405870;
    new_Skin.XSuits1 = 1403257;
  }
  if (preferences.Config.Skin.XSuits == 3) {
    new_Skin.XSuits = 1405983;
    new_Skin.XSuits1 = 1402874;
  }
  if (preferences.Config.Skin.XSuits == 4) {
    new_Skin.XSuits = 1406152;
    new_Skin.XSuits1 = 1403393;
  }
  if (preferences.Config.Skin.XSuits == 5) {
    new_Skin.XSuits = 1406311;
    new_Skin.XSuits1 = 1410011; //Mặt nạ 1.403.414
  }
  if (preferences.Config.Skin.XSuits == 6) {
    new_Skin.XSuits = 1406475;
    new_Skin.XSuits1 = 1410131;
  }
  if (preferences.Config.Skin.XSuits == 7) {
    new_Skin.XSuits = 1406638;
    new_Skin.XSuits1 = 1410242;
  }
  if (preferences.Config.Skin.XSuits == 8) {
    new_Skin.XSuits = 1406872;
    //new_Skin.XSuits1 = 1410346; // khung
    new_Skin.XSuits1 = 402133;
  }
  if (preferences.Config.Skin.XSuits == 9) {
    new_Skin.XSuits = 1406971;
    new_Skin.XSuits1 = 402147;
  }
  if (preferences.Config.Skin.XSuits == 10) {
    new_Skin.XSuits = 1407103;
    new_Skin.XSuits1 = 40604002;
  }
  if (preferences.Config.Skin.XSuits == 11) {
    new_Skin.XSuits = 1405174;
    new_Skin.XSuits1 = 40604012;
  }
  if (preferences.Config.Skin.XSuits == 12) {
    new_Skin.XSuits = 1407195;
  }
  if (preferences.Config.Skin.XSuits == 13) {
    new_Skin.XSuits = 1407194;
    new_Skin.XSuits1 = 1410436;
  }
if (preferences.Config.Skin.XSuits == 14) {
    new_Skin.XSuits = 1406891;
  }
  if (preferences.Config.Skin.XSuits == 15) {
    new_Skin.XSuits = 1400687;
  }
  if (preferences.Config.Skin.XSuits == 16) {
    new_Skin.XSuits = 1407196;
  }
  if (preferences.Config.Skin.XSuits == 17) {
    new_Skin.XSuits = 1407049;
  }
  if (preferences.Config.Skin.XSuits == 18) {
    new_Skin.XSuits = 1406897;
  }
  
  if (preferences.Config.Skin.XSuits == 19) {
    new_Skin.XSuits = 1406892;
  }
  if (preferences.Config.Skin.XSuits == 20) {
    new_Skin.XSuits = 1407049;
  }
  if (preferences.Config.Skin.XSuits == 21) {
    new_Skin.XSuits = 1407188;
  }
  
  

  if (preferences.Config.Skin.AKM == 0) {
    new_Skin.AKM = 101001;
    new_Skin.AKM_Mag = 205005;
  }
  if (preferences.Config.Skin.AKM == 1) {
    new_Skin.AKM = 1101001089;
    new_Skin.AKM_Mag = 1010010891;
  }
  if (preferences.Config.Skin.AKM == 2) {
    new_Skin.AKM = 1101001103;
    new_Skin.AKM_Mag = 1010011031;
  }
  if (preferences.Config.Skin.AKM == 3) {
    new_Skin.AKM = 1101001116;
    new_Skin.AKM_Mag = 1010011161;
  }
  if (preferences.Config.Skin.AKM == 4) {
    new_Skin.AKM = 1101001128;
    new_Skin.AKM_Mag = 1010011281;
  }
  if (preferences.Config.Skin.AKM == 5) {
    new_Skin.AKM = 1101001143;
    new_Skin.AKM_Mag = 1010011431;
  }
  if (preferences.Config.Skin.AKM == 6) {
    new_Skin.AKM = 1101001154;
    new_Skin.AKM_Mag = 1010011541;
  }
  if (preferences.Config.Skin.AKM == 7) {
    new_Skin.AKM = 1101001174;
    new_Skin.AKM_Mag = 1010011741;
  }
  if (preferences.Config.Skin.AKM == 8) {
    new_Skin.AKM = 1101001213;
    new_Skin.AKM_Mag = 1010012131;
  }
  if (preferences.Config.Skin.AKM == 9) {
    new_Skin.AKM = 1101001231;
    new_Skin.AKM_Mag = 1010012311;
  }
  if (preferences.Config.Skin.AKM == 10) {
    new_Skin.AKM = 1101001242;
    new_Skin.AKM_Mag = 1010012421;
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  if (preferences.Config.Skin.M16A4 == 0) {
    new_Skin.M16A4 = 101002;
    new_Skin.M16A4_Stock = 205007;
    new_Skin.M16A4_Mag = 291002;
  }
  if (preferences.Config.Skin.M16A4 == 1) {
    new_Skin.M16A4 = 1101002029;
    new_Skin.M16A4_Stock = 1010020292;
    new_Skin.M16A4_Mag = 1010020291;
  }
  if (preferences.Config.Skin.M16A4 == 2) {
    new_Skin.M16A4 = 1101002056;
    new_Skin.M16A4_Stock = 1010020562;
    new_Skin.M16A4_Mag = 1010020561;
  }
  if (preferences.Config.Skin.M16A4 == 3) {
    new_Skin.M16A4 = 1101002068;
    new_Skin.M16A4_Stock = 1010020682;
    new_Skin.M16A4_Mag = 1010020681;
  }
  if (preferences.Config.Skin.M16A4 == 4) {
    new_Skin.M16A4 = 1101002081;
    new_Skin.M16A4_Stock = 1010020812;
    new_Skin.M16A4_Mag = 1010020811;
  }
  if (preferences.Config.Skin.M16A4 == 5) {
    new_Skin.M16A4 = 1101002103;
    new_Skin.M16A4_Stock = 1010021032;
    new_Skin.M16A4_Mag = 1010021031;
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.Scar == 0) {
    new_Skin.Scar = 101003;
    new_Skin.Scar_Mag = 291003;
  }
  if (preferences.Config.Skin.Scar == 1) {
    new_Skin.Scar = 1101003057;
    new_Skin.Scar_Mag = 1010030571;
  }
  if (preferences.Config.Skin.Scar == 2) {
    new_Skin.Scar = 1101003070;
    new_Skin.Scar_Mag = 1010030701;
  }
  if (preferences.Config.Skin.Scar == 3) {
    new_Skin.Scar = 1101003080;
    new_Skin.Scar_Mag = 1010030801;
  }
  if (preferences.Config.Skin.Scar == 4) {
    new_Skin.Scar = 1101003119;
    new_Skin.Scar_Mag = 1010031191;
  }
  if (preferences.Config.Skin.Scar == 5) {
    new_Skin.Scar = 1101003146;
    new_Skin.Scar_Mag = 1010031461;
  }
  if (preferences.Config.Skin.Scar == 6) {
    new_Skin.Scar = 1101003167;
    new_Skin.Scar_Mag = 1010031671;
  }
  if (preferences.Config.Skin.Scar == 7) {
    new_Skin.Scar = 1101003181;
    new_Skin.Scar_Mag = 1010031811;
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // if (preferences.Config.Skin.Scar == 0) {
  //   new_Skin.Scar = 101003;
  //   new_Skin.Scar_Mag = 291003;
  // }
  // if (preferences.Config.Skin.Scar == 1) {
  //   new_Skin.Scar = 1101003057;
  //   new_Skin.Scar_Mag = 1010030571;
  // }
  // if (preferences.Config.Skin.Scar == 2) {
  //   new_Skin.Scar = 1101003070;
  //   new_Skin.Scar_Mag = 1010030701;
  // }
  // if (preferences.Config.Skin.Scar == 3) {
  //   new_Skin.Scar = 1101003080;
  //   new_Skin.Scar_Mag = 1010030801;
  // }
  // if (preferences.Config.Skin.Scar == 4) {
  //   new_Skin.Scar = 1101003119;
  //   new_Skin.Scar_Mag = 1010031191;
  // }
  // if (preferences.Config.Skin.Scar == 5) {
  //   new_Skin.Scar = 1101003146;
  //   new_Skin.Scar_Mag = 1010031461;
  // }
  // if (preferences.Config.Skin.Scar == 6) {
  //   new_Skin.Scar = 1101003167;
  //   new_Skin.Scar_Mag = 1010031671;
  // }
  // if (preferences.Config.Skin.MK14 == 7) {
  //   new_Skin.MK14 = 10300700;
  //   new_Skin.MK14_Skin = 1103007028;
  // }

  // int MK14 = 103007;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  if (preferences.Config.Skin.M416 == 0) {
    new_Skin.M416_1 = 101004;
    new_Skin.M416_2 = 291004;
    new_Skin.M416_3 = 203008;
    new_Skin.M416_4 = 205005;
    new_Skin.M416_flash = 201010;
    new_Skin.M416_compe = 201009;
    new_Skin.M416_silent = 201011;
    new_Skin.M416_reddot = 203001;
    new_Skin.M416_holo = 203002;
    new_Skin.M416_x2 = 203003;
    new_Skin.M416_x3 = 203014;
    new_Skin.M416_x4 = 203004;
    new_Skin.M416_x6 = 203015;
    new_Skin.M416_quickMag = 204012;
    new_Skin.M416_extendedMag = 204011;
    new_Skin.M416_quickNextended = 204013;
    new_Skin.M416_stock = 205002;
    new_Skin.M416_verical = 203015;
    new_Skin.M416_angle = 202001;
    new_Skin.M416_lightgrip = 202004;
    new_Skin.M416_pink = 202005;
    new_Skin.M416_lazer = 203015;
    new_Skin.M416_thumb = 202006;
  }
  if (preferences.Config.Skin.M416 == 1) {
    new_Skin.M416_1 = 1101004046;
    new_Skin.M416_2 = 1010040461;
    new_Skin.M416_3 = 1010040462;
    new_Skin.M416_4 = 1010040463;
    new_Skin.M416_flash = 1010040474;
    new_Skin.M416_compe = 1010040475;
    new_Skin.M416_silent = 1010040476;
    new_Skin.M416_reddot = 1010040470;
    new_Skin.M416_holo = 1010040469;
    new_Skin.M416_x2 = 1010040468;
    new_Skin.M416_x3 = 1010040467;
    new_Skin.M416_x4 = 1010040466;
    new_Skin.M416_x6 = 1010040481;
    new_Skin.M416_quickMag = 1010040471;
    new_Skin.M416_extendedMag = 1010040472;
    new_Skin.M416_quickNextended = 1010040473;
    new_Skin.M416_stock = 1010040480;
    new_Skin.M416_verical = 1010040479;
    new_Skin.M416_thumb = 1010040478;
    new_Skin.M416_angle = 1010040477;
    new_Skin.M416_lightgrip = 1010040482;
    new_Skin.M416_pink = 1010040483;
    new_Skin.M416_lazer = 1010040484;
  }
  if (preferences.Config.Skin.M416 == 2) {
    new_Skin.M416_1 = 1101004062;
    new_Skin.M416_2 = 1010040611;
    new_Skin.M416_3 = 1010040612;
    new_Skin.M416_4 = 1010040613;
    new_Skin.M416_flash = 201010;
    new_Skin.M416_compe = 201009;
    new_Skin.M416_silent = 201011;
    new_Skin.M416_reddot = 203001;
    new_Skin.M416_holo = 203002;
    new_Skin.M416_x2 = 203003;
    new_Skin.M416_x3 = 203014;
    new_Skin.M416_x4 = 203004;
    new_Skin.M416_x6 = 203015;
    new_Skin.M416_quickMag = 204012;
    new_Skin.M416_extendedMag = 204011;
    new_Skin.M416_quickNextended = 204013;
    new_Skin.M416_stock = 205002;
    new_Skin.M416_verical = 203015;
    new_Skin.M416_angle = 202001;
    new_Skin.M416_lightgrip = 202004;
    new_Skin.M416_pink = 202005;
    new_Skin.M416_lazer = 203015;
    new_Skin.M416_thumb = 202006;
  }
  if (preferences.Config.Skin.M416 == 3) {
    new_Skin.M416_1 = 1101004078;
    new_Skin.M416_2 = 1010040781;
    new_Skin.M416_3 = 1010040782;
    new_Skin.M416_4 = 1010040783;
    new_Skin.M416_flash = 201010;
    new_Skin.M416_compe = 201009;
    new_Skin.M416_silent = 201011;
    new_Skin.M416_reddot = 203001;
    new_Skin.M416_holo = 203002;
    new_Skin.M416_x2 = 203003;
    new_Skin.M416_x3 = 203014;
    new_Skin.M416_x4 = 203004;
    new_Skin.M416_x6 = 203015;
    new_Skin.M416_quickMag = 204012;
    new_Skin.M416_extendedMag = 204011;
    new_Skin.M416_quickNextended = 204013;
    new_Skin.M416_stock = 205002;
    new_Skin.M416_verical = 203015;
    new_Skin.M416_angle = 202001;
    new_Skin.M416_lightgrip = 202004;
    new_Skin.M416_pink = 202005;
    new_Skin.M416_lazer = 203015;
    new_Skin.M416_thumb = 202006;
  }
  if (preferences.Config.Skin.M416 == 4) {
    new_Skin.M416_1 = 1101004086;
    new_Skin.M416_2 = 1010040861;
    new_Skin.M416_3 = 1010040862;
    new_Skin.M416_4 = 1010040863;
    new_Skin.M416_flash = 201010;
    new_Skin.M416_compe = 201009;
    new_Skin.M416_silent = 201011;
    new_Skin.M416_reddot = 203001;
    new_Skin.M416_holo = 203002;
    new_Skin.M416_x2 = 203003;
    new_Skin.M416_x3 = 203014;
    new_Skin.M416_x4 = 203004;
    new_Skin.M416_x6 = 203015;
    new_Skin.M416_quickMag = 204012;
    new_Skin.M416_extendedMag = 204011;
    new_Skin.M416_quickNextended = 204013;
    new_Skin.M416_stock = 205002;
    new_Skin.M416_verical = 203015;
    new_Skin.M416_angle = 202001;
    new_Skin.M416_lightgrip = 202004;
    new_Skin.M416_pink = 202005;
    new_Skin.M416_lazer = 203015;
    new_Skin.M416_thumb = 202006;
  }
  if (preferences.Config.Skin.M416 == 5) {
    new_Skin.M416_1 = 1101004098;
    new_Skin.M416_2 = 1010040981;
    new_Skin.M416_3 = 1010040982;
    new_Skin.M416_4 = 1010040983;
    new_Skin.M416_flash = 201010;
    new_Skin.M416_compe = 201009;
    new_Skin.M416_silent = 201011;
    new_Skin.M416_reddot = 203001;
    new_Skin.M416_holo = 203002;
    new_Skin.M416_x2 = 203003;
    new_Skin.M416_x3 = 203014;
    new_Skin.M416_x4 = 203004;
    new_Skin.M416_x6 = 203015;
    new_Skin.M416_quickMag = 204012;
    new_Skin.M416_extendedMag = 204011;
    new_Skin.M416_quickNextended = 204013;
    new_Skin.M416_stock = 205002;
    new_Skin.M416_verical = 203015;
    new_Skin.M416_angle = 202001;
    new_Skin.M416_lightgrip = 202004;
    new_Skin.M416_pink = 202005;
    new_Skin.M416_lazer = 203015;
    new_Skin.M416_thumb = 202006;
  }
  if (preferences.Config.Skin.M416 == 6) {
    new_Skin.M416_1 = 1101004138;
    new_Skin.M416_2 = 1010041381;
    new_Skin.M416_3 = 1010041382;
    new_Skin.M416_4 = 1010041383;
    new_Skin.M416_flash = 1010041136;
    new_Skin.M416_compe = 1010041137;
    new_Skin.M416_silent = 1010041138;
    new_Skin.M416_reddot = 1010041128;
    new_Skin.M416_holo = 1010041127;
    new_Skin.M416_x2 = 1010041126;
    new_Skin.M416_x3 = 1010041125;
    new_Skin.M416_x4 = 1010041124;
    new_Skin.M416_x6 = 203015;
    new_Skin.M416_quickMag = 1010041134;
    new_Skin.M416_extendedMag = 1010041129;
    new_Skin.M416_quickNextended = 1010041135;
    new_Skin.M416_stock = 1010041146;
    new_Skin.M416_verical = 1010041145;
    new_Skin.M416_angle = 1010041139;
    new_Skin.M416_lightgrip = 202004;
    new_Skin.M416_pink = 202005;
    new_Skin.M416_lazer = 203015;
    new_Skin.M416_thumb = 202006;
  }
  if (preferences.Config.Skin.M416 == 7) {
    new_Skin.M416_1 = 1101004163;
    new_Skin.M416_2 = 1010041631;
    new_Skin.M416_3 = 1010041632;
    new_Skin.M416_4 = 1010041633;
    new_Skin.M416_flash = 201010;
    new_Skin.M416_compe = 1010041574;
    new_Skin.M416_silent = 1010041575;
    new_Skin.M416_reddot = 1010041566;
    new_Skin.M416_holo = 1010041565;
    new_Skin.M416_x2 = 1010041564;
    new_Skin.M416_x3 = 1010041560;
    new_Skin.M416_x4 = 1010041554;
    new_Skin.M416_x6 = 203015;
    new_Skin.M416_quickMag = 1010041568;
    new_Skin.M416_extendedMag = 1010041569;
    new_Skin.M416_quickNextended = 1010041567;
    new_Skin.M416_stock = 1010041579;
    new_Skin.M416_verical = 1010041578;
    new_Skin.M416_angle = 1010041576;
    new_Skin.M416_lightgrip = 20200400;
    new_Skin.M416_pink = 202005;
    new_Skin.M416_lazer = 203015;
    new_Skin.M416_thumb = 1010041577;
  }
  if (preferences.Config.Skin.M416 == 8) {
    new_Skin.M416_1 = 1101004201;
    new_Skin.M416_2 = 1010042011;
    new_Skin.M416_3 = 1010042012;
    new_Skin.M416_4 = 1010042013;
    new_Skin.M416_flash = 1010041956;
    new_Skin.M416_compe = 1010041957;
    new_Skin.M416_silent = 1010041958;
    new_Skin.M416_reddot = 1010041948;
    new_Skin.M416_holo = 1010041947;
    new_Skin.M416_x2 = 1010041946;
    new_Skin.M416_x3 = 1010041945;
    new_Skin.M416_x4 = 1010041944;
    new_Skin.M416_x6 = 1010041967;
    new_Skin.M416_quickMag = 1010041949;
    new_Skin.M416_extendedMag = 1010041950;
    new_Skin.M416_quickNextended = 1010041955;
    new_Skin.M416_stock = 1010041966;
    new_Skin.M416_verical = 1010041965;
    new_Skin.M416_angle = 1010041959;
    new_Skin.M416_lightgrip = 202004;
    new_Skin.M416_pink = 202005;
    new_Skin.M416_lazer = 203015;
    new_Skin.M416_thumb = 202006;
  }
  if (preferences.Config.Skin.M416 == 9) {
    new_Skin.M416_1 = 1101004209;
    new_Skin.M416_2 = 1010042073;
    new_Skin.M416_3 = 1010042083;
    new_Skin.M416_4 = 1010042093;
    new_Skin.M416_flash = 20101000;
    new_Skin.M416_compe = 1010042037;
    new_Skin.M416_silent = 1010042039;
    new_Skin.M416_reddot = 1010042029;
    new_Skin.M416_holo = 1010042028;
    new_Skin.M416_x2 = 1010042027;
    new_Skin.M416_x3 = 1010042026;
    new_Skin.M416_x4 = 1010042025;
    new_Skin.M416_x6 = 1010042024;
    new_Skin.M416_quickMag = 1010042034;
    new_Skin.M416_extendedMag = 1010042035;
    new_Skin.M416_quickNextended = 1010042036;
    new_Skin.M416_stock = 1010042047;
    new_Skin.M416_verical = 1010042046;
    new_Skin.M416_angle = 1010042044;
    new_Skin.M416_lightgrip = 202004;
    new_Skin.M416_pink = 202005;
    new_Skin.M416_lazer = 203015;
    new_Skin.M416_thumb = 202006;
  }
  if (preferences.Config.Skin.M416 == 10) {
    new_Skin.M416_1 = 1101004218;
    new_Skin.M416_2 = 1010042153;
    new_Skin.M416_3 = 1010042163;
    new_Skin.M416_4 = 1010042173;
    new_Skin.M416_flash = 1010042128;
    new_Skin.M416_compe = 1010042127;
    new_Skin.M416_silent = 1010042129;
    new_Skin.M416_reddot = 1010042119;
    new_Skin.M416_holo = 1010042118;
    new_Skin.M416_x2 = 1010042117;
    new_Skin.M416_x3 = 1010042116;
    new_Skin.M416_x4 = 1010042115;
    new_Skin.M416_x6 = 1010042114;
    new_Skin.M416_quickMag = 1010042124;
    new_Skin.M416_extendedMag = 1010042125;
    new_Skin.M416_quickNextended = 1010042126;
    new_Skin.M416_stock = 1010042137;
    new_Skin.M416_verical = 1010042136;
    new_Skin.M416_angle = 1010042134;
    new_Skin.M416_lightgrip = 1010042138;
    new_Skin.M416_pink = 1010042139;
    new_Skin.M416_lazer = 1010042144;
    new_Skin.M416_thumb = 1010042135;
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.Groza == 0) {
    new_Skin.Groza = 101005;
  }
  if (preferences.Config.Skin.Groza == 1) {
    new_Skin.Groza = 1101005019;
  }
  if (preferences.Config.Skin.Groza == 2) {
    new_Skin.Groza = 1101005025;
  }
  if (preferences.Config.Skin.Groza == 3) {
    new_Skin.Groza = 1101005038;
  }
  if (preferences.Config.Skin.Groza == 4) {
    new_Skin.Groza = 1101005043;
  }
  if (preferences.Config.Skin.Groza == 5) {
    new_Skin.Groza = 1101005052;
  }
  if (preferences.Config.Skin.Groza == 6) {
    new_Skin.Groza = 1101005082;
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.AUG == 0)
    new_Skin.AUG = 101006;
  if (preferences.Config.Skin.AUG == 1)
    new_Skin.AUG = 1101006033;
  if (preferences.Config.Skin.AUG == 2)
    new_Skin.AUG = 1101006044;
  if (preferences.Config.Skin.AUG == 3)
    new_Skin.AUG = 1101006062;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.QBZ == 0)
    new_Skin.QBZ = 101007;
  if (preferences.Config.Skin.QBZ == 1)
    new_Skin.QBZ = 1101007025;
  if (preferences.Config.Skin.QBZ == 2)
    new_Skin.QBZ = 1101007036;
  if (preferences.Config.Skin.QBZ == 3)
    new_Skin.QBZ = 1101007046;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.M762 == 0) {
    new_Skin.M762 = 101008;
    new_Skin.M762_Mag = 291008;
  }
  if (preferences.Config.Skin.M762 == 1) {
    new_Skin.M762 = 1101008026;
    new_Skin.M762_Mag = 1010080261;
  }
  if (preferences.Config.Skin.M762 == 2) {
    new_Skin.M762 = 1101008051;
    new_Skin.M762_Mag = 1010080511;
  }
  if (preferences.Config.Skin.M762 == 3) {
    new_Skin.M762 = 1101008061;
    new_Skin.M762_Mag = 1010080611;
  }
  if (preferences.Config.Skin.M762 == 4) {
    new_Skin.M762 = 1101008081;
    new_Skin.M762_Mag = 1010080811;
  }
  if (preferences.Config.Skin.M762 == 5) {
    new_Skin.M762 = 1101008104;
    new_Skin.M762_Mag = 1010081041;
  }
  if (preferences.Config.Skin.M762 == 6) {
    new_Skin.M762 = 1101008116;
    new_Skin.M762_Mag = 1010081161;
  }
  if (preferences.Config.Skin.M762 == 7) {
    new_Skin.M762 = 1101008126;
    new_Skin.M762_Mag = 1010081261;
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.ACE32 == 0)
    new_Skin.ACE32 = 101102;
  if (preferences.Config.Skin.ACE32 == 1)
    new_Skin.ACE32 = 1101102007;
  if (preferences.Config.Skin.ACE32 == 2)
    new_Skin.ACE32 = 1101102017;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.UZI == 0)
    new_Skin.UZI = 102001;
  if (preferences.Config.Skin.UZI == 1)
    new_Skin.UZI = 1102001024;
  if (preferences.Config.Skin.UZI == 2)
    new_Skin.UZI = 1102001036;
  if (preferences.Config.Skin.UZI == 3)
    new_Skin.UZI = 1102001058;
  if (preferences.Config.Skin.UZI == 4)
    new_Skin.UZI = 1102001069;
  if (preferences.Config.Skin.UZI == 5)
    new_Skin.UZI = 1102001089;
  if (preferences.Config.Skin.UZI == 6)
    new_Skin.UZI = 1102001102;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.UMP == 0)
    new_Skin.UMP = 102002;
  if (preferences.Config.Skin.UMP == 1)
    new_Skin.UMP = 1102002043;
  if (preferences.Config.Skin.UMP == 2)
    new_Skin.UMP = 1102002061;
  if (preferences.Config.Skin.UMP == 3)
    new_Skin.UMP = 1102002090;
  if (preferences.Config.Skin.UMP == 4)
    new_Skin.UMP = 1102002117;
  if (preferences.Config.Skin.UMP == 5)
    new_Skin.UMP = 1102002124;
  if (preferences.Config.Skin.UMP == 6)
    new_Skin.UMP = 1102002129;
  if (preferences.Config.Skin.UMP == 7)
    new_Skin.UMP = 1102002136;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.Vector == 0)
    new_Skin.Vector = 102003;
  if (preferences.Config.Skin.Vector == 1)
    new_Skin.Vector = 1102003020;
  if (preferences.Config.Skin.Vector == 2)
    new_Skin.Vector = 1102003031;
  if (preferences.Config.Skin.Vector == 3)
    new_Skin.Vector = 1102003065;
  if (preferences.Config.Skin.Vector == 4)
    new_Skin.Vector = 1102003080;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.Thompson == 0)
    new_Skin.Thompson = 102004;
  if (preferences.Config.Skin.Thompson == 1)
    new_Skin.Thompson = 1102004018;
  if (preferences.Config.Skin.Thompson == 2)
    new_Skin.Thompson = 1102004034;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.Bizon == 0)
    new_Skin.Bizon = 102005;
  if (preferences.Config.Skin.Bizon == 1)
    new_Skin.Bizon = 1102005007;
  if (preferences.Config.Skin.Bizon == 2)
    new_Skin.Bizon = 1102005020;
  if (preferences.Config.Skin.Bizon == 3)
    new_Skin.Bizon = 1102005041;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.K98 == 0)
    new_Skin.K98 = 103001;
  if (preferences.Config.Skin.K98 == 1)
    new_Skin.K98 = 1103001060;
  if (preferences.Config.Skin.K98 == 2)
    new_Skin.K98 = 1103001079;
  if (preferences.Config.Skin.K98 == 3)
    new_Skin.K98 = 1103001101;
  if (preferences.Config.Skin.K98 == 4)
    new_Skin.K98 = 1103001145;
  if (preferences.Config.Skin.K98 == 5)
    new_Skin.K98 = 1103001160;
  if (preferences.Config.Skin.K98 == 6)
    new_Skin.K98 = 1103001179;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (new_Skin.M24 == 0)
    new_Skin.M24 = 103002;
  if (preferences.Config.Skin.M24 == 1)
    new_Skin.M24 = 1103002018;
  if (preferences.Config.Skin.M24 == 2)
    new_Skin.M24 = 1103002030;
  if (preferences.Config.Skin.M24 == 3)
    new_Skin.M24 = 1103002048;
  if (preferences.Config.Skin.M24 == 4)
    new_Skin.M24 = 1103002056;
  if (preferences.Config.Skin.M24 == 5)
    new_Skin.M24 = 1103002087;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.AWM == 0)
    new_Skin.AWM = 103003;
  if (preferences.Config.Skin.AWM == 1)
    new_Skin.AWM = 1103003022;
  if (preferences.Config.Skin.AWM == 2)
    new_Skin.AWM = 1103003030;
  if (preferences.Config.Skin.AWM == 3)
    new_Skin.AWM = 1103003042;
  if (preferences.Config.Skin.AWM == 4)
    new_Skin.AWM = 1103003051;
  if (preferences.Config.Skin.AWM == 5)
    new_Skin.AWM = 1103003062;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (preferences.Config.Skin.DP28 == 0)
    new_Skin.DP28 = 105002;
  if (preferences.Config.Skin.DP28 == 1)
    new_Skin.DP28 = 1105002018;
  if (preferences.Config.Skin.DP28 == 2)
    new_Skin.DP28 = 1105002035;
  if (preferences.Config.Skin.DP28 == 3)
    new_Skin.DP28 = 1105002058;
  if (preferences.Config.Skin.DP28 == 4)
    new_Skin.DP28 = 1105002063;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (new_Skin.M249 == 0)
    new_Skin.M249 = 105001;
    new_Skin.M249s = 205009;
  if (preferences.Config.Skin.M249 == 1)
    new_Skin.M249 = 1105001020;
    new_Skin.M249s = 1050010351;
  if (preferences.Config.Skin.M249 == 2)
    new_Skin.M249 = 1105001034;
    new_Skin.M249s = 1050010412;
  if (preferences.Config.Skin.M249 == 3)
    new_Skin.M249 = 1105001048;
    new_Skin.M249s = 1050010482;
  if (preferences.Config.Skin.M249 == 4)
    new_Skin.M249 = 1105001054;
    new_Skin.M249s = 1050010542;
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

   if (preferences.Config.Skin.Bigfoot == 0)
    new_Skin.Bigfoot = 1953001;
  if (preferences.Config.Skin.Bigfoot == 1)
    new_Skin.Bigfoot = 1953004;
    
  if (preferences.Config.Skin.OMirado == 0)
    new_Skin.OMirado = 1915001;
  if (preferences.Config.Skin.OMirado == 1)
    new_Skin.OMirado = 1915011;
  if (preferences.Config.Skin.OMirado == 2)
    new_Skin.OMirado = 1915099;
    
  if (preferences.Config.Skin.Mirado == 0)
    new_Skin.Mirado = 1914001;
  if (preferences.Config.Skin.Mirado == 1)
    new_Skin.Mirado = 1914011;
    
  if (preferences.Config.Skin.Moto == 0)
    new_Skin.Moto = 1901001;
  if (preferences.Config.Skin.Moto == 1)
    new_Skin.Moto = 1901073;
  if (preferences.Config.Skin.Moto == 2)
    new_Skin.Moto = 1901074;
  if (preferences.Config.Skin.Moto == 3)
    new_Skin.Moto = 1901075;
  if (preferences.Config.Skin.Moto == 4)
    new_Skin.Moto = 1901047;
  if (preferences.Config.Skin.Moto == 5)
    new_Skin.Moto = 1901085;
  if (preferences.Config.Skin.Moto == 6)
    new_Skin.Moto = 1901076;
  if (preferences.Config.Skin.Moto == 7)
    new_Skin.Moto = 1901027;
  if (preferences.Config.Skin.Moto == 8)
    new_Skin.Moto = 1901018;
  if (preferences.Config.Skin.Moto == 9)
    new_Skin.Moto = 1901085;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (preferences.Config.Skin.Buggy == 0)
    new_Skin.Buggy = 1907001;
  if (preferences.Config.Skin.Buggy == 1)
    new_Skin.Buggy = 1907047;
  if (preferences.Config.Skin.Buggy == 2)
    new_Skin.Buggy = 1907009;
if (preferences.Config.Skin.Buggy == 3)
    new_Skin.Buggy = 1907010;
if (preferences.Config.Skin.Buggy == 4)
    new_Skin.Buggy = 1907011;
if (preferences.Config.Skin.Buggy == 5)
    new_Skin.Buggy = 1907012;
if (preferences.Config.Skin.Buggy == 6)
    new_Skin.Buggy = 1907013;
if (preferences.Config.Skin.Buggy == 7)
    new_Skin.Buggy = 1907014;
if (preferences.Config.Skin.Buggy == 8)
    new_Skin.Buggy = 1907015;
if (preferences.Config.Skin.Buggy == 9)
    new_Skin.Buggy = 1907016;
if (preferences.Config.Skin.Buggy == 10)
    new_Skin.Buggy = 1907017;
if (preferences.Config.Skin.Buggy == 11)
    new_Skin.Buggy = 1907018;
if (preferences.Config.Skin.Buggy == 12)
    new_Skin.Buggy = 1907019;
if (preferences.Config.Skin.Buggy == 13)
    new_Skin.Buggy = 1907020;
if (preferences.Config.Skin.Buggy == 14)
    new_Skin.Buggy = 1907021;
if (preferences.Config.Skin.Buggy == 15)
    new_Skin.Buggy = 1907022;
if (preferences.Config.Skin.Buggy == 16)
    new_Skin.Buggy = 1907023;
if (preferences.Config.Skin.Buggy == 17)
    new_Skin.Buggy = 1907024;
if (preferences.Config.Skin.Buggy == 18)
    new_Skin.Buggy = 1907025;
if (preferences.Config.Skin.Buggy == 19)
    new_Skin.Buggy = 1907026;
if (preferences.Config.Skin.Buggy == 20)
    new_Skin.Buggy = 1907027;
if (preferences.Config.Skin.Buggy == 21)
    new_Skin.Buggy = 1907028;
if (preferences.Config.Skin.Buggy == 22)
    new_Skin.Buggy = 1907029;
if (preferences.Config.Skin.Buggy == 23)
    new_Skin.Buggy = 1907030;
if (preferences.Config.Skin.Buggy == 24)
    new_Skin.Buggy = 1907031;
if (preferences.Config.Skin.Buggy == 25)
    new_Skin.Buggy = 1907032;
if (preferences.Config.Skin.Buggy == 26)
    new_Skin.Buggy = 1907033;
if (preferences.Config.Skin.Buggy == 27)
    new_Skin.Buggy = 1907034;
if (preferences.Config.Skin.Buggy == 28)
    new_Skin.Buggy = 1907035;
if (preferences.Config.Skin.Buggy == 29)
    new_Skin.Buggy = 1907036;
if (preferences.Config.Skin.Buggy == 30)
    new_Skin.Buggy = 1907037;
if (preferences.Config.Skin.Buggy == 31)
    new_Skin.Buggy = 1907038;
if (preferences.Config.Skin.Buggy == 32)
    new_Skin.Buggy = 1907039;
if (preferences.Config.Skin.Buggy == 33)
    new_Skin.Buggy = 1907040;
if (preferences.Config.Skin.Buggy == 34)
    new_Skin.Buggy = 1907063;
if (preferences.Config.Skin.Buggy == 35)
    new_Skin.Buggy = 1907054;
if (preferences.Config.Skin.Buggy == 36)
    new_Skin.Buggy = 1907058;
if (preferences.Config.Skin.Buggy == 37)
    new_Skin.Buggy = 1907059;
    
  if (preferences.Config.Skin.Dacia == 0)
    new_Skin.Dacia = 1903001;
  if (preferences.Config.Skin.Dacia == 1)
    new_Skin.Dacia = 1903076;
  if (preferences.Config.Skin.Dacia == 2)
    new_Skin.Dacia = 1903079;
  if (preferences.Config.Skin.Dacia == 3)
    new_Skin.Dacia = 1903071;
  if (preferences.Config.Skin.Dacia == 4)
    new_Skin.Dacia = 1903014;
  if (preferences.Config.Skin.Dacia == 5)
    new_Skin.Dacia = 1903017;
  if (preferences.Config.Skin.Dacia == 6)
    new_Skin.Dacia = 1903035;
  if (preferences.Config.Skin.Dacia == 7)
    new_Skin.Dacia = 1903087;
  if (preferences.Config.Skin.Dacia == 8)
    new_Skin.Dacia = 1903088;
  if (preferences.Config.Skin.Dacia == 9)
    new_Skin.Dacia = 1903089;
  if (preferences.Config.Skin.Dacia == 10)
    new_Skin.Dacia = 1903090;
  if (preferences.Config.Skin.Dacia == 11)
    new_Skin.Dacia = 1903074;
  if (preferences.Config.Skin.Dacia == 12)
    new_Skin.Dacia = 1903075;
  if (preferences.Config.Skin.Dacia == 13)
    new_Skin.Dacia = 1903072;
  if (preferences.Config.Skin.Dacia == 14)
    new_Skin.Dacia = 1903073;
  if (preferences.Config.Skin.Dacia == 15)
    new_Skin.Dacia = 1903080;
  if (preferences.Config.Skin.Dacia == 16)
    new_Skin.Dacia = 1903189;
  if (preferences.Config.Skin.Dacia == 17)
    new_Skin.Dacia = 1903190;
  if (preferences.Config.Skin.Dacia == 18)
    new_Skin.Dacia = 1903191;
  if (preferences.Config.Skin.Dacia == 19)
    new_Skin.Dacia = 1903192;
  if (preferences.Config.Skin.Dacia == 20)
    new_Skin.Dacia = 1903193;
  if (preferences.Config.Skin.Dacia == 21)
    new_Skin.Dacia = 1903197;
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  
if (preferences.Config.Skin.MiniBus == 0)
    new_Skin.MiniBus = 1904001;
  if (preferences.Config.Skin.MiniBus == 1)
    new_Skin.MiniBus = 1904005;
  if (preferences.Config.Skin.MiniBus == 2)
    new_Skin.MiniBus = 1904006;
if (preferences.Config.Skin.MiniBus == 3)
    new_Skin.MiniBus = 1904007;
if (preferences.Config.Skin.MiniBus == 4)
    new_Skin.MiniBus = 1904008;
if (preferences.Config.Skin.MiniBus == 5)
    new_Skin.MiniBus = 1904009;
if (preferences.Config.Skin.MiniBus == 6)
    new_Skin.MiniBus = 1904010;
if (preferences.Config.Skin.MiniBus == 7)
    new_Skin.MiniBus = 1904011;
if (preferences.Config.Skin.MiniBus == 8)
    new_Skin.MiniBus = 1904012;
if (preferences.Config.Skin.MiniBus == 9)
    new_Skin.MiniBus = 1904013;
if (preferences.Config.Skin.MiniBus == 10)
    new_Skin.MiniBus = 1904014;
if (preferences.Config.Skin.MiniBus == 11)
    new_Skin.MiniBus = 1904015;
if (preferences.Config.Skin.MiniBus == 12)
    new_Skin.MiniBus = 1904004;
  
  if (preferences.Config.Skin.CoupeRP == 0)
    new_Skin.CoupeRP = 1961001;
  if (preferences.Config.Skin.CoupeRP == 1)
    new_Skin.CoupeRP = 1961024;
  if (preferences.Config.Skin.CoupeRP == 2)
    new_Skin.CoupeRP = 1961047;
  if (preferences.Config.Skin.CoupeRP == 3)
    new_Skin.CoupeRP = 1961034;
  if (preferences.Config.Skin.CoupeRP == 4)
    new_Skin.CoupeRP = 1961018;
  if (preferences.Config.Skin.CoupeRP == 5)
    new_Skin.CoupeRP = 1961007;
  if (preferences.Config.Skin.CoupeRP == 6)
    new_Skin.CoupeRP = 1961010;
  if (preferences.Config.Skin.CoupeRP == 7)
    new_Skin.CoupeRP = 1961049;
  if (preferences.Config.Skin.CoupeRP == 8)
    new_Skin.CoupeRP = 1961048;
  if (preferences.Config.Skin.CoupeRP == 9)
    new_Skin.CoupeRP = 1961012;
  if (preferences.Config.Skin.CoupeRP == 10)
    new_Skin.CoupeRP = 1961013;
  if (preferences.Config.Skin.CoupeRP == 11)
    new_Skin.CoupeRP = 1961014;
  if (preferences.Config.Skin.CoupeRP == 12)
    new_Skin.CoupeRP = 1961015;
  if (preferences.Config.Skin.CoupeRP == 13)
    new_Skin.CoupeRP = 1961016;
  if (preferences.Config.Skin.CoupeRP == 14)
    new_Skin.CoupeRP = 1961017;
  if (preferences.Config.Skin.CoupeRP == 15)
    new_Skin.CoupeRP = 1961020;
  if (preferences.Config.Skin.CoupeRP == 16)
    new_Skin.CoupeRP = 1961021;
  if (preferences.Config.Skin.CoupeRP == 17)
    new_Skin.CoupeRP = 1961025;
  if (preferences.Config.Skin.CoupeRP == 18)
    new_Skin.CoupeRP = 1961029;
  if (preferences.Config.Skin.CoupeRP == 19)
    new_Skin.CoupeRP = 1961030;
  if (preferences.Config.Skin.CoupeRP == 20)
    new_Skin.CoupeRP = 1961031;
  if (preferences.Config.Skin.CoupeRP == 21)
    new_Skin.CoupeRP = 1961032;
  if (preferences.Config.Skin.CoupeRP == 22)
    new_Skin.CoupeRP = 1961033;
  if (preferences.Config.Skin.CoupeRP == 23)
    new_Skin.CoupeRP = 1961035;
  if (preferences.Config.Skin.CoupeRP == 24)
    new_Skin.CoupeRP = 1961036;
  if (preferences.Config.Skin.CoupeRP == 22)
    new_Skin.CoupeRP = 1961037;
  if (preferences.Config.Skin.CoupeRP == 26)
    new_Skin.CoupeRP = 1961038;
  if (preferences.Config.Skin.CoupeRP == 27)
    new_Skin.CoupeRP = 1961039;
  if (preferences.Config.Skin.CoupeRP == 28)
    new_Skin.CoupeRP = 1961040;
  if (preferences.Config.Skin.CoupeRP == 29)
    new_Skin.CoupeRP = 1961041;
  if (preferences.Config.Skin.CoupeRP == 30)
    new_Skin.CoupeRP = 1961042;
  if (preferences.Config.Skin.CoupeRP == 31)
    new_Skin.CoupeRP = 1961043;
  if (preferences.Config.Skin.CoupeRP == 32)
    new_Skin.CoupeRP = 1961044;
  if (preferences.Config.Skin.CoupeRP == 33)
    new_Skin.CoupeRP = 1961045;
  if (preferences.Config.Skin.CoupeRP == 34)
    new_Skin.CoupeRP = 1961046;
  if (preferences.Config.Skin.CoupeRP == 35)
    new_Skin.CoupeRP = 1961050;
  if (preferences.Config.Skin.CoupeRP == 36)
    new_Skin.CoupeRP = 1961051;
  if (preferences.Config.Skin.CoupeRP == 37)
    new_Skin.CoupeRP = 1961052;
  if (preferences.Config.Skin.CoupeRP == 38)
    new_Skin.CoupeRP = 1961053;
  if (preferences.Config.Skin.CoupeRP == 39)
    new_Skin.CoupeRP = 1961054;
  if (preferences.Config.Skin.CoupeRP == 40)
    new_Skin.CoupeRP = 1961055;
  if (preferences.Config.Skin.CoupeRP == 41)
    new_Skin.CoupeRP = 1961056;
  if (preferences.Config.Skin.CoupeRP == 42)
    new_Skin.CoupeRP = 1961057;

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  if (preferences.Config.Skin.UAZ == 0)
    new_Skin.UAZ = 1908001;
  if (preferences.Config.Skin.UAZ == 1)
    new_Skin.UAZ = 1908067;
  if (preferences.Config.Skin.UAZ == 2)
    new_Skin.UAZ = 1908061;
  if (preferences.Config.Skin.UAZ == 3)
    new_Skin.UAZ = 1908032;
  if (preferences.Config.Skin.UAZ == 4)
    new_Skin.UAZ = 1908068;
  if (preferences.Config.Skin.UAZ == 5)
    new_Skin.UAZ = 1908066;
  if (preferences.Config.Skin.UAZ == 6)
    new_Skin.UAZ = 1908075;
  if (preferences.Config.Skin.UAZ == 7)
    new_Skin.UAZ = 1908076;
  if (preferences.Config.Skin.UAZ == 8)
    new_Skin.UAZ = 1908077;
  if (preferences.Config.Skin.UAZ == 9)
    new_Skin.UAZ = 1908078;
  if (preferences.Config.Skin.UAZ == 10)
    new_Skin.UAZ = 1908084;
  if (preferences.Config.Skin.UAZ == 11)
    new_Skin.UAZ = 1908085;
  if (preferences.Config.Skin.UAZ == 12)
    new_Skin.UAZ = 1908086;
  if (preferences.Config.Skin.UAZ == 13)
    new_Skin.UAZ = 1908088;
  if (preferences.Config.Skin.UAZ == 14)
    new_Skin.UAZ = 1908089;
  if (preferences.Config.Skin.UAZ == 15)
    new_Skin.UAZ = 1908188;
  if (preferences.Config.Skin.UAZ == 16)
    new_Skin.UAZ = 1908189;
  if (preferences.Config.Skin.UAZ == 17)
    new_Skin.UAZ = 1957001;
 
 if (preferences.Config.Skin.Boat == 0)
    new_Skin.Boat = 1911001;
  if (preferences.Config.Skin.Boat == 1)
    new_Skin.Boat = 1911013;
  if (preferences.Config.Skin.Boat == 2)
    new_Skin.Boat = 1911003;
if (preferences.Config.Skin.Boat == 3)
    new_Skin.Boat = 1911004;
if (preferences.Config.Skin.Boat == 4)
    new_Skin.Boat = 1911005;
if (preferences.Config.Skin.Boat == 5)
    new_Skin.Boat = 1911006;
if (preferences.Config.Skin.Boat == 6)
    new_Skin.Boat = 1911007;
if (preferences.Config.Skin.Boat == 7)
    new_Skin.Boat = 1911008;
if (preferences.Config.Skin.Boat == 8)
    new_Skin.Boat = 1911009;
if (preferences.Config.Skin.Boat == 9)
    new_Skin.Boat = 1911010;
if (preferences.Config.Skin.Boat == 10)
    new_Skin.Boat = 1911011;
if (preferences.Config.Skin.Boat == 11)
    new_Skin.Boat = 1911012;

}



int m4v[] = { 101004, 1101004046, 1101004062, 1101004078, 1101004086, 1101004098, 1101004138, 1101004163,1101004201,1101004209,1101004218
};
int scar[] = { 101003, 1101003057, 1101003070, 1101003080, 1101003119, 1101003146, 1101003167, 1101003181};
int akmv[] = { 101001,1101001089, 1101001103, 1101001116, 1101001128, 1101001143, 1101001154, 1101001174,1101001213,1101001231,1101001242
};
int m7[] = { 101008, 1101008026, 1101008051, 1101008061, 1101008081, 1101008104, 1101008116, 1101008126};
int awm[] = { 103003, 1103003022, 1103003030, 1103003042, 1103003051, 1103003062};
int kar[] = { 103001, 1103001060, 1103001079, 1103001101, 1103001145, 1103001160, 1103001179};
int m24[] = { 103002, 1103002018, 1103002030, 1103002048, 1103002056, 1103002087};
int dp[] = { 105002, 1105002018, 1105002035, 1105002058, 1105002063};
int m249[] = { 105001, 1105001020, 1105001034, 1105001048, 1105001054};
int groza[] = { 101005, 1101005019, 1101005025, 1101005038, 1101005043, 1101005052, 1101005082};
int aug[] = { 101006, 1101006033, 1101006044, 1101006062};
int m16[] = { 101002, 1101002029, 1101002056, 1101002068, 1101002081, 1101002103};
int uzi[] = { 102001, 1102001024, 1102001036, 1102001058, 1102001069, 1102001089, 1102001102};
int ump[] = { 102002, 1102002043, 1102002061, 1102002090, 1102002117, 1102002124, 1102002129, 1102002136};
int vectorr[] = { 102003, 1102003020, 1102003031, 1102003065, 1102003080};
int tommy[] = { 102004, 1102004018, 1102004034};
int bizon[] = { 102005, 1102005007, 1102005020, 1102005041};
int ace32[] = { 101102, 1101102007, 1101102017};
int pan[] = { 108004, 1108004125, 1108004145, 1108004160, 1108004283, 1108004337, 1108004356, 1108004365, 1108004054, 1108004008};

int m249s[] = { 205009, 1050010351, 1050010412, 1050010482, 1050010542};
int akmmag[] = { 291001,204013,204011,204012,1010010891, 1010011031, 1010011161, 1010011281, 1010011431, 1010011541, 1010011741,1010012131,1010012311,1010012421
};
int m7mag[] = { 291008,204013,204011,204012,1010080261, 1010080511, 1010080611, 1010080811, 1010081041, 1010081161, 1010081261};
int scarmag[] = { 291003,204013,204011,204012,1010030571, 1010030701, 1010030801, 1010031191, 1010031461, 1010031671, 1010031811};
int m4mag[] = { 291004,204013,204011,204012,1010040461,1010040611,1010040781,1010040861,1010040981,1010041381,1010041631,1010042011,1010042073,1010042153  };

int m4sight[] = { 203008,1010040462,1010040612,1010040782,1010040862,1010040982,1010041382,1010041632,1010042012,1010042083,1010042163  };

int m4stock[] = { 205005,1010040463,1010040613,1010040783,1010040863,1010040983,1010041383,1010041633,1010042013,1010042093,1010042173  };

int m4stock1[] = { 205002,1010040480,205002,205002,205002,205002,1010041146,1010041579,1010041966,1010042137,1010042173  };

int m4reddot[] = { 203001,1010040470,203001,203001,203001,203001,1010041128,1010041566,1010041948,1010042029,1010042119  };

int m16s[] = { 205007, 1010020292, 1010020562, 1010020682, 1010020812, 1010021032};
int m16mag[] = { 291002,204013,204011,204012, 1010020291, 1010020561, 1010020681, 1010020811, 1010021031};


int emote1[] = { 2200101,12220023,12219677,12219716,12209401,12220028,12209701,12209801,12209901 };
int emote2[] = { 2200201,12210201,12210601,12220028,12219819,12211801,12212001,12212201,12212401 };
int emote3[] = { 2200301,12212601,12213201,12219715,12219814,12213601,12213801,12214001,12214201 };

int SuitX[] = { 403003,1405628,1405870,1405983,1406152,1406311,1406475,1406638,1406872 };

int Bag[] = { 501006,501005,501004,501003,501002,501001,1501003550,1501003277,1501003321,1501003443,1501003265,1501003051,1501003220,1501003174 };

int Helmet[] = { 502001,502002,502003,1502003014,1502003028,1502003023,1501002443,1502003031,1502003033,1502003069,1502003261 };


struct FLinearColor visCol;
ASTExtraPlayerCharacter *g_LocalPlayer;
ASTExtraPlayerController *g_PlayerController;
#define COLOR_BLACK FLinearColor(0, 0, 0, 1.f)
#define COLOR_WHITE FLinearColor(1.f, 1.f, 1.f, 1.f)
#define COLOR_RED   FLinearColor(1.f, 0, 0, 1.f)
#define COLOR_NO   FLinearColor(0.f, 0, 0, 0.f)
#define COLOR_LIME  FLinearColor(0, 1.f, 0, 1.f)
#define COLOR_BLUE  FLinearColor(0, 0, 1.f, 1.f)
#define COLOR_CAR   FLinearColor(1.f, 0.5f, 1.f, 1.f)
#define GREEN       FLinearColor(0 / 255.f, 153 / 255.f, 0 / 255.f, 1.f)
#define ABU         FLinearColor(0 / 255.f, 204 / 255.f, 204 / 255.f, 1.f)
#define COLOR_GREEN FLinearColor(0, 0.5f, 0, 1.f)
#define COLOR_PLAYER FLinearColor(1.000f, 0.620f, 0.150f, 1.000f)
FLinearColor tempColor = COLOR_PLAYER;

//typedef uintptr_t kaddr;
using namespace std;
using namespace SDK;





string encryptDecrypt(string toEncrypt) {
    char key[3] = {'K', 'C', 'Q'}; //Any chars will work, in an array of any size
    string output = toEncrypt;
    for (int i = 0; i < toEncrypt.size(); i++)
        output[i] = toEncrypt[i] ^ key[i % (sizeof(key) / sizeof(char))];
    return output;
}



uint64_t getBaseAddress(const char* fileName)
{
  for (int i = 0; i < _dyld_image_count(); i++) {
        if (strstr(_dyld_get_image_name(i), fileName)) {
            return _dyld_get_image_vmaddr_slide(i);
        }
    }
    return 0;
}

//uint64_t getRealOffset(uint64_t offset)
//{
    //uint64_t vmaddr = getBaseAddress("ShadowTrackerExtra");
    //return vmaddr + offset;
//}
kaddr getRealOffset(kaddr offset){
    return (unsigned long)Get_module_base()+offset; //rootfull
}

//GUObjectArray
long obbbbl() {

    
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];//guobject
      NSString *BundID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    if([BundID containsString:@"ig"]){
        return getRealOffset(0x10A236320);
    }
    if([BundID containsString:@"kr"]){
        return getRealOffset(0x10A433B20);

        }
    if([BundID containsString:@"rekoo"]){
        return getRealOffset(0x10A40DA20);
    }
    if([BundID containsString:@"imobile"]){
        return getRealOffset(0x109A29BA8);
    }

    if([BundID containsString:@"vn"]){
        return getRealOffset(0x10A360AA8);
    }
    return false;
};

UWorld *GEWorld;
int GWorldNum = 0;
TUObjectArray gobjects;
UWorld *GetFullWorld()
{
    if(GWorldNum == 0) {
        gobjects = UObject::GUObjectArray->ObjObjects;
        for (int i=0; i< gobjects.Num(); i++)
            if (auto obj = gobjects.GetByIndex(i)) {
                if(obj->IsA(UEngine::StaticClass())) {
                    auto GEngine = (UEngine *) obj;
                    if(GEngine) {
                        tslFont = GEngine->MediumFont;
                        robotoTinyFont = GEngine->MediumFont;
                        auto ViewPort = GEngine->GameViewport;
                        if (ViewPort)
                        {
                            GEWorld = ViewPort->World;
                            GWorldNum = i;
                            return ViewPort->World;
                        }
                    }
                }
            }
    }else {
        auto GEngine = (UEngine *) (gobjects.GetByIndex(GWorldNum));
        if(GEngine) {
            tslFont = GEngine->MediumFont;
            robotoTinyFont = GEngine->MediumFont;
            auto ViewPort = GEngine->GameViewport;
            if(ViewPort) {
                GEWorld = ViewPort->World;
                return ViewPort->World;
            }
        }
    }
    return 0;
}
//TNameEntryArray *GetGNames() {
//return (TNameEntryArray *) fast2();
//}
//GNames_Fun
TNameEntryArray *GetGNames() {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
      NSString *BundID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    if([BundID containsString:@"ig"]){
        return ((TNameEntryArray *(*)()) ((unsigned long)_dyld_get_image_vmaddr_slide(0) +0x1046AEDD8))();
    }
    if([BundID containsString:@"kr"]){
        return ((TNameEntryArray *(*)()) ((unsigned long)_dyld_get_image_vmaddr_slide(0) +0x10486F930))();
    }
    if([BundID containsString:@"imobile"]){
        return ((TNameEntryArray *(*)()) ((unsigned long)_dyld_get_image_vmaddr_slide(0) +0x104256E0C))();
    }
    if([BundID containsString:@"rekoo"]){
        return ((TNameEntryArray *(*)()) ((unsigned long)_dyld_get_image_vmaddr_slide(0) +0x104846B68))();
    }
    if([BundID containsString:@"vn"]){
        return ((TNameEntryArray *(*)()) ((unsigned long)_dyld_get_image_vmaddr_slide(0) +0x1047CACD4))();

    }
    return 0;
}



template <class T> void GetAllActors(std::vector<T*>& Actors) {
    UGameplayStatics* gGameplayStatics = (UGameplayStatics*)gGameplayStatics->StaticClass();
    auto GWorld = GetFullWorld();
    if (GWorld) {
        TArray<AActor*> Actors2;
        gGameplayStatics->GetAllActorsOfClass((UObject*)GWorld, T::StaticClass(), &Actors2);
        for (int i = 0; i < Actors2.Num(); i++) {
            Actors.push_back((T*)Actors2[i]);
        }
    }
}
FVector GetBoneLocationByName(ASTExtraPlayerCharacter *Actor, const char *BoneName) {
    return Actor->GetBonePos(BoneName, FVector());
}

struct sRegion
{
    kaddr start, end;
};

std::vector<sRegion> trapRegions;

bool isObjectInvalid(UObject *obj)
{
    if (!Tools::IsPtrValid(obj))
    {
        return true;
    }
    if (!Tools::IsPtrValid(obj->ClassPrivate))
    {
        return true;
    }
    if (obj->InternalIndex <= 0)
    {
        return true;
    }
    if (obj->NamePrivate.ComparisonIndex <= 0)
    {
        return true;
    }
    if ((kaddr)(obj) % sizeof(kaddr) != 0x0 && (kaddr)(obj) % sizeof(kaddr) != 0x4)
    {
        return true;
    }
    if (std::any_of(trapRegions.begin(), trapRegions.end(), [&](const sRegion& region) { return ((kaddr)obj) >= region.start && ((kaddr)obj) <= region.end; }) || std::any_of(trapRegions.begin(), trapRegions.end(), [&](const sRegion& region) { return ((kaddr)obj->ClassPrivate) >= region.start && ((kaddr)obj->ClassPrivate) <= region.end; }))
    {
        return true;
    }
    return false;
}

bool WriteAddr(void *addr, void *buffer, size_t length) {
    unsigned long page_size = sysconf(_SC_PAGESIZE);
    unsigned long size = page_size * sizeof(kaddr);
    return mprotect((void *) ((kaddr) addr - ((kaddr) addr % page_size) - page_size), (size_t) size, PROT_EXEC | PROT_READ | PROT_WRITE) == 0 && memcpy(addr, buffer, length) != 0;
}
template<typename T>
void Write(kaddr addr, T value) {
    WriteAddr((void *) addr, &value, sizeof(T));
}

class Rect2 {
public:
    float x;
    float y;
    float width;
    float height;

    Rect2() {
        this->x = 0;
        this->y = 0;
        this->width = 0;
        this->height = 0;
    }

    Rect2(float x, float y, float width, float height) {
        this->x = x;
        this->y = y;
        this->width = width;
        this->height = height;
    }

    bool operator==(const Rect2 &src) const {
        return (src.x == this->x && src.y == this->y && src.height == this->height &&
                src.width == this->width);
    }

    bool operator!=(const Rect2 &src) const {
        return (src.x != this->x && src.y != this->y && src.height != this->height &&
                src.width != this->width);
    }
};



const char *getObjectPath(UObject *Object) {
    std::string s;
    for (auto super = Object->ClassPrivate; super; super = (UClass *) super->SuperStruct) {
        if (!s.empty())
            s += ".";
        s += super->NamePrivate.GetName();
    }
    return s.c_str();
}



bool _read(kaddr addr, void *buffer, int len)
{
    if (!IsValidAddress(addr)) return false;
    vm_size_t size = 0;
    kern_return_t error = vm_read_overwrite(mach_task_self(), (vm_address_t)addr, len, (vm_address_t)buffer, &size);
    if(error != KERN_SUCCESS || size != len)
    {
        return false;
    }
    return true;
}

bool _write(kaddr addr, void *buffer, int len)
{
    if (!IsValidAddress(addr)) return false;
    kern_return_t error = vm_write(mach_task_self(), (vm_address_t)addr, (vm_offset_t)buffer, (mach_msg_type_number_t)len);
    if(error != KERN_SUCCESS)
    {
        return false;
    }
    return true;
}
kaddr GetRealOffset(kaddr offset) {
    if (module == 0) {
        return 0;
    }
    return (module + offset);
}
template<typename T> T Read(kaddr addr) {
    T data;
    _read(addr, reinterpret_cast<void *>(&data), sizeof(T));
    return data;
}
void NekoHook(FRotator &angles) {
    if (angles.Pitch > 180)
        angles.Pitch -= 360;
    if (angles.Pitch < -180)
        angles.Pitch += 360;

    if (angles.Pitch < -75.f)
        angles.Pitch = -75.f;
    else if (angles.Pitch > 75.f)
        angles.Pitch = 75.f;

    while (angles.Yaw < -180.0f)
        angles.Yaw += 360.0f;
    while (angles.Yaw > 180.0f)
        angles.Yaw -= 360.0f;
}
void NekoHook(float *angles) {
    if (angles[0] > 180)
        angles[0] -= 360;
    if (angles[0] < -180)
        angles[0] += 360;

    if (angles[0] < -75.f)
        angles[0] = -75.f;
    else if (angles[0] > 75.f)
        angles[0] = 75.f;

    while (angles[1] < -180.0f)
        angles[1] += 360.0f;
    while (angles[1] > 180.0f)
        angles[1] -= 360.0f;
}


void NekoHook(Vector3 angles) {
    if (angles.X > 180)
        angles.X -= 360;
    if (angles.X < -180)
        angles.X += 360;

    if (angles.X < -75.f)
        angles.X = -75.f;
    else if (angles.X > 75.f)
        angles.X = 75.f;

    while (angles.Y < -180.0f)
        angles.Y += 360.0f;
    while (angles.Y > 180.0f)
        angles.Y -= 360.0f;
}

#define TSL_FONT_DEFAULT_SIZE 20
static UFont *robotoFont = 0, *robotoTinyFont = 0,*tslFont = 0;

void DrawOutlinedText(AHUD *HUD, FString Text, FVector2D Pos, FLinearColor Color, FLinearColor OutlineColor, bool isCenter = false) {
    UCanvas *Canvas = HUD->Canvas;
    Canvas->K2_DrawText(robotoFont, Text, Pos, Color, 1.f, {}, {}, isCenter, isCenter, true, OutlineColor);
}

void DrawText(AHUD *HUD, FString Text, FVector2D Pos, FLinearColor Color, bool isCenter = false) {
    UCanvas *Canvas = HUD->Canvas;
    Canvas->K2_DrawText(robotoFont, Text, Pos, Color, 1.f, {}, {}, isCenter, isCenter, false, {});
}

void DrawSmallOutlinedText(AHUD *HUD, FString Text, FVector2D Pos, FLinearColor Color, FLinearColor OutlineColor, bool isCenter = false) {
    UCanvas *Canvas = HUD->Canvas;
    Canvas->K2_DrawText(robotoTinyFont, Text, Pos, Color, 1.f, {}, {}, isCenter, isCenter, true, OutlineColor);
}

void DrawSmallText(AHUD *HUD, FString Text, FVector2D Pos, FLinearColor Color, bool isCenter = false) {
    UCanvas *Canvas = HUD->Canvas;
    Canvas->K2_DrawText(robotoTinyFont, Text, Pos, Color, 1.f, {}, {}, isCenter, isCenter, false, {});
}
void DrawTextcan(AHUD *HUD, FString Text, FVector2D Pos, FLinearColor Color, FLinearColor OutlineColor, bool isCenter = true) {
 UCanvas *Canvas = HUD->Canvas;
 Canvas->K2_DrawText(tslFont, Text, Pos, Color, 1.f, {}, {}, isCenter, isCenter, true, OutlineColor);
}
void DrawCircle(AHUD *HUD, int x, int y, int radius, int numsides, FLinearColor OutlineColor){
    float Step = M_PI * 2.0 / numsides;
    int Count = 0;
    FVector2D V[128];
    for (float a = 0; a < M_PI * 2.0; a += Step)
    {
        float X1 = radius * cos(a) + x;
        float Y1 = radius * sin(a) + y;
        float X2 = radius * cos(a + Step) + x;
        float Y2 = radius * sin(a + Step) + y;
        V[Count].X = X1;
        V[Count].Y = Y1;
        V[Count + 1].X = X2;
        V[Count + 1].Y = Y2;
        HUD->Canvas->K2_DrawLine(FVector2D({ V[Count].X, V[Count].Y }), FVector2D({ X2, Y2 }), 1.f, OutlineColor);
    }
}
void DrawFilledCircle(AHUD *HUD, int x, int y, int radius, int numsides, FLinearColor OutlineColor, FLinearColor FillColor){
    float Step = M_PI * 2.0 / numsides;
    FVector2D Center(x, y);
    FVector2D V[128];
    for (int i = 0; i < numsides; ++i)
    {
        // Calculate vertices for the i-th triangle
        float Angle = Step * i;
        V[i].X = Center.X + radius * cos(Angle);
        V[i].Y = Center.Y + radius * sin(Angle);

        // Draw lines from the center to the vertices
        HUD->Canvas->K2_DrawLine(Center, V[i], 1.f, FillColor);
    }

    // Optionally, draw the outline by connecting the vertices
    for (int i = 0; i < numsides; ++i)
    {
        HUD->Canvas->K2_DrawLine(V[i], V[(i+1) % numsides], 1.f, OutlineColor);
    }
}
void *LoadFont() {
    while (!robotoFont || !robotoTinyFont || !tslFont) {
        tslFont = UObject::FindObject<UFont>("Font TSLFont.TSLFont");
        robotoFont = UObject::FindObject<UFont>("Font Roboto.Roboto");
        robotoTinyFont = UObject::FindObject<UFont>("Font RobotoTiny.RobotoTiny");
        sleep(1);
    }
    return 0;
}
/*bool _read(kaddr addr, void *buffer, int len)
{
    if (!IsValidAddress(addr)) return false;
    vm_size_t size = 0;
    kern_return_t error = vm_read_overwrite(mach_task_self(), (vm_address_t)addr, len, (vm_address_t)buffer, &size);
    if(error != KERN_SUCCESS || size != len)
    {
        return false;
    }
    return true;
}*/
#define W2S(w, s) UGameplayStatics::ProjectWorldToScreen(g_PlayerController, w, false, s)
 
FVector WorldToRadar(float Yaw, FVector Origin, FVector LocalOrigin, float PosX, float PosY, Vector3 Size, bool &outbuff) {
 bool flag = false;
 double num = (double)Yaw;
 double num2 = num * 0.017453292519943295;
 float num3 = (float)std::cos(num2);
 float num4 = (float)std::sin(num2);
 float num5 = Origin.X - LocalOrigin.X;
 float num6 = Origin.Y - LocalOrigin.Y;
 struct FVector Xector;
 Xector.X = (num6 * num3 - num5 * num4) / 150.f;
 Xector.Y = (num5 * num3 + num6 * num4) / 150.f;
 struct FVector Xector2;
 Xector2.X = Xector.X + PosX + Size.X / 2.f;
 Xector2.Y = -Xector.Y + PosY + Size.Y / 2.f;
 bool flag2 = Xector2.X > PosX + Size.X;
 if (flag2) {
  Xector2.X = PosX + Size.X;
 }else{
  bool flag3 = Xector2.X < PosX;
  if (flag3) {
   Xector2.X = PosX;
  }
 }
 bool flag4 = Xector2.Y > PosY + Size.Y;
 if (flag4) {
  Xector2.Y = PosY + Size.Y;
 }else{
  bool flag5 = Xector2.Y < PosY;
  if (flag5){
   Xector2.Y = PosY;
  }
 }
 bool flag6 = Xector2.Y == PosY || Xector2.X == PosX;
 if (flag6){
  flag = true;
 }
 outbuff = flag;
 return Xector2;
}
void VectorAnglesRadar(Vector3 & forward, FVector & angles) {
 if (forward.X == 0.f && forward.Y == 0.f) {
  angles.X = forward.Z > 0.f ? -90.f : 90.f;
  angles.Y = 0.f;
 } else {
  angles.X = RAD2DEG(atan2(-forward.Z, forward.Magnitude(forward)));
  angles.Y = RAD2DEG(atan2(forward.Y, forward.X));
 }
 angles.Z = 0.f;
}
FRotator ToRotator(FVector local, FVector target) {
    FVector rotation;
    rotation.X = local.X - target.X;
    rotation.Y = local.Y - target.Y;
    rotation.Z = local.Z - target.Z;

    FRotator newViewAngle = {0};

    float hyp = sqrt(rotation.X * rotation.X + rotation.Y * rotation.Y);

    newViewAngle.Pitch = -atan(rotation.Z / hyp) * (180.f / (float) 3.14159265358979323846);
    newViewAngle.Yaw = atan(rotation.Y / rotation.X) * (180.f / (float) 3.14159265358979323846);
    newViewAngle.Roll = (float) 0.f;

    if (rotation.X >= 0.f)
        newViewAngle.Yaw += 180.0f;

    return newViewAngle;
}
void RotateTriangle(std::array<Vector3, 3> & points, float rotation) {
 const auto points_center = (points.at(0) + points.at(1) + points.at(2)) / 3;
 for (auto & point : points) {
  point = point - points_center;
  const auto temp_x = point.X;
  const auto temp_y = point.Y;
  const auto theta = DEG2RAD(rotation);
  const auto c = cosf(theta);
  const auto s = sinf(theta);
  point.X = temp_x * c - temp_y * s;
  point.Y = temp_x * s + temp_y * c;
  point = point + points_center;
 }
 }
UGameplayStatics* iosde = (UGameplayStatics*)UGameplayStatics::StaticClass();


static std::unordered_set<uint32_t> AlreadyChangedSet;
uintptr_t GetVirtualFunctionAddress(uintptr_t clazz, uintptr_t index)
{
    if (!clazz)
    {
        return 0;
    }
    uintptr_t vtablePtr = *(uintptr_t*)clazz;
    if (!vtablePtr)
    {
        return 0;
    }
    // Ensure index is within bounds of the vtable
    if (index < 0)
    {
        return 0;
    }
    return *((uintptr_t*)vtablePtr + index);
}
void ChangeItemAVc(uintptr_t thiz, int InItemID)
{
    if (thiz)
    {
        auto PrechangeitemAvatar_addr = GetVirtualFunctionAddress(thiz, 184); //vtable idx
        if (PrechangeitemAvatar_addr)
        {
            return ((void(*)(uintptr_t, int, bool))PrechangeitemAvatar_addr)(thiz, InItemID, true);
        }
    }
}
int glWidth, glHeight;
bool isInsideFOV(int x, int y) {
    if (!menu::aimbot::aimfov)
        return true;
    int circle_x = screenWidth / 2;
    int circle_y = screenHeight / 2;
    int rad = (int) menu::silent::silfov;
    return (x - circle_x) * (x - circle_x) + (y - circle_y) * (y - circle_y) <= rad * rad;
}

auto GetTargetByCrossDist() {
    ASTExtraPlayerCharacter *result = 0;
    float max = std::numeric_limits<float>::infinity();

    auto localPlayer = g_LocalPlayer;
    auto localController = g_PlayerController;

    if (localPlayer && localController) {
        std::vector<ASTExtraPlayerCharacter *> PlayerCharacter;
        GetAllActors(PlayerCharacter);
        for (auto actor = PlayerCharacter.begin(); actor != PlayerCharacter.end(); actor++) {
            auto Player = *actor;

            if (Player->PlayerKey == localPlayer->PlayerKey)
                continue;

            if (Player->TeamID == localPlayer->TeamID)
                continue;

            if (Player->bDead)
                continue;

            if (Player->bHidden) //
                continue;

            //if (!Player->Mesh) //
            //    continue;

            if (!Player->RootComponent) //
                continue;

            if (menu::silent::skipKnock) {
                if (Player->Health == 0.0f)
                    continue;
            }
            if (menu::aimbot::skipKnock) {
                if (Player->Health == 0.0f)
                    continue;
            }

            if (menu::silent::skipAI) {
                if (Player->bEnsure)
                    continue;
            }
            if (menu::aimbot::skipAI) {
                if (Player->bEnsure)
                    continue;
            }
            
            float dist = localPlayer->GetDistanceTo(Player) / 100.0f;
            if (dist > menu::silent::distance)
            continue;
            if (dist > menu::aimbot::distances)
            continue;

            
            if (menu::silent::visCheck) {
                if (!localController->LineOfSightTo(Player, {0, 0, 0}, true))
                    continue;
            }
            if (menu::aimbot::visCheck) {
                if (!localController->LineOfSightTo(Player, {0, 0, 0}, true))
                    continue;
            }
            auto Root = Player->GetBonePos("Root", {});
            auto Head = Player->GetBonePos("Head", {});

            FVector2D RootSc, HeadSc;
            if (W2S(Root, &RootSc) && W2S(Head, &HeadSc)) {
                float height = abs(HeadSc.Y - RootSc.Y);
                float width = height * 0.65f;

                FVector middlePoint = {HeadSc.X + (width / 2), HeadSc.Y + (height / 2), 0};
                if ((middlePoint.X >= 0 && middlePoint.X <= (float) glWidth) &&
                    (middlePoint.Y >= 0 && middlePoint.Y <= (float) glHeight)) {
                    FVector2D v2Middle = FVector2D((float) (glWidth / 2), (float) (glHeight / 2));
                    FVector2D v2Loc = FVector2D(middlePoint.X, middlePoint.Y);
                    if(isInsideFOV((int)middlePoint.X, (int)middlePoint.Y )) {
                    float distance = FVector2D::Distance(v2Middle, v2Loc);
                    if (distance < max) {
                        max = distance;
                        result = Player;
                    }
                  }
                }
            }
        }
    }
    return result;
}

void (*orig_shoot_event)(USTExtraShootWeaponComponent *thiz, FVector start, FRotator rot, void *unk1, int unk2) = 0;
void shoot_event(USTExtraShootWeaponComponent *thiz, FVector start, FRotator rot, ASTExtraShootWeapon *weapon, int unk1) {
    if (menu::silent::enable) {
        auto WeaponManagerComponent = g_LocalPlayer->WeaponManagerComponent;

        if (WeaponManagerComponent) {
            auto CurrentWeaponReplicated = (ASTExtraShootWeapon*)WeaponManagerComponent->CurrentWeaponReplicated;

            if (CurrentWeaponReplicated) {
                // Get the weapon ID
                int WeaponID = CurrentWeaponReplicated->GetWeaponID();

                // Check if the weapon ID matches one of the specific IDs
                if (WeaponID == 104003 || WeaponID == 104004) {  // S12K, DBS only
                    static int shotCounter = 1;
                    const int defaultBulletsPerHit = 6;
                    const float maxRange = 300;
                    const float midRange = 120;
                    const float minRange = 30;

                    bool triggerOk = false;
                    ASTExtraPlayerCharacter *Target = GetTargetByCrossDist();

                    if (Target) {
                        if (menu::silent::trigger != 0) {
                            if (menu::silent::trigger == 1) {
                                triggerOk = g_LocalPlayer->bIsWeaponFiring;
                            } else if (menu::silent::trigger == 2) {
                                triggerOk = g_LocalPlayer->bIsGunADS;
                            } else if (menu::silent::trigger == 3) {
                                triggerOk = g_LocalPlayer->bIsWeaponFiring && g_LocalPlayer->bIsGunADS;
                            } else if (menu::silent::trigger == 4) {
                                triggerOk = g_LocalPlayer->bIsWeaponFiring || g_LocalPlayer->bIsGunADS;
                            }
                        } else {
                            triggerOk = true;
                        }
                    }

                    if (triggerOk) {
                        int randomIterations = rand() % 100000 + 50000;
                        for (int i = 0; i < randomIterations; ++i) {
                            volatile int dummy = i;
                        }
                        shotCounter++;

                        FVector targetAimPos = Target->GetBonePos("Head", {});
                        targetAimPos.Z += 15.0f;

                        if (menu::silent::target == 2) {
                            static int counter = 0;
                            float randomAdjustmentZ;

                            switch (counter % 4) {
                                case 0: randomAdjustmentZ = 5.f - (counter % 20); break;
                                case 1: randomAdjustmentZ = -15.f - (counter % 21); break;
                                case 2: randomAdjustmentZ = -25.f - (counter % 15); break;
                                case 3: randomAdjustmentZ = -40.f - (counter % 11); break;
                            }

                            if (randomAdjustmentZ > 5.f) randomAdjustmentZ = -20.f;
                            if (randomAdjustmentZ < -50.f) randomAdjustmentZ = -36.f;

                            float randomAdjustmentX = (counter % 5) - 2;
                            float randomAdjustmentY = (counter % 5) - 2;

                            targetAimPos.X += randomAdjustmentX;
                            targetAimPos.Y += randomAdjustmentY;
                            targetAimPos.Z += randomAdjustmentZ;
                            counter++;
                        }

                        UShootWeaponEntity *ShootWeaponEntityComponent = thiz->ShootWeaponEntityComponent;
                        std::srand(static_cast<unsigned>(std::time(0)));

                        if (ShootWeaponEntityComponent && Target) {
                            FVector LinearVelocity(0, 0, 0);
                            if (ASTExtraVehicleBase* CurrentVehicle = Target->CurrentVehicle) {
                                LinearVelocity = CurrentVehicle->ReplicatedMovement.LinearVelocity;
                            } else {
                                LinearVelocity = Target->ReplicatedMovement.LinearVelocity;
                            }

                            FVector playerPos = g_LocalPlayer->GetBonePos("Root", {});
                            FVector targetPos = Target->GetBonePos("Root", {});
                            float dist1 = FVector::Distance(playerPos, targetPos);

                            if (dist1 > 0 && ShootWeaponEntityComponent->BulletRange > 0) {
                                float timeToTravel = dist1 / ShootWeaponEntityComponent->BulletRange;

                                if (timeToTravel > 0) {
                                    FVector predictedPos = UKismetMathLibrary::Add_VectorVector(targetAimPos, UKismetMathLibrary::Multiply_VectorFloat(LinearVelocity, timeToTravel));

                                    float noiseX = static_cast<float>(std::rand() % 11 - 5);
                                    float noiseY = static_cast<float>(std::rand() % 11 - 5);
                                    float noiseZ = static_cast<float>(std::rand() % 11 - 5);
                                    FVector randomNoise(noiseX, noiseY, noiseZ);

                                    targetAimPos = predictedPos + randomNoise;
                                }
                            }
                        }

                        float distToTarget = g_LocalPlayer->GetDistanceTo(Target) / 100.0f;
                        FVector playerPos = g_LocalPlayer->GetBonePos("Root", {});
                        FVector targetPos = Target->GetBonePos("Root", {});
                        float dist = FVector::Distance(playerPos, targetPos);

                        int bulletsPerHit;
                        float randomFactor = 0.8f + static_cast<float>(rand()) / (static_cast<float>(RAND_MAX / (1.2f - 0.8f)));

                        if (distToTarget <= minRange) {
                            bulletsPerHit = static_cast<int>(4 * randomFactor + 0.5f);
                        } else if (distToTarget <= midRange) {
                            bulletsPerHit = static_cast<int>(6 * randomFactor + 0.5f);
                        } else if (distToTarget <= maxRange) {
                            bulletsPerHit = static_cast<int>(7 * randomFactor + 0.5f);
                        } else {
                            bulletsPerHit = static_cast<int>(defaultBulletsPerHit * randomFactor + 0.5f);
                        }

                        bulletsPerHit = (bulletsPerHit < 1) ? 1 : (bulletsPerHit > defaultBulletsPerHit) ? defaultBulletsPerHit : bulletsPerHit;

                        bool shouldHit = (shotCounter % bulletsPerHit == 0 || shotCounter % bulletsPerHit == 2);
                        if (!shouldHit) {
                            targetAimPos.X += (shotCounter % 3 == 0 ? 8.0 : 8.0);  // No multiplier, just the fixed value
                            targetAimPos.Y += (shotCounter % 2 == 0 ? 10.0 : -10.0);  // No multiplier, just the fixed value
                            targetAimPos.Z += (shotCounter % 2 == 0 ? 10.0 : -10.0);  // No multiplier, just the fixed value
                        }


                        FVector fDir = UKismetMathLibrary::Subtract_VectorVector(targetAimPos, start);
                        FRotator sex = UKismetMathLibrary::Conv_VectorToRotator(fDir);
                        rot = sex;
                    }
                }
            }
        }
    }

    return orig_shoot_event(thiz, start, rot, weapon, unk1);
}


    
    
void DrawLine(AHUD *HUD, FVector2D posFrom, FVector2D posTo, float Thickness, FLinearColor Color) {
    HUD->DrawLine(posFrom.X, posFrom.Y, posTo.X, posTo.Y, Color, Thickness);

}



void RenderESP(AHUD *HUD, int ScreenWidth, int ScreenHeight) {
          // std::this_thread::sleep_for(std::chrono::milliseconds(3));

    updateSkin();
        ASTExtraPlayerCharacter *localPlayer = 0;
        ASTExtraPlayerController *localPlayerController = 0;
        glWidth = ScreenWidth;
        glHeight = ScreenHeight;

    UKismetMathLibrary* UMC = (UKismetMathLibrary*)UKismetMathLibrary::StaticClass();
    UKismetSystemLibrary*USl = (UKismetSystemLibrary*)UKismetSystemLibrary::StaticClass();
            auto GWorld = GetFullWorld();
            if (GWorld) {
                UNetDriver *NetDriver = GWorld->NetDriver;
                if (NetDriver) {
                    UNetConnection *ServerConnection = NetDriver->ServerConnection;
                    if (ServerConnection) {
                        localPlayerController = (ASTExtraPlayerController *) ServerConnection->PlayerController;
                    }
                }

                if (localPlayerController) {
                    int localteamid;
                    std::vector<ASTExtraPlayerCharacter *> PlayerCharacter;
                    GetAllActors(PlayerCharacter);
                    for (auto actor = PlayerCharacter.begin();
                         actor != PlayerCharacter.end(); actor++) {
                        auto Actor = *actor;
                        if (Actor->PlayerKey ==
                            ((ASTExtraPlayerController *) localPlayerController)->PlayerKey) {
                            localPlayer = Actor;
                            break;
                        }
                    }

                    {
                        if (localPlayer) {
localteamid = localPlayer->TeamID;
                    std::vector<ASTExtraPlayerCharacter *> PlayerCharacter;
                    GetAllActors(PlayerCharacter);
                    for (auto actor = PlayerCharacter.begin();
                         actor != PlayerCharacter.end(); actor++) {
                        auto Actor = *actor;
                        if (Actor->TeamID == localPlayer->TeamID ||
                            Actor->bDead || Actor->bHidden ||
                            !Actor->RootComponent || Actor == localPlayer) continue;
if (!overlay)
{
                        if(menu::ESP::ESPSkeleton)
                        {
                          static const std::pair<SDK::FName, SDK::FName> skeleton[] =
                          {
                              {"neck_01", "spine_03"}, {"spine_03", "spine_02"},
                              {"spine_02", "spine_01"}, {"spine_01", "pelvis"},
                              {"neck_01", "clavicle_r"}, {"clavicle_r", "upperarm_r"},
                              {"upperarm_r", "lowerarm_r"}, {"lowerarm_r", "hand_r"},
                              {"neck_01", "clavicle_l"}, {"clavicle_l", "upperarm_l"},
                              {"upperarm_l", "lowerarm_l"}, {"lowerarm_l", "hand_l"},
                              {"pelvis", "thigh_r"}, {"thigh_r", "calf_r"},
                              {"calf_r", "foot_r"}, {"pelvis", "thigh_l"},
                              {"thigh_l", "calf_l"}, {"calf_l", "foot_l"}
                          };

                          FVector2D BoneScreenPos[2];
                          for (const auto& [bone1, bone2] : skeleton)
                          {
                              FVector BonePos1 = Actor->GetBonePos( bone1, {});
                              FVector BonePos2 = Actor->GetBonePos(  bone2, {});

                              if (W2S(BonePos1, &BoneScreenPos[0]) && W2S(BonePos2, &BoneScreenPos[1]))
                              {
                                  DrawLine(HUD, BoneScreenPos[0], BoneScreenPos[1], EspSktonThik, {1,1,1,1});

                              }
                          }
                        }
                    }
                    }
                            if (menu::ESP::ipadview) {
                                auto ThirdPersonCameraComponent = localPlayer->ThirdPersonCameraComponent;
                                if (ThirdPersonCameraComponent) {
                                    *(float *) ((uintptr_t) &ThirdPersonCameraComponent->OrthoWidth - sizeof(float)) = menu::ESP::viewvalue;
                                }
                            }

                         auto WeaponManagerComponent = localPlayer->WeaponManagerComponent;
                        if (menu::silent::enable) {
                          auto WeaponManagerComponent = localPlayer->WeaponManagerComponent;
                          if (WeaponManagerComponent) {
                              auto propSlot = WeaponManagerComponent->GetCurrentUsingPropSlot();
                              if ((int) propSlot.GetValue() >= 1 && (int) propSlot.GetValue() <= 3) {
                                  auto CurrentWeaponReplicated = (ASTExtraShootWeapon *) WeaponManagerComponent->CurrentWeaponReplicated;
                                  if (CurrentWeaponReplicated) {
                                      auto ShootWeaponComponent = CurrentWeaponReplicated->ShootWeaponComponent;
                                      if (ShootWeaponComponent) {
                                          int shoot_event_idx = 169;
                                          auto VTable = (void **) ShootWeaponComponent->VTable;
                                          if (VTable && (VTable[shoot_event_idx] != shoot_event)) {
                                              orig_shoot_event = decltype(orig_shoot_event)(
                                                      VTable[shoot_event_idx]);
                                              VTable[shoot_event_idx] = (void *) shoot_event;
                                          }
                                      }
                                  }
                              }
                          }
                      }
                            if (menu::aimbot::enable) {
                                ASTExtraPlayerCharacter *Target = GetTargetByCrossDist();
                                
                                if (Target && Target->RootComponent) {
                                
                                  
                                    bool triggerOk = false;
                                    if (menu::aimbot::trigger != 0) {
                                        if (menu::aimbot::trigger == 1) {
                                            triggerOk = g_LocalPlayer->bIsWeaponFiring;
                                        } else if (menu::aimbot::trigger == 2) {
                                            triggerOk = g_LocalPlayer->bIsGunADS;
                                        } else if (menu::aimbot::trigger == 3) {
                                            triggerOk = g_LocalPlayer->bIsWeaponFiring && g_LocalPlayer->bIsGunADS;
                                        } else if (menu::aimbot::trigger == 4) {
                                            triggerOk = g_LocalPlayer->bIsWeaponFiring || g_LocalPlayer->bIsGunADS;
                                        }
                                    } else triggerOk = true;
                                    if (triggerOk) {
                                        FVector targetAimPos;
                                        if (menu::aimbot::target == 0) {
                                            targetAimPos = Target->GetBonePos("Head", {});
                                        }
                                        if (menu::aimbot::target) {
                                            targetAimPos = Target->GetBonePos("pelvis", {});
                                        }
                                        if (menu::aimbot::ReCo) {
                                                    if (g_LocalPlayer->bIsGunADS) {
                                                        if (g_LocalPlayer->bIsWeaponFiring) {
                                                            float dist = g_LocalPlayer->GetDistanceTo(Target) / 100.f;
                                                            targetAimPos.Z -= dist * menu::aimbot::Recc;
                                                        }
                                                    }
                                                }
                                        auto WeaponManagerComponent = localPlayer->WeaponManagerComponent;
                                                        if (WeaponManagerComponent)
                                                        {
                                                            auto propSlot = WeaponManagerComponent->GetCurrentUsingPropSlot();
                                                            if ((int)propSlot.GetValue() >= 1 && (int)propSlot.GetValue() <= 3)
                                                            {
                                                                auto CurrentWeaponReplicated = (ASTExtraShootWeapon *)WeaponManagerComponent->CurrentWeaponReplicated;
                                                                if (CurrentWeaponReplicated)
                                                                {
                                                                    auto ShootWeaponComponent = CurrentWeaponReplicated->ShootWeaponComponent;
                                                                    if (ShootWeaponComponent)
                                                                    {
                                                                        UShootWeaponEntity *ShootWeaponEntityComponent = ShootWeaponComponent->ShootWeaponEntityComponent;
                                                                        
                                                                        if (ShootWeaponEntityComponent) {
                                                                            ASTExtraVehicleBase *CurrentVehicle = Target->CurrentVehicle;
                                                                            if (CurrentVehicle) {
                                                                                FVector LinearVelocity = CurrentVehicle->ReplicatedMovement.LinearVelocity;
                                                                                float dist = g_LocalPlayer->GetDistanceTo(Target);
                                                                                auto timeToTravel = dist / ShootWeaponEntityComponent->BulletFireSpeed;
                                                                                targetAimPos = UMC->Add_VectorVector(targetAimPos, UMC->Multiply_VectorFloat(LinearVelocity, timeToTravel));
                                                                            } else {
                                                                                FVector Velocity = Target->GetVelocity();
                                                                                float dist = g_LocalPlayer->GetDistanceTo(Target);
                                                                                auto timeToTravel = dist / ShootWeaponEntityComponent->BulletFireSpeed;
                                                                                targetAimPos =UMC->Add_VectorVector(targetAimPos, UMC->Multiply_VectorFloat(Velocity, timeToTravel));
                                                                            }
                                                                        }
                                                                        
                                                                        FVector fDir = UKismetMathLibrary::Subtract_VectorVector(targetAimPos, localPlayerController->PlayerCameraManager->CameraCache.POV.Location);
                                                                        FRotator Yaptr = UKismetMathLibrary::Conv_VectorToRotator(fDir);
                                                                        FRotator CpYaT = g_PlayerController->PlayerCameraManager->CameraCache.POV.Rotation;
                                                                        
                                                                        
                                                                        
                                                                        Yaptr.Pitch -= CpYaT.Pitch;
                                                                        Yaptr.Yaw -= CpYaT.Yaw;
                                                                        Yaptr.Roll = 0.f;
                                                                        NekoHook(Yaptr);
                                                                        CpYaT.Pitch += Yaptr.Pitch /  AimSpeed;// Aim X Speed Make Float : Xs
                                                                        CpYaT.Yaw += Yaptr.Yaw /  AimSpeed; // Aim Y Speed Make Float : Ys
                                                                        CpYaT.Roll = 0.f;
                                                                        g_PlayerController->SetControlRotation(CpYaT,"");
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            if(!localPlayer->IsUsingGrenade()) {
                                auto WeaponManagerComponent = localPlayer->WeaponManagerComponent;
                                if (WeaponManagerComponent) {
                                    auto propSlot = WeaponManagerComponent->GetCurrentUsingPropSlot();
                                    if ((int) propSlot.GetValue() >= 1 &&
                                        (int) propSlot.GetValue() <= 3) {
                                        auto CurrentWeaponReplicated = (ASTExtraShootWeapon *) WeaponManagerComponent->CurrentWeaponReplicated;
                                        if (CurrentWeaponReplicated) {
                                            auto ShootWeaponEntityComp = CurrentWeaponReplicated->ShootWeaponEntityComp;
                                            auto ShootWeaponEffectComp = CurrentWeaponReplicated->ShootWeaponEffectComp;
                                            auto ID = CurrentWeaponReplicated->GetWeaponID();
                                            if(ID != 108004 && ID != 108003 && ID != 108002 && ID != 108001 && ID != 108000 && ID != 108005 && ID != 108006 && ID != 108007)
                                                
                                                if (ShootWeaponEntityComp && ShootWeaponEffectComp){
                                                    if (menu::memory::crosshair) {
                                                        memset(&ShootWeaponEntityComp->DeviationInfo, 0, sizeof(FSDeviation));
                                                        
                                                        ShootWeaponEntityComp->ShotGunCenterPerc = 0.0f;
                                                        ShootWeaponEntityComp->ShotGunVerticalSpread = 0.0f;
                                                        ShootWeaponEntityComp->ShotGunHorizontalSpread = 0.0f;
                                                        
                                                        ShootWeaponEntityComp->GameDeviationFactor = 0.0f;
                                                        ShootWeaponEntityComp->GameDeviationAccuracy = 0.0f;
                                                        
                                                        ShootWeaponEntityComp->CrossHairInitialSize = 0.0f;
                                                        ShootWeaponEntityComp->CrossHairBurstSpeed = 0.0f;
                                                        ShootWeaponEntityComp->CrossHairBurstIncreaseSpeed = 0.0f;
                                                        ShootWeaponEntityComp->VehicleWeaponDeviationAngle = 0.0f;
                                                    }
                                                    if (menu::memory::xhit) {
                                                        ShootWeaponEntityComp->ExtraHitPerformScale = 100;
                                                        ShootWeaponEntityComp->  HUDAlphaDecreaseSpeedScale = 1.f;
                                                    }
                                                    
                                                    if (menu::memory::noshake) {
                                                        ShootWeaponEffectComp->CameraShakeInnerRadius = 0.0f;
                                                        ShootWeaponEffectComp->CameraShakeOuterRadius = 0.0f;
                                                        ShootWeaponEffectComp->CameraShakFalloff = 0.0f;
                                                    }
                                                    
                                                    if (menu::memory::norecoil) {
                                                        ShootWeaponEntityComp->AccessoriesVRecoilFactor = 0.0f;
                                                        ShootWeaponEntityComp->AccessoriesHRecoilFactor = 0.0f;
                                                        ShootWeaponEntityComp->AccessoriesRecoveryFactor = 0.0f;
                                                    }
                                                    
                                                    if(menu::memory::rapidshoot){
                                                        ShootWeaponEntityComp->ShootInterval =0.060606f;
                                                    }
                                                    if(menu::memory::rapidfire) {
                                                        ShootWeaponEntityComp->BulletFireSpeed = 80000.f;
                                                    }
                                                }
                                            
                                        }
                                    }
                                }
                            }
                            if (TeleportEnemy && localPlayer) {
                                TArray<AActor*> Actors;
                                UGameplayStatics::GetAllActorsOfClass(GWorld, AActor::StaticClass(), &Actors);
                                
                                ACharacter* nearestEnemy = nullptr;
                                float nearestDist = 99999.0f;
                                
                                for (int i = 0; i < Actors.Num(); i++) {
                                    AActor* actor = Actors[i];
                                    if (!actor || actor == localPlayer) continue;
                                    
                                    if (actor->IsA(ACharacter::StaticClass())) {
                                        float dist = localPlayer->GetDistanceTo(actor) / 70.0f;
                                        if (dist < 100.0f && dist < nearestDist) {
                                            nearestEnemy = static_cast<ACharacter*>(actor);
                                            nearestDist = dist;
                                        }
                                    }
                                }
                                
                                if (nearestEnemy) {
                                    FVector enemyLoc = nearestEnemy->K2_GetActorLocation();
                                    
                                    // Estimate forward vector using yaw rotation
                                    FRotator enemyRot = nearestEnemy->K2_GetActorRotation();
                                    float yawRad = enemyRot.Yaw * 3.14159265f / 180.0f;
                                    FVector enemyForward = FVector(cosf(yawRad), sinf(yawRad), 0.0f);
                                    
                                    FVector teleportLoc = enemyLoc - enemyForward * 150.0f;
                                    
                                    // Check if player is already near the teleport location
                                    if (FVector::Distance(localPlayer->K2_GetActorLocation(), teleportLoc) > 10.0f) {
                                        FHitResult unusedHitResult;
                                        localPlayer->K2_SetActorLocation(teleportLoc, false, true, &unusedHitResult);
                                        
                                        // Calculate direction to enemy and apply rotation once
                                        FVector lookDir = enemyLoc - teleportLoc;
                                        lookDir.Z = 0; // Ignore vertical to avoid camera shake
                                        
                                        float yaw = atan2f(lookDir.Y, lookDir.X) * 180.0f / 3.14159265f;
                                        FRotator rotToEnemy;
                                        rotToEnemy.Yaw = roundf(yaw); // Round to nearest degree to reduce jitter
                                        rotToEnemy.Pitch = 0;
                                        rotToEnemy.Roll = 0;
                                        
                                        localPlayer->K2_SetActorRotation(rotToEnemy, true);
                                    }
                                }
                            }








                            
                        if (ModSkinn){
                       if (DeadBox){
                       std::vector<APlayerTombBox *> TombBox;
                        GetAllActors(TombBox);
                        for (auto actor = TombBox.begin();
                             actor != TombBox.end(); actor++) {
                            auto TombBoxx = *actor;
                            if (TombBoxx && TombBoxx->DamageCauser && TombBoxx->TargetPlayer && g_PlayerController) // Check pointers before dereferencing
                            {
                                if (TombBoxx->DamageCauser->PlayerKey == g_PlayerController->PlayerKey)
                                {
                                    auto PlayerKey = TombBoxx->TargetPlayer->PlayerKey;
                                    if (AlreadyChangedSet.find(PlayerKey) == AlreadyChangedSet.end())
                                    {
                                        if (g_LocalPlayer && g_LocalPlayer->WeaponManagerComponent) // Check pointers before dereferencing
                                        {
                                            auto DeadBoxAvatarCompPtr = (uintptr_t*)((uintptr_t)TombBoxx + 0x678); //DeadBoxAvatarComponent_BP_C* DeadBoxAvatarComponent_BP
                                            if (DeadBoxAvatarCompPtr)
                                            {
                                                auto DeadBoxAvatarComp = *DeadBoxAvatarCompPtr;
                                                auto CurrentWeaponReplicated = g_LocalPlayer->WeaponManagerComponent->CurrentWeaponReplicated;
                                                if (CurrentWeaponReplicated)
                                                {
                                               
                                                        auto Weaponid = g_LocalPlayer->WeaponManagerComponent->CurrentWeaponReplicated->GetWeaponID();
                                                    if (Weaponid == 101004) {
                                                    ChangeItemAVc(DeadBoxAvatarComp, new_Skin.M416_1);
                                                    AlreadyChangedSet.insert(PlayerKey);
                                                    } else if (Weaponid == 101001) {
                                                    ChangeItemAVc(DeadBoxAvatarComp, new_Skin.AKM);
                                                    AlreadyChangedSet.insert(PlayerKey);
                                                    } else if (Weaponid == 101003) {
                                                    ChangeItemAVc(DeadBoxAvatarComp, new_Skin.Scar);
                                                    AlreadyChangedSet.insert(PlayerKey);
                                                    } else if (Weaponid == 101008) {
                                                    ChangeItemAVc(DeadBoxAvatarComp, new_Skin.M762);
                                                    AlreadyChangedSet.insert(PlayerKey);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                            
                        }
        }
                    
        
     if (localPlayer->WeaponManagerComponent != 0) {
     if (localPlayer->WeaponManagerComponent->CurrentWeaponReplicated != 0 ) {
         int weapowep = localPlayer->WeaponManagerComponent->CurrentWeaponReplicated->GetWeaponID();
        auto currentTime = std::chrono::steady_clock::now();
         auto landchud = localPlayer->WeaponManagerComponent->CurrentWeaponReplicated->synData;
         auto timeDiff = std::chrono::duration_cast<std::chrono::milliseconds>(currentTime - lastWeaponChangeTime).count();
         if (timeDiff > 1000) {
         for (int j = 0; j < landchud.Num(); j++) {
             auto& weaponInfo = landchud[j];
             auto weaponid = weaponInfo.DefineID.TypeSpecificID;
             if (weaponid != 0)
             {
                 if (preferences.AKM && weapowep == 101001){
                 for (int i = 0; i < sizeof(akmv) / sizeof(akmv[0]); i++) {
                 if (weaponid == akmv[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.AKM;
                     break;
                  }
                 }
                 for (int i = 0; i < sizeof(akmmag) / sizeof(akmmag[0]); i++) {
                 if (weaponid == akmmag[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.AKM_Mag;
                     break;
                  }
                 }
                }
                if (preferences.KAR98 && weapowep == 103001){
                 for (int i = 0; i < sizeof(kar) / sizeof(kar[0]); i++) {
                 if (weaponid == kar[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.K98;
                     break;
                  }
                 }
                }
                if (preferences.M24 && weapowep == 103002){
                 for (int i = 0; i < sizeof(m24) / sizeof(m24[0]); i++) {
                 if (weaponid == m24[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M24;
                     break;
                  }
                 }
                }
                if (preferences.AWM && weapowep == 103003){
                 for (int i = 0; i < sizeof(awm) / sizeof(awm[0]); i++) {
                 if (weaponid == awm[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.AWM;
                     break;
                  }
                 }
                }
                
                
                if (preferences.TOMMY && weapowep == 102004){
                 for (int i = 0; i < sizeof(tommy) / sizeof(tommy[0]); i++) {
                 if (weaponid == tommy[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.Thompson;
                     break;
                  }
                 }
                }
                if (preferences.ACE32 && weapowep == 101102){
                 for (int i = 0; i < sizeof(ace32) / sizeof(ace32[0]); i++) {
                 if (weaponid == ace32[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.ACE32;
                     break;
                  }
                 }
                }
                
                if (preferences.BIZON && weapowep == 102005){
                 for (int i = 0; i < sizeof(bizon) / sizeof(bizon[0]); i++) {
                 if (weaponid == bizon[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.Bizon;
                     break;
                  }
                 }
                }
                
                if (preferences.VECTOR && weapowep == 102003){
                 for (int i = 0; i < sizeof(vectorr) / sizeof(vectorr[0]); i++) {
                 if (weaponid == vectorr[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.Vector;
                     break;
                  }
                 }
                }
                if (preferences.UMP && weapowep == 102002){
                 for (int i = 0; i < sizeof(ump) / sizeof(ump[0]); i++) {
                 if (weaponid == ump[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.UMP;
                     break;
                  }
                 }
                }
                if (preferences.UZI && weapowep == 102001){
                 for (int i = 0; i < sizeof(uzi) / sizeof(uzi[0]); i++) {
                 if (weaponid == uzi[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.UZI;
                     break;
                  }
                 }
                }
                if (preferences.M16 && weapowep == 101002){
                 for (int i = 0; i < sizeof(m16) / sizeof(m16[0]); i++) {
                 if (weaponid == m16[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M16A4;
                     break;
                  }
                 }
                 for (int i = 0; i < sizeof(m16s) / sizeof(m16s[0]); i++) {
                 if (weaponid == m16s[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M16A4_Stock;
                     break;
                  }
                 }
                 for (int i = 0; i < sizeof(m16mag) / sizeof(m16mag[0]); i++) {
                 if (weaponid == m16mag[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M16A4_Mag;
                     break;
                  }
                 }
                }
                if (preferences.PAN && weapowep == 108004){
                 for (int i = 0; i < sizeof(pan) / sizeof(pan[0]); i++) {
                 if (weaponid == pan[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.Pan;
                     break;
                  }
                 }
                }
                if (preferences.AUG && weapowep == 101006){
                 for (int i = 0; i < sizeof(aug) / sizeof(aug[0]); i++) {
                 if (weaponid == aug[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.AUG;
                     break;
                  }
                 }
                }
                if (preferences.GROZA && weapowep == 101005){
                 for (int i = 0; i < sizeof(groza) / sizeof(groza[0]); i++) {
                 if (weaponid == groza[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.Groza;
                     break;
                  }
                 }
                }
                if (preferences.DP28 && weapowep == 105002){
                 for (int i = 0; i < sizeof(dp) / sizeof(dp[0]); i++) {
                 if (weaponid == dp[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.DP28;
                     break;
                  }
                 }
                }
                if (preferences.M249 && weapowep == 105001){
                 for (int i = 0; i < sizeof(m249) / sizeof(m249[0]); i++) {
                 if (weaponid == m249[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M249;
                     break;
                  }
                 }
                /* for (int i = 0; i < sizeof(m249s) / sizeof(m249s[0]); i++) {
                 if (weaponid == m249s[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M249s;
                     break;
                  }
                 }*/
                }
                
                if (preferences.SCARL && weapowep == 101003){
                 for (int i = 0; i < sizeof(scar) / sizeof(scar[0]); i++) {
                 if (weaponid == scar[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.Scar;
                     break;
                  }
                 }
                 for (int i = 0; i < sizeof(scarmag) / sizeof(scarmag[0]); i++) {
                 if (weaponid == scarmag[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.Scar_Mag;
                     break;
                  }
                 }
                }
                
                if (preferences.M762 && weapowep == 101008){
                 for (int i = 0; i < sizeof(m7) / sizeof(m7[0]); i++) {
                 if (weaponid == m7[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M762;
                     break;
                  }
                 }
                 for (int i = 0; i < sizeof(m7mag) / sizeof(m7mag[0]); i++) {
                 if (weaponid == m7mag[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M762_Mag;
                     break;
                  }
                 }
                }
                
                if (preferences.M416 && weapowep == 101004){
                 for (int i = 0; i < sizeof(m4v) / sizeof(m4v[0]); i++) {
                 if (weaponid == m4v[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M416_1;
                     break;
                  }
                 }
                 for (int i = 0; i < sizeof(m4mag) / sizeof(m4mag[0]); i++) {
                 if (weaponid == m4mag[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M416_2;
                     break;
                  }
                 }
                 for (int i = 0; i < sizeof(m4sight) / sizeof(m4sight[0]); i++) {
                 if (weaponid == m4sight[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M416_3;
                     break;
                  }
                 }
                 for (int i = 0; i < sizeof(m4stock) / sizeof(m4stock[0]); i++) {
                 if (weaponid == m4stock[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M416_4;
                     break;
                  }
                 }
                 for (int i = 0; i < sizeof(m4stock1) / sizeof(m4stock1[0]); i++) {
                 if (weaponid == m4stock1[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M416_stock;
                     break;
                  }
                 }
                 for (int i = 0; i < sizeof(m4reddot) / sizeof(m4reddot[0]); i++) {
                 if (weaponid == m4reddot[i]) {
                     weaponInfo.DefineID.TypeSpecificID = new_Skin.M416_reddot;
                     break;
                  }
                 }
                }
                 localPlayer->WeaponManagerComponent->CurrentWeaponReplicated->DelayHandleAvatarMeshChanged();
                 lastWeaponChangeTime = currentTime;
             }
         }
     }
 }
}
//

if (localPlayer -> CurrentVehicle) {
        if (localPlayer -> CurrentVehicle -> VehicleAvatar) {
          std::string SkinIDStr = std::to_string((int) localPlayer -> CurrentVehicle -> VehicleAvatar -> GetDefaultAvatarID());
          Active::SkinCarDefault = localPlayer -> CurrentVehicle -> GetAvatarID();

          
          if (preferences.Moto && strstr(SkinIDStr.c_str(), "1901")) {
            Active::SkinCarMod = new_Skin.Moto;
            Active::SkinCarNew = true;
          } else if (preferences.Dacia && strstr(SkinIDStr.c_str(), "1903")) {
            Active::SkinCarMod = new_Skin.Dacia;
            Active::SkinCarNew = true;
          } else if (preferences.Boat && strstr(SkinIDStr.c_str(), "1911")) {
            Active::SkinCarMod = new_Skin.Boat;
            Active::SkinCarNew = true;
          } else if (preferences.MiniBus && strstr(SkinIDStr.c_str(), "1904")) {
            Active::SkinCarMod = new_Skin.MiniBus;
            Active::SkinCarNew = true;
          } else if (preferences.Mirado && strstr(SkinIDStr.c_str(), "1914")) {
            Active::SkinCarMod = new_Skin.Mirado;
            Active::SkinCarNew = true;
          } else if (preferences.Mirado && strstr(SkinIDStr.c_str(), "1915")) {
            Active::SkinCarMod = new_Skin.Mirado;
            Active::SkinCarNew = true;
          } else if (preferences.Buggy && strstr(SkinIDStr.c_str(), "1907")) {
            Active::SkinCarMod = new_Skin.Buggy;
            Active::SkinCarNew = true;
          }else if (preferences.CoupeRB && strstr(SkinIDStr.c_str(), "1961")) {
            Active::SkinCarMod = new_Skin.CoupeRP;
            Active::SkinCarNew = true;
          } else if (preferences.BigFoot && strstr(SkinIDStr.c_str(), "1953")) {
            Active::SkinCarMod = new_Skin.Bigfoot;
            Active::SkinCarNew = true;
          } else if (preferences.UAZ && strstr(SkinIDStr.c_str(), "1908")) {
            Active::SkinCarMod = new_Skin.UAZ;
            Active::SkinCarNew = true;
          } else Active::SkinCarNew = false;

          if (Active::SkinCarDefault != Active::SkinCarMod && Active::SkinCarNew) {
            
            localPlayer -> CurrentVehicle -> VehicleAvatar -> ChangeItemAvatar(Active::SkinCarMod, true);
          }
        }
      }

 if (localPlayerController->BackpackComponent){
     auto data = localPlayerController->BackpackComponent->ItemListNet;
     auto bag = data.IncArray;
     for (int j = 0; j < bag.Num(); j++) {
     int ID = bag[j].Unit.DefineID.TypeSpecificID;
     if (preferences.Outfit){
 for (int i = 0; i < sizeof(SuitX) / sizeof(SuitX[0]); i++) {
                 if (ID == SuitX[i]) {
                     bag[j].Unit.DefineID.TypeSpecificID = new_Skin.XSuits;
                     break;
                  }
                 }
                }
                if (preferences.Bagg){
for (int i = 0; i < sizeof(Bag) / sizeof(Bag[0]); i++) {
                 if (ID == Bag[i]) {
                     bag[j].Unit.DefineID.TypeSpecificID = bag3;
                     break;
                  }
                 }
                }
                if (preferences.Helmett){
for (int i = 0; i < sizeof(Helmet) / sizeof(Helmet[0]); i++) {
                 if (ID == Helmet[i]) {
                     bag[j].Unit.DefineID.TypeSpecificID = helmett3;
                     break;
                  }
                 }
                }
                if (preferences.Emote){
for (int i = 0; i < sizeof(emote1) / sizeof(emote1[0]); i++) {
                 if (ID == emote1[i]) {
                     bag[j].Unit.DefineID.TypeSpecificID = sEmote1;
                     break;
                  }
                 }
for (int i = 0; i < sizeof(emote2) / sizeof(emote2[0]); i++) {
                 if (ID == emote2[i]) {
                     bag[j].Unit.DefineID.TypeSpecificID = sEmote2;
                     break;
                  }
                 }
for (int i = 0; i < sizeof(emote3) / sizeof(emote3[0]); i++) {
                 if (ID == emote3[i]) {
                     bag[j].Unit.DefineID.TypeSpecificID = sEmote3;
                     break;
                  }
                 }
                }
      }
   }

 
   if (localPlayer -> AvatarComponent2) {

                                   auto AvatarComp = localPlayer -> AvatarComponent2;
                                   
                                   FNetAvatarSyncData NetAvatarComp = * (FNetAvatarSyncData * )((uintptr_t) AvatarComp + 0x388); //if u use 64bit change this offset
                                   auto Slotsybc = NetAvatarComp.SlotSyncData;
        if (preferences.Parachute){
        Slotsybc[9].ItemId = new_Skin.Parachute;
        }
        if (preferences.Outfit){
        Slotsybc[2].ItemId = new_Skin.XSuits;
        }
        if (preferences.Bagg){
        Slotsybc[5].ItemId = bag3;
        }
        if (preferences.Helmett){
        Slotsybc[6].ItemId = helmett3;
        }
   auto now = std::chrono::high_resolution_clock::now();
auto elapsed = std::chrono::duration_cast<std::chrono::seconds>(now - start).count();

if (elapsed < 1 && callFunction) {
    localPlayer->AvatarComponent2->OnRep_BodySlotStateChanged();
    localPlayerController->BackpackComponent->OnRep_ItemListNet();
} else {
    callFunction = false;
}

    }
 }

                    }
                }
                g_LocalPlayer = localPlayer;
                g_PlayerController = localPlayerController;
            }
        }
    }




    //from NSString to wstring
    std::wstring NStoWS ( NSString* Str )
    {
        NSStringEncoding pEncode    =   CFStringConvertEncodingToNSStringEncoding ( kCFStringEncodingUTF32LE );
        NSData* pSData              =   [ Str dataUsingEncoding : pEncode ];
        return std::wstring ( (wchar_t*) [ pSData bytes ], [ pSData length] / sizeof ( wchar_t ) );
    }
    //from wstring to NSString
    NSString* WStoNS ( const std::wstring& Str )
    {
        NSString* pString = [ [ NSString alloc ]
                              initWithBytes : (char*)Str.data()
                              length : Str.size() * sizeof(wchar_t)
                              encoding : CFStringConvertEncodingToNSStringEncoding ( kCFStringEncodingUTF32LE ) ];
        return pString;
    }
    
    void *(*oProcessEvent)(UObject *pObj, UFunction *pFunc, void *pArgs);
    void *hkProcessEvent(UObject *pObj, UFunction *pFunc, void *pArgs) {
        if (pFunc) {
            if (pFunc->GetFullName() == ("Function Engine.HUD.ReceiveDrawHUD") ){
                AHUD *pHUD = (AHUD *) pObj;
                if (pHUD) {
                    auto Params = (AHUD_ReceiveDrawHUD_Params *) pArgs;
                    if (Params) {
                        RenderESP(pHUD, Params->SizeX, Params->SizeY);
                      screenWidth = Params->SizeX;
                     screenHeight = Params->SizeY;
                    }
                }
            }
        }
        return oProcessEvent(pObj, pFunc, pArgs);
    }


    void  *RTL_language(){
        
        auto MAIN =(FUObjectArray *) (obbbbl());
        auto gobjects = MAIN->ObjObjects;
        for (int i=0;i< gobjects.Num(); i++)
            if (auto obj = gobjects.GetByIndex(i)) {
                
                if(obj->IsA(AHUD::StaticClass())) {
                    auto HUD = (AHUD *) obj;
                    int its = 76;
                    auto VTable = (void**)HUD->VTable;
                    if (VTable && ( VTable[its] != hkProcessEvent)) {
                        oProcessEvent = decltype(oProcessEvent)(VTable[its]);
                        VTable[its] = (void *) hkProcessEvent;
                    }
                }
              if(obj->IsA(ASTExtraPlayerController::StaticClass())) {
                    auto HUD = (ASTExtraPlayerController *) obj;
                    int its = 76;
                    auto VTable = (void**)HUD->VTable;
                    if (VTable && ( VTable[its] != hkProcessEvent)) {
                        oProcessEvent = decltype(oProcessEvent)(VTable[its]);
                        VTable[its] = (void *) hkProcessEvent;
                    }
                }
            }
        return 0;
    }

#define hook GaYSSS9aAL


#define hook GaYSSS9aAL



+ (void)load
{
        FName::GNames = GetGNames();
    while (!FName::GNames) {
        FName::GNames = GetGNames();
          sleep(1);
    }
    
    
    UObject::GUObjectArray = (FUObjectArray *) (obbbbl());
    
    while (!UObject::GUObjectArray) {
    UObject::GUObjectArray = (FUObjectArray *) (obbbbl());
          sleep(1);
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

    
        //start load but not means language
          [self load1];
    });
}
+ (void)load1
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        RTL_language();
    });
}
__attribute__((constructor)) void _init() {
    pthread_t t;
    
  //  pthread_create(&t, 0, bypass_thread, 0);
  //  pthread_create(&t, 0, box_thread, 0);
}

@end
