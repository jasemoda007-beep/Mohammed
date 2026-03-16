#pragma once

#include "imgui/imgui.h"

#include <string>

struct JsonPreferences {  
  int xsuit = 0;
  int skinm4 = 0;
  int skinakm = 0;
  int para = 0;
  int bag = 0;
  int helmet = 0;
  bool CoupeRB = false;
  bool Dacia = false;
  bool UAZ = false;
  bool MiniBus = false;
  bool BigFoot = false;
  bool Boat = false;
  bool Mirado = false;
  bool Buggy = false;
  bool OMirado = false;
  bool Moto = false;
  bool Emote = false;
  bool Helmett = false;
  bool Bagg = false;
  bool Face = false;
  bool Outfit = false;
  bool Parachute = false;
  bool M416 = false;
  bool AKM = false;
  bool SCARL = false;
  bool M762 = false;
  bool AWM = false;
  bool KAR98 = false;
  bool M24 = false;
  bool M16 = false;
  bool M249 = false;
  bool DP28 = false;
  bool GROZA = false;
  bool AUG = false;
  bool PAN = false;
  bool UZI = false;
  bool UMP = false;
  bool TOMMY = false;
  bool BIZON = false;
  bool ACE32 = false;
  bool VECTOR = false;

  struct sConfig {
    struct sModSkin {
      bool Enable = 1;
      // bool HitEffect = 0;
      // bool KillMessage = 0;
      // bool DeadBox = 0;
      int XSuits = 1;
      int AKM = 1;
      int M16A4 = 1;
      int Scar = 1;
      int M416 = 1;
      int Groza = 1;
      int AUG = 1;
      int QBZ = 1;
      int M762 = 1;
      int ACE32 = 1;
      int Parachute = 1;
      int UZI = 1;
      int UMP = 1;
      int Vector = 1;
      int Thompson = 1;
      int Bizon = 1;
      int K98 = 1;
      int M24 = 1;
      int AWM = 1;
      int DP28 = 1;
      int M249 = 1;
      int Pan = 1;
      int Moto = 1;
      int CoupeRP = 1;
      int UAZ = 1;
      int Dacia = 1;
      int Bigfoot = 1;
      int Mirado = 1;
      int OMirado = 1;
      int Buggy = 1;
      int MiniBus = 1;
      int Boat;
    } Skin;
    };
    sConfig Config{false};
};

inline JsonPreferences preferences;
