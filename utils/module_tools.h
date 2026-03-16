//
//  CustomStrcut.h
//  Dolphins
//
//  Created by 明笙 on 2022/4/24.
//

#ifndef CustomStrcut_h
#define CustomStrcut_h

#include "imgui/imgui.h"

#include <string>

enum SystemStatus {
    //
    WaitingResponse,
    //system error
    SystemError,
    //need to be update
    NeedUpdate,
    //login failure
    LoginFailure,
    //checking failure
    CheckFailure,
    //transmission normal
    TransmissionNormal,
};

enum MaterialType{
    Null = -1,
    Vehicle = 0,
    Airdrop = 1,
    FlareGun = 2,
    Sniper = 3,
    Rifle = 4,
    Missile = 5,
    Armor = 6,
    SniperParts = 7,
    RifleParts = 8,
    Drug = 9,
    Bullet = 10,
    Grip = 11,
    Sight = 12,
    Warning = 13,
    All = 14,
    WEP=15,
    MachineGun=16,
    Pistol=17,
    ShotGun=18
    
};


struct MainSwitch {
    bool playerStatus;
    bool materialStatus;
    bool aimbotStatus;
    bool hide;
};


struct PlayerSwitch {
    //box
    bool boxStatus;
    //bone
    bool boneStatus;
    //line
    bool lineStatus;
    //info
    bool infoStatus;
    //radar
    bool radarStatus;
    //back
    bool backStatus;
    //SCS
    bool SCStatus;
    //SCW
    bool SCWZStatus;
    //WZ
    bool WZStatus;
    //WZWZ
    bool WZWZStatus;
    //jd
    bool jdStatus;
    //简洁
    bool jjStatus;
    //radar size
    float radarSize;
    //radar coord
    ImVec2 radarCoord;
};


struct AimbotController {
    //fall no aim
    bool fallNotAim;
    //aimbot mode
    int aimbotMode;
    //aimbot part
    int aimbotParts;
    //aimbot radius
    float aimbotRadius;
    //
    bool showAimbotRadius;
    //aimbot intensity
    float aimbotIntensity;
    
    float distance;
    
    bool smoke;
};

struct ModuleControl{
    bool menuStatus;
    
    int fps;
    //
    SystemStatus systemStatus;
    
    MainSwitch mainSwitch;
    
    PlayerSwitch playerSwitch;
    
    bool materialSwitch[All];
    
    AimbotController aimbotController;
};


struct BonesData {
    ImVec2 head;
    ImVec2 pit;
    ImVec2 pelvis;
    ImVec2 lcollar;
    ImVec2 rcollar;
    ImVec2 lelbow;
    ImVec2 relbow;
    ImVec2 lwrist;
    ImVec2 rwrist;
    ImVec2 lthigh;
    ImVec2 rthigh;
    ImVec2 lknee;
    ImVec2 rknee;
    ImVec2 lankle;
    ImVec2 rankle;
};

struct PlayerData {
    std::string name;
    ImVec2 screen;
    ImVec2 size;
    ImVec2 radar;
    float angle;
    int team;
    float Vehiclehp;
    float Vehiclefuel;
    float hp;
    std::string weaponName;
    std::string statusName;
    int distance;
    int robot;
    int status;
    BonesData bonesData;
    bool visibility;
    
};


struct MaterialData {
    int type;
    int id;
    std::string name;
    int distance;
    float Vehiclehp;
    float Vehiclefuel;
    ImVec2 screen;
};

struct StaticPlayerData {
    uintptr_t addr;
    uintptr_t coordAddr;
    std::string name;
    int team;
    int status;
    bool robot;
};

struct StaticMaterialData {
    std::string name;
    int type;
    int id;
    uintptr_t addr;
    uintptr_t coordAddr;
};

struct Ue4Transform {
    ImVec4 rotation;
    ImVec3 translation;
    ImVec3 scale3d;
};

struct Ue4Matrix {
    float matrix[4][4];
    
    float *operator[](int index) {
        return matrix[index];
    }
    
};

struct Ue4Rotator {
    float pitch;
    float yaw;
    float roll;
};

struct MinimalViewInfo {
    ImVec3 location;
    ImVec3 locationLocalSpace;
    Ue4Rotator rotation;
    float fov;
};

struct MaterialStruct {
    int type;
    int id;
    char name[64];
};

ImVec3 matrixToVector(Ue4Matrix matrix);

Ue4Matrix matrixMulti(Ue4Matrix m1, Ue4Matrix m2);

Ue4Matrix transformToMatrix(Ue4Transform transform);

Ue4Matrix rotatorToMatrix(ImVec3 rotation);

ImVec2 worldToScreen(ImVec3 worldLocation, MinimalViewInfo camViewInfo, ImVec2 screenCenter);
//convert angle 0-360
float getAngleDifference(float angle1, float angle2);
//Positive and negative conversion
float change(float num);
//Calculate 2D distance
float get2dDistance(ImVec2 self, ImVec2 object);
//Calculate 3D distance
float get3dDistance(ImVec3 self, ImVec3 object, float divice);

//Rotate the specified angle 2D coordinates
ImVec2 rotateCoord(float angle, ImVec2 coord);
//Calculate 3D coordinates 2d angle
float rotateAngle(ImVec3 selfCoord, ImVec3 targetCoord);
//Calculate 3D coordinates 3D angle
ImVec2 rotateAngleView(ImVec3 selfCoord, ImVec3 targetCoord);
//Determine whether the material has been ingested
bool isRecycled(const char *name);
//Is it a weapon
MaterialStruct isWeapon(const char *name);
//Is it a material
MaterialStruct isMaterial(const char *name);
//Whether it is a material (box)
MaterialStruct isBoxMaterial(int box_goods_id);
#endif /* CustomStrcut_h */


