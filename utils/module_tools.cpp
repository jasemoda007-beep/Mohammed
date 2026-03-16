//
//  module_tools.c
//  Dolphins
//
//  Created by xbk on 2022/4/25.
//

#include "utils/module_tools.h"
#include <math.h>

#pragma mark - 坐标系转换
ImVec3 matrixToVector(Ue4Matrix matrix) {
    return ImVec3(matrix[3][0], matrix[3][1], matrix[3][2]);
}

Ue4Matrix matrixMulti(Ue4Matrix m1, Ue4Matrix m2) {
    Ue4Matrix matrix = Ue4Matrix();
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            for (int k = 0; k < 4; k++) {
                matrix[i][j] += m1[i][k] * m2[k][j];
            }
        }
    }
    return matrix;
}

Ue4Matrix transformToMatrix(Ue4Transform transform) {
    Ue4Matrix matrix;
    
    matrix[3][0] = transform.translation.x;
    matrix[3][1] = transform.translation.y;
    matrix[3][2] = transform.translation.z;
    
    float x2 = transform.rotation.x + transform.rotation.x;
    float y2 = transform.rotation.y + transform.rotation.y;
    float z2 = transform.rotation.z + transform.rotation.z;
    
    float xx2 = transform.rotation.x * x2;
    float yy2 = transform.rotation.y * y2;
    float zz2 = transform.rotation.z * z2;
    
    matrix[0][0] = (1.0f - (yy2 + zz2)) * transform.scale3d.x;
    matrix[1][1] = (1.0f - (xx2 + zz2)) * transform.scale3d.y;
    matrix[2][2] = (1.0f - (xx2 + yy2)) * transform.scale3d.z;
    
    float yz2 = transform.rotation.y * z2;
    float wx2 = transform.rotation.w * x2;
    matrix[2][1] = (yz2 - wx2) * transform.scale3d.z;
    matrix[1][2] = (yz2 + wx2) * transform.scale3d.y;
    
    float xy2 = transform.rotation.x * y2;
    float wz2 = transform.rotation.w * z2;
    matrix[1][0] = (xy2 - wz2) * transform.scale3d.y;
    matrix[0][1] = (xy2 + wz2) * transform.scale3d.x;
    
    float xz2 = transform.rotation.x * z2;
    float wy2 = transform.rotation.w * y2;
    matrix[2][0] = (xz2 + wy2) * transform.scale3d.z;
    matrix[0][2] = (xz2 - wy2) * transform.scale3d.x;
    
    matrix[0][3] = 0;
    matrix[1][3] = 0;
    matrix[2][3] = 0;
    matrix[3][3] = 1;
    
    return matrix;
}

Ue4Matrix rotatorToMatrix(Ue4Rotator rotation) {
    float radPitch = rotation.pitch * ((float) M_PI / 180.0f);
    float radYaw = rotation.yaw * ((float) M_PI / 180.0f);
    float radRoll = rotation.roll * ((float) M_PI / 180.0f);
    
    float SP = sinf(radPitch);
    float CP = cosf(radPitch);
    float SY = sinf(radYaw);
    float CY = cosf(radYaw);
    float SR = sinf(radRoll);
    float CR = cosf(radRoll);
    
    Ue4Matrix matrix;
    
    matrix[0][0] = (CP * CY);
    matrix[0][1] = (CP * SY);
    matrix[0][2] = (SP);
    matrix[0][3] = 0;
    
    matrix[1][0] = (SR * SP * CY - CR * SY);
    matrix[1][1] = (SR * SP * SY + CR * CY);
    matrix[1][2] = (-SR * CP);
    matrix[1][3] = 0;
    
    matrix[2][0] = (-(CR * SP * CY + SR * SY));
    matrix[2][1] = (CY * SR - CR * SP * SY);
    matrix[2][2] = (CR * CP);
    matrix[2][3] = 0;
    
    matrix[3][0] = 0;
    matrix[3][1] = 0;
    matrix[3][2] = 0;
    matrix[3][3] = 1;
    
    return matrix;
}

