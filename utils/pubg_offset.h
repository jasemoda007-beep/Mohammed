
#include <stdio.h>
#include <string>
namespace PubgOffset {

int UpdateVolleyShootParametersOffset = 0x4E0;
int dw_Rotation = 0x18;
int dw_Location = 0x0;
int dw_FOV = 0x24;
int dw_MinimalViewInfo = 0x10;
int dw_CameraCacheEntry = 0x470;
int MaxDistFromMainChar = 0xf2c;


int PlayerControllerOffset[3] = {0x38, 0x78, 0x30};
namespace PlayerControllerParam {
int SelfOffset = 0x2718;//0x2518更新
int MouseOffset = 0x468;//0x420
int CameraManagerOffset = 0x4d0;//0x488
int AngleOffset = 0x498;//视角 bool bAutoManageActiveCameraTarget
namespace CameraManagerParam{
int PovOffset = 0x1040;//0xfC0
}
namespace ControllerFunction {

int LineOfSightToOffset = 0x788;
}
}
int ULevelOffset = 0x30;//uLevel
namespace ULevelParam {
int ObjectArrayOffset = 0xA0;//数组
int ObjectCountOffset = 0xA8;//成员数量
}

namespace ObjectParam {
int ClassIdOffset = 0x18;
int ClassNameOffset = 0xC;

namespace PlayerFunction {
int AddControllerYawInputOffset = 0x868;
int AddControllerRollInputOffset = 0x860;
int AddControllerPitchInputOffset = 0x870;
}
int StatusOffset = 0xfa0;
int TeamOffset = 0x928;//队伍
int NameOffset = 0x8f0;//名字
int RobotOffset = 0x9d7;//人机
int HpOffset = 0xdb0;//血量
int HpmaxOffset = 0xdb4;//血量max
int bDeadOffset = 0xdcc;//死亡判断
int isDead = 0xdcc;

int VehicleCommonComponentOffset = 0x9b8;//载具数组
int VehicleHPOffset = 0x2a4;//载具血量
int VehicleHPMaxOffset= 0x2a0;//载具最大血量
int VehicleFuelOffset = 0x318;//载具耐久
int VehicleFuelMaxOffset = 0x314;//载具最大耐久

int judian1 = 0xc58;
int judian2 = 0xc74;
int judian3 = 0xba0;
int BulletFireSpeed = 0x4f8;
int HitEffect = 0xc5c;
int ipadView = 0x1A28;
int ipadView1 = 0x32C;

int MoveCoordOffset = 0xb0;//人物移动坐标
int MeshOffset = 0x498;//人物骨骼列阵
int boneCountOffset = 0x828;
namespace MeshParam{
int HumanOffset = 0x1b0;//人物骨骼基矩阵
int BonesOffset = 0x878;//人物骨骼
}
int OpenFireOffset = 0x16d0;//开火
int OpenTheSightOffset = 0x1069;//开镜
int BulletTrackOffset = 0x498;//视角追踪
int WeaponOneOffset = 0x2928 + 0x20;//人物手持武器
namespace WeaponParam{
int MasterOffset = 0xB0;
int ShootModeOffset = 0xf1c;//武器射击模式0xebc更新
int WeaponAttrOffset = 0x1048;//武器属性0xfe8更新
int ShootWeaponComponentOffset = 0xFD8;
//int wuhou1 = 0xb28;// float AccessoriesVRecoilFactor;
//int wuhou2 = 0xb2c;// float AccessoriesHRecoilFactor
//int wuhou3 = 0xb30;// float AccessoriesRecoveryFactor
//
//int judian1 = 0xc58;// float RecoilKickADS
//int judian2 = 0xc74;// float AnimationKick
//int judian3 = 0xba0;// float GameDeviationFactor
//int judian4 = 0xb94;// float ShotGunCenterPerc
//int judian5 = 0xb98;// float ShotGunVerticalSpread
//int judian6 = 0xb9c;// float ShotGunHorizontalSpread
//int judian7 = 0xba4;// float GameDeviationAccuracy
//int judian8 = 0xbb0;// float CrossHairInitialSize
//int judian9 = 0xbb4;// float CrossHairBurstSpeed
//int judian10 = 0xbb8;// float CrossHairBurstIncreaseSpeed

int hit1 = 0xc5c;// float ExtraHitPerformScale
int hit2 = 0xc60;// float HUDAlphaDecreaseSpeedScale

// struct UCameraComponent* ThirdPersonCameraComponent; // Offset: 0x1918 // Size: 0x08
// float FieldOfView; // : 0x2cc // Size: 0x04
int ThCamera = 0x1ae0;// struct UCameraComponent* ThirdPersonCameraComponent
float FOV = 0x33c;// struct UCameraComponent : USceneComponent { // float FieldOfView






int shun = 0x4f8;// float BulletFireSpeed
namespace WeaponAttrParam{
int BulletSpeedOffset = 0x508;
int RecoilOffset = 0xC58;
}
}
int GoodsListOffset = 0x8a0;
namespace GoodsListParam {
int DataBase = 0x38;
}
int CoordOffset = 0x1b0;
namespace CoordParam {
int HeightOffset = 0x17C;
int CoordOffset = 0x168;
}
}
}
