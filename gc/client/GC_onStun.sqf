private ["_shooter","_selection","_damage","_veh","_weapons"];
_shooter   = _this select 0;
_selection = _this select 1;
_damage    = _this select 2;

if(_damage < 0.01 or _selection == "")exitwith{};
if(_selection == "Legs")exitwith{if(!canstand player)exitwith{};player setHit["Legs", 1];};
if(_selection == "Hands")exitwith{if(handshit player == 1)exitwith{};player setHit["Hands", 1];};

if ( (side group _shooter == WEST) and iscop) then {
  if (firestrikes == 0) then {
    FFWarnPvEh = [name _shooter, "Do not stun other cops or you will be removed from the game!"];
    publicVariable "FFWarnPvEh";
    firestrikes = 3;
  };
  firestrikes = firestrikes - 1;
};

if(_selection != "Melee")then{
  if (!isstunned) then {
    (format["server globalchat ""%1 was stunned by %2"";", name player, name _shooter]) call broadcast;
  };
} else {
  if ("rapewhistle" call INV_GetItemAmount > 0) then {
    [] spawn GC_BlowWhistle;
  };
};

isstunned = true;
StunActiveTime = StunActiveTime + StunTimePerHit;

"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [10];
"dynamicBlur" ppEffectCommit 0;
waitUntil {ppEffectCommitted "dynamicBlur"};
"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit StunActiveTime;

_veh = vehicle player;
if (_veh != player) then{
  if(speed _veh <= 30) then {
    player Action ["eject", _veh];
  } else {
    if (scriptDone handleDamage_handle) then {
      player allowdamage false;
      player Action ["eject", _veh];
      handleDamage_handle = [] spawn {
                private ["_vel","_x","_y","_z"];
                waituntil{sleep 0.50; speed player == 0};
        waituntil{sleep 0.15; _vel = velocity player; _x = _vel select 0; _y = _vel select 1; _z = _vel select 2; ((_x < 1 and _x > -1) and (_y < 1 and _y > -1) and (_z < 1 and _z > -1))};
        player allowdamage true;
      };
    } else {
      player Action ["eject", _veh];
    };
  };
};


if(!(call isprone)) then {
  (format ["%1 switchmove ""%2"";", player, "adthpercmstpslowwrfldnon_4"]) call broadcast;
} else {
  (format ["%1 switchmove ""%2"";", player, "adthppnemstpsraswpstdnon_2"]) call broadcast;
};

_weapons = weapons player - nonlethalweapons;

if (count _weapons > 0 and isciv) then {
  {player removeWeapon _x} forEach _weapons;
  call compile format ['waffenhalter%1 = createVehicle ["weaponholder", position player, [], 0, "NONE"]; waffenhalter%1 setVehicleInit "this setVehicleVarName ""waffenhalter%1""; waffenhalter%1 = this;"; processInitCommands;', rolenumber];
  sleep 0.5;
  (format ["{waffenhalter%2 ADDWEAPONCARGO [_x, 1];} forEach %3; waffenhalter%2 setposasl %4;", player, rolenumber, _weapons, (getposasl player)]) call broadcast;
};

while{StunActiveTime > 0} do {
  if (StunActiveTime > MaxStunTime) then {
    StunActiveTime = MaxStunTime;
  };
  StunActiveTime = StunActiveTime - 1;
  sleep 1;
};

StunActiveTime = 0;

if (animationstate player != "civillying01") then {
  isstunned = false;
  if(player call ISSE_IsVictim)then{(format ["%1 switchmove ""%2"";", player, "amovppnemstpsnonwnondnon"]) call broadcast};
};