ImVec2 worldToScreen(ImVec3 worldLocation, MinimalViewInfo camViewInfo, ImVec2 screenCenter) {
    Ue4Matrix tempMatrix = rotatorToMatrix(camViewInfo.rotation);
    
    ImVec3 vAxisX(tempMatrix[0][0], tempMatrix[0][1], tempMatrix[0][2]);
    ImVec3 vAxisY(tempMatrix[1][0], tempMatrix[1][1], tempMatrix[1][2]);
    ImVec3 vAxisZ(tempMatrix[2][0], tempMatrix[2][1], tempMatrix[2][2]);
    
    ImVec3 vDelta = worldLocation - camViewInfo.location;
    
    ImVec3 vTransformed(ImVec3::Dot(vDelta, vAxisY), ImVec3::Dot(vDelta, vAxisZ), ImVec3::Dot(vDelta, vAxisX));
    
    if (vTransformed.z < 1.0f) {
        vTransformed.z = 1.0f;
    }
    ImVec2 screenCoord;
    screenCoord.x = (screenCenter.x + vTransformed.x * (screenCenter.x / tanf(camViewInfo.fov * ((float) M_PI / 360.0f))) / vTransformed.z);
    screenCoord.y = (screenCenter.y - vTransformed.y * (screenCenter.x / tanf(camViewInfo.fov * ((float) M_PI / 360.0f))) / vTransformed.z);
    return screenCoord;
}
//雷达
float getAngleDifference(float angle1, float angle2) {
    float diff = fmod(angle2 - angle1 + 180, 360) - 180;
    return diff < -180 ? diff + 360 : diff;
}

float change(float num) {
    if (num < 0) {
        return abs(num);
    } else if (num > 0) {
        return num - num * 2;
    }
    return num;
}

float get2dDistance(ImVec2 self, ImVec2 object) {
    float osx = self.x - object.x;
    float osy = self.y - object.y;
    
    return sqrt(osx * osx + osy * osy);
}

float get3dDistance(ImVec3 self, ImVec3 object, float divice) {
    ImVec3 xyz;
    xyz.x = self.x - object.x;
    xyz.y = self.y - object.y;
    xyz.z = self.z - object.z;
    return sqrt(pow(xyz.x, 2) + pow(xyz.y, 2) + pow(xyz.z, 2)) / divice;
}

ImVec2 rotateCoord(float angle, ImVec2 coord) {
    float s = sin(angle * M_PI / 180);
    float c = cos(angle * M_PI / 180);
    
    return {coord.x * c + coord.y * s, -coord.x * s + coord.y * c};
}

float rotateAngle(ImVec3 selfCoord, ImVec3 targetCoord) {
    float osx = targetCoord.x - selfCoord.x;
    float osy = targetCoord.y - selfCoord.y;
    return (float) (atan2(osy, osx) * 180 / M_PI);
}

ImVec2 rotateAngleView(ImVec3 selfCoord, ImVec3 targetCoord) {
    
    float osx = targetCoord.x - selfCoord.x;
    float osy = targetCoord.y - selfCoord.y;
    float osz = targetCoord.z - selfCoord.z;
    
    return {(float) (atan2(osy, osx) * 180 / M_PI), (float) (atan2(osz, sqrt(osx * osx + osy * osy)) * 180 / M_PI)};
}

bool isRecycled(const char *name) {
    return strstr(name, "ecycled") != 0;
}
//手持武器
MaterialStruct isWeapon(const char *name) {
    if (strstr(name, "Sniper_QBU") != 0) {
        return {Sniper, 0,  "[sniper gun]QBU" };
    } else if (strstr(name, "Sniper_SLR") != 0) {
        return {Sniper, 1, "[sniper gun]SLR"};
    } else if (strstr(name, "Sniper_SKS") != 0) {
        return {Sniper, 2, "[sniper gun]SKS"};
    } else if (strstr(name, "Sniper_Mini14") != 0) {
        return {Sniper, 3, "[sniper gun]Mini14"};
    } else if (strstr(name, "Sniper_M24") != 0) {
        return {Sniper, 4, "[sniper gun]M24"};
    } else if (strstr(name, "Sniper_Kar98k") != 0) {
        return {Sniper, 5, "[sniper gun]Kar98k"};
    } else if (strstr(name, "Sniper_AWM") != 0) {
        return {Sniper, 6, "[sniper gun]AWM"};
    } else if (strstr(name, "WEP_Mk14") != 0) {
        return {Sniper, 7, "[sniper gun]Mk14"};
    } else if (strstr(name, "Sniper_Mosin") != 0) {
        return {Sniper, 8, "[sniper gun]Mosin Nagant"};
    } else if (strstr(name, "Sniper_MK12") != 0) {
        return {Sniper, 9, "[sniper gun]MK12"};
    } else if (strstr(name, "Sniper_AMR") != 0) {
        return {Sniper, 10, "[sniper gun]AMR"};
    } else if (strstr(name, "Sniper_VSS") != 0) {
        return {Sniper, 10, "[sniper gun]VSS"};
    
    } else if (strstr(name, "Rifle_M762") != 0) {
        return {Rifle, 0, "[rifle]M762"};
    } else if (strstr(name, "Rifle_SCAR") != 0) {
        return {Rifle, 1, "[rifle]SCAR-L"};
    } else if (strstr(name, "Rifle_M416") != 0) {
        return {Rifle, 2, "[rifle]M416"};
    } else if (strstr(name, "Rifle_M16A4") != 0) {
        return {Rifle, 3, "[rifle]M16A4"};
    } else if (strstr(name, "Rifle_Mk47") != 0) {
        return {Rifle, 4, "[rifle]Mk47"};
    } else if (strstr(name, "Rifle_G36") != 0) {
        return {Rifle, 5, "[rifle]G36C"};
    } else if (strstr(name, "Rifle_QBZ") != 0) {
        return {Rifle, 6, "[rifle]QBZ"};
    } else if (strstr(name, "Rifle_Groza") != 0) {
        return {Rifle, 7, "[rifle]Groza"};
    } else if (strstr(name, "Rifle_AUG") != 0) {
        return {Rifle, 8, "[rifle]AUG"};
    } else if (strstr(name, "Rifle_AKM") != 0) {
        return {Rifle, 9, "[rifle]AKM"};
        
    } else if (strstr(name, "Other_DP28") != 0) {
        return {Rifle, 10, "[machinegun]DP28"};
    } else if (strstr(name, "Other_M249") != 0) {
        return {Rifle, 11, "[machinegun]M249"};
    } else if (strstr(name, "Other_MG3") != 0) {
        return {Rifle, 12, "[machinegun]MG3"};
        
    } else if (strstr(name, "Grenade_Shoulei_Weapon_C") != 0) {
        return {Missile, 0, "[Throwable]grenade"};
    } else if (strstr(name, "Grenade_Smoke_Weapon_C") != 0) {
        return {Missile, 1, "[Throwable]smoke bomb"};
    } else if (strstr(name, "Grenade_Burn_Weapon_C") != 0) {
        return {Missile, 2, "[Throwable]Molotov cocktail"};
    
    } else if (strstr(name, "WEP_Pan") != 0) {
        return {WEP, 0, "[Melee]pan"};
    } else if (strstr(name, "WEP_Sickle") != 0) {
        return {WEP, 1, "[Melee]sickle"};
    } else if (strstr(name, "WEP_Machere_") != 0) {
        return {WEP, 2, "[Melee]Machete"};
    } else if (strstr(name, "WEP_Cowbar") != 0) {
        return {WEP, 3, "[Melee]crowbar"};
    
    } else if (strstr(name, "MachineGun_MP5K") != 0) {
        return {MachineGun, 0, "[SMG]MP5K"};
    } else if (strstr(name, "MachineGun_P90") != 0) {
        return {MachineGun, 1, "[SMG]P90"};
    } else if (strstr(name, "MachineGun_TommyGun") != 0) {
        return {MachineGun, 2, "[SMG]TommyGun"};
    } else if (strstr(name, "MachineGun_UMP9") != 0) {
        return {MachineGun, 3, "[SMG]UMP9"};
    } else if (strstr(name, "MachineGun_Uzi") != 0) {
        return {MachineGun, 4, "[SMG]Uzi"};
    } else if (strstr(name, "MachineGun_Vector") != 0) {
        return {MachineGun, 5, "[SMG]Vector"};
    } else if (strstr(name, "MachineGun_Bison") != 0) {
        return {MachineGun, 6, "[SMG]Bison"};
    
    } else if (strstr(name, "ShotGun_S686") != 0) {
        return {ShotGun, 0, "[hail bombgun]S686"};
    } else if (strstr(name, "ShotGun_S1897") != 0) {
        return {ShotGun, 1, "[hail bombgun]S1897"};
    } else if (strstr(name, "ShotGun_S12K") != 0) {
        return {ShotGun, 2, "[hail bombgun]S12K"};
    } else if (strstr(name, "ShotGun_DBS") != 0) {
        return {ShotGun, 3, "[hail bombgun]DBS"};
    } else if (strstr(name, "ShotGun_SawedOff") != 0) {
        return {ShotGun, 4, "[hail bombgun]SawedOff"};
    
    
    } else if (strstr(name, "Pistol_P92") != 0) {
        return {Pistol, 0, "[gun]P92"};
    } else if (strstr(name, "Pistol_P1911") != 0) {
        return {Pistol, 1, "[gun]P1911"};
    } else if (strstr(name, "Pistol_R1895") != 0) {
        return {Pistol, 2, "[gun]R1895"};
    } else if (strstr(name, "Pistol_P18C") != 0) {
        return {Pistol, 3, "[gun]P18C"};
    } else if (strstr(name, "Pistol_R45") != 0) {
        return {Pistol, 4, "[gun]R45"};
    }
    
    return {-1, -1, "NULL"};
}
//地面显示
MaterialStruct isMaterial(const char *name) {
    if (strstr(name, "Motorcycle_") != 0) {
        return {Vehicle, 0, "motorcycle"};
    } else if (strstr(name, "MotorcycleCart") != 0) {
        return {Vehicle, 1, "tricycle"};
    } else if (strstr(name, "Scooter") != 0) {
        return {Vehicle, 2, "Scooty"};// Scooty car
    } else if (strstr(name, "Buggy") != 0) {
        return {Vehicle, 3, "Buggy"};// Buggy
    } else if (strstr(name, "Mirado") != 0) {
        return {Vehicle, 4, "Mirado"};// 玛萨拉蒂
    } else if (strstr(name, "Dacia") != 0) {
        return {Vehicle, 5, "car"};// car
//    } else if (strstr(name, "PickUp") != 0 && strstr(name, "Armor") == 0 && strstr(name, "List") == 0 && strstr(name, "Helmet") == 0 && strstr(name, "Bag") == 0) {
//        return {Vehicle, 6, "pickup truck car"};// pickup truck car
    } else if (strstr(name, "UAZ") != 0) {
        return {Vehicle, 7, "jeep"};// jeep
    } else if (strstr(name, "PG117") != 0) {
        return {Vehicle, 8, "Ofuna"};// 快艇
    } else if (strstr(name, "AquaRail") != 0) {
        return {Vehicle, 9, "motor boat"};// 冲锋艇
    } else if (strstr(name, "MiniBus") != 0) {
        return {Vehicle, 10, "baby bus"};// 面Bag car
    } else if (strstr(name, "BRDM") != 0) {
        return {Vehicle, 11, "armored car"};// 两栖armored car
    } else if (strstr(name, "LadaNiva") != 0) {
        return {Vehicle, 12, "jeep car"};// 拉达尼瓦
    } else if (strstr(name, "Snowbike") != 0) {
        return {Vehicle, 13, "snowmobile"};// 轻型雪地 car
    } else if (strstr(name, "Snowmobile") != 0) {
        return {Vehicle, 14, "snowmobile"};// 重型雪地 car
    } else if (strstr(name, "Rony") != 0) {
        return {Vehicle, 15, "pickup truck"};// 小货 car
    } else if (strstr(name, "CoupeRB_1") != 0) {
        return {Vehicle, 16, "CoupeRB"};// 小货 car
        
    } else if (strstr(name, "PickUpList") != 0) {
        return {Airdrop, 0, "[Box]"};
    } else if (strstr(name, "AirDropList") != 0) {
        return {Airdrop, 1, "[airdrop]"};
//    } else if (strstr(name, "DeadInventoryBox") != 0) {
//        return {Airdrop, 2, "Box"};
//    } else if (strstr(name, "AirDropBox") != 0) {
//        return {Airdrop, 3, "airdrop"};
        
    } else if (strstr(name, "Pistol_Flaregun") != 0) {
        return {FlareGun, 0, "flare gun"};
        
    } else if (strstr(name, "BP_Sniper_QBU_Wrapper_C") != 0) {
        return {Sniper, 0, "QBU"};
    } else if (strstr(name, "BP_Sniper_SLR_Wrapper_C") != 0) {
        return {Sniper, 1, "SLR"};
    } else if (strstr(name, "BP_Sniper_SKS_Wrapper_C") != 0) {
        return {Sniper, 2, "SKS"};
    } else if (strstr(name, "BP_Sniper_Mini14_Wrapper_C") != 0) {
        return {Sniper, 3, "Mini14"};
    } else if (strstr(name, "BP_Sniper_M24_Wrapper_C") != 0) {
        return {Sniper, 4, "M24"};
    } else if (strstr(name, "BP_Sniper_Kar98kv") != 0) {
        return {Sniper, 5, "Kar98k"};
    } else if (strstr(name, "BP_Sniper_AWM_Wrapper_C") != 0) {
        return {Sniper, 6, "AWM"};
    } else if (strstr(name, "BP_Sniper_Mk14_Wrapper_C") != 0) {
        return {Sniper, 7, "Mk14"};
    } else if (strstr(name, "BP_Sniper_Mosin_Wrapper_C") != 0) {
        return {Sniper, 8, "Mosin Nagant"};
    } else if (strstr(name, "BP_Sniper_MK12_Wrapper_C") != 0) {
        return {Sniper, 9, "MK12"};
    } else if (strstr(name, "BP_Sniper_AMR_Wrapper_C") != 0) {
        return {Sniper, 10, "AMR"};
        
    } else if (strstr(name, "BP_Rifle_M762_Wrapper_C") != 0) {
        return {Rifle, 0, "M762"};
    } else if (strstr(name, "BP_Rifle_SCAR_Wrapper_C") != 0) {
        return {Rifle, 1, "SCAR-L"};
    } else if (strstr(name, "BP_Rifle_M416_Wrapper_C") != 0) {
        return {Rifle, 2, "M416"};
    } else if (strstr(name, "BP_Rifle_M16A4_Wrapper_C") != 0) {
        return {Rifle, 3, "M16A4"};
    } else if (strstr(name, "BP_Rifle_Mk47_Wrapper_C") != 0) {
        return {Rifle, 4, "Mk47"};
    } else if (strstr(name, "BP_Rifle_G36_Wrapper_C") != 0) {
        return {Rifle, 5, "G36C"};
    } else if (strstr(name, "BP_Rifle_QBZ_Wrapper_C") != 0) {
        return {Rifle, 6, "QBZ"};
    } else if (strstr(name, "BP_Rifle_Groza_Wrapper_C") != 0) {
        return {Rifle, 7, "Groza"};
    } else if (strstr(name, "BP_Rifle_AUG_Wrapper_C") != 0) {
        return {Rifle, 8, "AUG"};
    } else if (strstr(name, "BP_Rifle_AKM_Wrapper_C") != 0) {
        return {Rifle, 9, "AKM"};
    } else if (strstr(name, "BP_Other_DP28_Wrapper_C") != 0) {
        return {Rifle, 10, "DP28"};
    } else if (strstr(name, "BP_Other_M249_Wrapper_C") != 0) {
        return {Rifle, 11, "M249"};
    } else if (strstr(name, "BP_Other_MG3_Wrapper_C") != 0) {
        return {Rifle, 12, "MG3"};
        
    } else if (strstr(name, "Grenade_Shoulei_Weapon_") != 0) {
        return {Missile, 0, "grenade"};
    } else if (strstr(name, "Grenade_Smoke_Weapon_") != 0) {
        return {Missile, 1, "smoke bomb"};
    } else if (strstr(name, "Grenade_Burn_Weapon_") != 0) {
        return {Missile, 2, "Molotov cocktail"};
        
//    } else if (strstr(name, "Armor_Lv2") != 0) {
//        return {Armor, 0, "[Defend tool]Class II"};
    } else if (strstr(name, "Armor_Lv3") != 0) {
        return {Armor, 1, "Level 3"};
//    } else if (strstr(name, "Bag_Lv2") != 0) {
//        return {Armor, 2, "[背Bag]Level 2 Bag"};
    } else if (strstr(name, "Bag_Lv3") != 0) {
        return {Armor, 3, "Level 3 package"};
//    } else if (strstr(name, "Helmet_Lv2") != 0) {
//        return {Armor, 4, "[Defend tool]Level 2 Helmet"};
    } else if (strstr(name, "Helmet_Lv3") != 0) {
        return {Armor, 5, "Level 3 Helmet"};
        
    } else if (strstr(name, "QT_Sniper") != 0) {
        return {SniperParts, 0, "cheek rest"};
    } else if (strstr(name, "ZDD_Sniper") != 0) {
        return {SniperParts, 1, "sub bomb bag"};
    } else if (strstr(name, "Sniper_FlashHider") != 0) {
        return {SniperParts, 2, "flame arrester"};
    } else if (strstr(name, "Sniper_Compensator") != 0) {
        return {SniperParts, 3, "gun port compensation"};
    } else if (strstr(name, "Sniper_Suppressor") != 0) {
        return {SniperParts, 4, "silencer"};
    } else if (strstr(name, "Sniper_EQ") != 0) {
        return {SniperParts, 5, "Rapid expansion"};
    } else if (strstr(name, "Sniper_E") != 0) {
        return {SniperParts, 6, "expansion"};
        
    } else if (strstr(name, "QT_A") != 0) {
        return {RifleParts, 0, "tactical gunto"};
    } else if (strstr(name, "Large_FlashHider") != 0) {
        return {RifleParts, 1, "flame arrester"};
    } else if (strstr(name, "Large_Compensator") != 0) {
        return {RifleParts, 2, "gun port compensation"};
    } else if (strstr(name, "Large_Suppressor") != 0) {
        return {RifleParts, 3, "silencer"};
    } else if (strstr(name, "Large_EQ") != 0) {
        return {RifleParts, 4, "Rapid expansion"};
    } else if (strstr(name, "Large_E") != 0) {
        return {RifleParts, 5, "expansion"};
        
    } else if (strstr(name, "Pills") != 0) {
        return {Drug, 0, "painkiller"};
    } else if (strstr(name, "Injection") != 0) {
        return {Drug, 1, "adrenaline"};
    } else if (strstr(name, "Drink") != 0) {
        return {Drug, 2, "drinks"};
    } else if (strstr(name, "Firstaid") != 0) {
        return {Drug, 3, "first aid kit"};
    } else if (strstr(name, "FirstAidbox") != 0) {
        return {Drug, 4, "medical kit"};
    } else if (strstr(name, "GasCanBattery_Destructible_") != 0) {
        return {Drug, 5, "oil barrel"};
    
    } else if (strstr(name, "Ammo_556mm") != 0) {
        return {Bullet, 0, "5.56mm"};
    } else if (strstr(name, "Ammo_762mm") != 0) {
        return {Bullet, 1, "7.62mm"};
    } else if (strstr(name, "Ammo_300Magnum") != 0) {
        return {Bullet, 2, "Magnum"};
    } else if (strstr(name, "Ammo_50BMG") != 0) {
        return {Bullet, 3, "Magnum"};
        
    } else if (strstr(name, "WB_ThumbGrip") != 0) {
        return {Grip, 0, "thumb grip"};
    } else if (strstr(name, "WB_LightGrip") != 0) {
        return {Grip, 1, "light grip"};
    } else if (strstr(name, "WB_Vertical") != 0) {
        return {Grip, 2, "vertical grip"};
    } else if (strstr(name, "WB_Angled") != 0) {
        return {Grip, 3, "right angle front grip"};
    } else if (strstr(name, "WB_HalfGrip") != 0) {
        return {Grip, 4, "half grip"};
    } else if (strstr(name, "WB_Lasersight") != 0) {
        return {Grip, 5, "laser grip"};
        
    } else if (strstr(name, "MZJ_HD") != 0) {
        return {Sight, 0, "Red dot"};
    } else if (strstr(name, "MZJ_QX") != 0) {
        return {Sight, 1, "holographic"};
    } else if (strstr(name, "MZJ_3X") != 0) {
        return {Sight, 2, "3X"};
    } else if (strstr(name, "MZJ_4X") != 0) {
        return {Sight, 3, "4X"};
    } else if (strstr(name, "MZJ_6X") != 0) {
        return {Sight, 4, "6X"};
    } else if (strstr(name, "MZJ_8X") != 0) {
        return {Sight, 5, "8X"};
    } else if (strstr(name, "Large_EQ") != 0) {
        return {Sight, 6, "Rapid expansion"};
    } else if (strstr(name, "Large_E") != 0) {
        return {Sight, 7, "expansion"};
    
    } else if (strstr(name, "ProjFire__") != 0) {
        return {Warning, 0, "[early warning]flash"};
    } else if (strstr(name, "ProjBurn_") != 0) {
        return {Warning, 1, "[early warning]Molotov cocktail"};
    } else if (strstr(name, "ProjSmoke_") != 0) {
        return {Warning, 2, "[early warning]smoke bomb"};
    } else if (strstr(name, "ProjGrenade_") != 0) {
        return {Warning, 3, "[early warning]beware of grenades"};
    } else if (strstr(name, "AirAttackBomb") != 0) {
        return {Warning, 4, "[bombingearly warning]watch out for bombed areas"};
    } else if (strstr(name, "ExplosionEffect_Grenade_") != 0) {
        return {Warning, 5, "[early warning]grenade explosion"};
    } else if (strstr(name, "ExplosionEffect_Smoke_") != 0) {
        return {Warning, 6, "[early warning]smoke put smoke"};
    } else if (strstr(name, "ExplosionEffect_Fire_") != 0) {
        return {Warning, 7, "[early warning]smoke put smoke"};
    }
    return {-1, -1, "NULL"};
}
//Box内
MaterialStruct isBoxMaterial(int box_goods_id) {
    if (box_goods_id == 601006) {
        return {Drug, 4, "[medicine]medical kit"};
    } else if (box_goods_id == 601005) {
        return {Drug, 3, "[medicine]first aid kit"};
    } else if (box_goods_id == 601001) {
        return {Drug, 2, "[medicine]drinks"};
    } else if (box_goods_id == 601002) {
        return {Drug, 1, "[medicine]adrenaline"};
    } else if (box_goods_id == 601003) {
        return {Drug, 0, "[medicine]painkiller"};
        
    } else if (box_goods_id == 503002) {
        return {Armor, 0, "[Defend]Class II"};
    } else if (box_goods_id == 503003) {
        return {Armor, 1, "[Defend]Level 3"};
    } else if (box_goods_id == 501002) {
        return {Armor, 2, "[Bag]Level 2 Bag"};
    } else if (box_goods_id == 501006) {
        return {Armor, 3, "[Bag]Level 3 package"};
    } else if (box_goods_id == 502002) {
        return {Armor, 4, "[head]Level 2 Helmet"};
    } else if (box_goods_id == 502003) {
        return {Armor, 5, "[head]Level 3 Helmet"};
        
    } else if (box_goods_id == 105001) {
        return {Sniper, 0, "[sniper]QBU"};
    } else if (box_goods_id == 103009) {
        return {Sniper, 1, "[sniper]SLR"};
    } else if (box_goods_id == 103004) {
        return {Sniper, 2, "[sniper]SKS"};
    } else if (box_goods_id == 103006) {
        return {Sniper, 3, "[sniper]Mini14"};
    } else if (box_goods_id == 103002) {
        return {Sniper, 4, "[sniper]M24"};
    } else if (box_goods_id == 103001) {
        return {Sniper, 5, "[sniper]Kar98k"};
    } else if (box_goods_id == 103003) {
        return {Sniper, 6, "[sniper]AWM"};
    } else if (box_goods_id == 103002) {
        return {Sniper, 7, "[sniper]Mk14"};
    } else if (box_goods_id == 103011) {
        return {Sniper, 9, "[sniper]Mosin Nagant"};
    } else if (box_goods_id == 103100) {
        return {Sniper, 10, "[sniper]MK12"};
    } else if (box_goods_id == 103012) {
        return {Sniper, 11, "[sniper]AMR"};
        
    } else if (box_goods_id == 101008) {
        return {Rifle, 0, "[gun]M762"};
    } else if (box_goods_id == 101003) {
        return {Rifle, 1, "[gun]SCAR-L"};
    } else if (box_goods_id == 101004) {
        return {Rifle, 2, "[gun]M416"};
    } else if (box_goods_id == 101002) {
        return {Rifle, 3, "[gun]M16A4"};
    } else if (box_goods_id == 101009) {
        return {Rifle, 4, "[gun]Mk47"};
    } else if (box_goods_id == 101010) {
        return {Rifle, 5, "[gun]G36C"};
    } else if (box_goods_id == 101007) {
        return {Rifle, 6, "[gun]QBZ"};
    } else if (box_goods_id == 101005) {
        return {Rifle, 7, "[gun]Groza"};
    } else if (box_goods_id == 101006) {
        return {Rifle, 8, "[gun]AUG"};
    } else if (box_goods_id == 101001) {
        return {Rifle, 9, "[gun]AKM"};
        
    } else if (box_goods_id == 105002) {
        return {Rifle, 10, "[machine]DP28"};
    } else if (box_goods_id == 105001) {
        return {Rifle, 11, "[machine]M249"};
    } else if (box_goods_id == 105010) {
        return {Rifle, 12, "[machine]MG3"};
        
    } else if (box_goods_id == 303001) {
        return {Bullet, 0, "[bomb]5.56mm"};
    } else if (box_goods_id == 302001) {
        return {Bullet, 1, "[bomb]7.62mm"};
    } else if (box_goods_id == 306001) {
        return {Bullet, 2, "[bomb]Magnum"};
    } else if (box_goods_id == 308001) {
        return {Bullet, 4, "[bomb]signal bomb"};
        
    } else if (box_goods_id == 203001) {
        return {Sight, 0, "[mirror]Red dot"};
    } else if (box_goods_id == 203002) {
        return {Sight, 1, "[mirror]holographic"};
    } else if (box_goods_id == 203014) {
        return {Sight, 2, "[mirror]3X"};
    } else if (box_goods_id == 203004) {
        return {Sight, 3, "[mirror]4X"};
    } else if (box_goods_id == 203015) {
        return {Sight, 4, "[mirror]6X"};
    } else if (box_goods_id == 203005) {
        return {Sight, 5, "[mirror]8X"};
        
    } else if (box_goods_id == 205003) {
        return {SniperParts, 0, "[sniper accessories]cheek rest"};
    } else if (box_goods_id == 204014) {
        return {SniperParts, 1, "[sniper accessories]sub bomb bag"};
    } else if (box_goods_id == 204010) {
        return {SniperParts, 1, "[sniper accessories]sub bomb bag"};
    } else if (box_goods_id == 201005) {
        return {SniperParts, 2, "[sniper accessories]flame arrester"};
    } else if (box_goods_id == 201003) {
        return {SniperParts, 3, "[sniper accessories]gun port compensation"};
    } else if (box_goods_id == 201007) {
        return {SniperParts, 4, "[sniper accessories]silencer"};
    } else if (box_goods_id == 204009) {
        return {SniperParts, 5, "[sniper accessories]Rapid expansion"};
    } else if (box_goods_id == 204007) {
        return {SniperParts, 6, "[sniper accessories]expansion"};
        
    } else if (box_goods_id == 202004) {
        return {Grip, 0, "[grip]thumb grip"};
    }/*else if (box_goods_id == 000000) {
      return {Grip, 1, "[grip]light grip"};
      }*/ else if (box_goods_id == 202001) {
          return {Grip, 2, "[grip]vertical grip"};
      }/*else if (box_goods_id == 000000) {
        return {Grip, 3, "[grip]right angle front grip"};
        }*/else if (box_goods_id == 202005) {
            return {Grip, 4, "[grip]half grip"};
            
        } else if (box_goods_id == 205002) {
            return {RifleParts, 0, "[Accessories]tactical gunto"};
        } else if (box_goods_id == 201010) {
            return {RifleParts, 1, "[Accessories]flame arrester"};
        } else if (box_goods_id == 201009) {
            return {RifleParts, 2, "[Accessories]gun port compensation"};
        } else if (box_goods_id == 201011) {
            return {RifleParts, 3, "[Accessories]silencer"};
        } else if (box_goods_id == 204013) {
            return {RifleParts, 4, "[Accessories]Rapid expansion"};
        } else if (box_goods_id == 204011) {
            return {RifleParts, 5, "[Accessories]expansion"};
            
        } else if (box_goods_id == 602004) {
            return {Missile, 0, "[cast]grenade"};
        } else if (box_goods_id == 602002) {
            return {Missile, 1, "[cast]smoke bomb"};
        } else if (box_goods_id == 602003) {
            return {Missile, 2, "[cast]Molotov cocktail"};
        }
    return {-1, -1, "[unknown]"};
}
