private ["_weapons","_weparray","_corpse"];
player setvariable["killed",nil,false];

if (player getVariable "terrorist") then {
	_class = player getvariable "oldclass";
	_class call GC_ChangeSkin;
	[] call compile preprocessFileLineNumbers "briefing.sqf"
	call addActions;
};

_corpse = _this select 1;

if("car" call INV_haslicense)then{demerits = 10};

if (wipewanted) then {
	if(call compile format["%1_arrest > 0", player]  )then{format["%1_arrest = 0;", player]   call broadcast;};
	if(call compile format["%1_wanted > 0", player]  )then{format["%1_wanted = 0;", player]   call broadcast;};
	if(call compile format['count %1_reason > 0', player]  )then{format['%1_reason = [];', player]   call broadcast;};
	if(call compile format["kopfcash_%1 > 0", player])then{format["kopfcash_%1 = 0;", player] call broadcast;};
	wipewanted = false;
};

removeAllWeapons _corpse;
hidebody _corpse;
_corpse spawn {
	sleep 8;
	deleteVehicle _this;
};

if (gangleader) then {group player selectLeader player};
player removeweapon "ItemGPS";
removeAllWeapons player;
removeBackpack player;
isdead = 0;
siren_is_on = false;
["isdead", isdead] call ClientSaveVar;

if (local_arrest == 0) then {
	if (isciv) then {player setpos getpos (respawnarray select (floor(random(count respawnarray))));};
} else {
	(format ["%1 switchmove ""%2"";", player, "civillying01"]) call broadcast;
	waituntil {sleep 0.5; animationstate player == "civillying01"};
	["arrest", CivTimeInPrison, player] execVM "civmenu.sqf";
};

if (iscop) then {
	if (count playerWeapons == 0 and count playermagazines == 0) then {
		{player addMagazine _x} forEach CopStartGear_Mags;
		{player addWeapon   _x} forEach CopStartGear_Weap;
	} else {
		player addWeapon "NVGoggles";
		player addWeapon "Binocular";
		player addweapon "ItemGPS";
		{player addMagazine _x} forEach playermagazines;
		{player addWeapon   _x} forEach playerWeapons;
	};

	if ( (primaryWeapon player) != "") then {
		private['_type', '_muzzles'];
		_type = primaryWeapon player;
		_muzzles = getArray(configFile >> "cfgWeapons" >> _type >> "muzzles");

		if (count _muzzles > 1) then {
			player selectWeapon (_muzzles select 0);
		} else {
			player selectWeapon _type;
		};
	};
	_weapons = weapons player;
	_weparray = _weapons - nonlethalweapons;
	if (count _weparray > 0) then {
		{ if ([_x] call isPistol) then {saveWeaponPistol = [_x,false,true];}; } foreach _weparray;
		player action ["SWITCHWEAPON", player, player, 1];
		player action ["SWITCHWEAPON", player, player, 0];
	};
	_weparray call GC_pistolActions;

	if (('pistole' call INV_GetItemAmount) > 0) then {
		unholsterPistol = player addAction ["Unholster Pistol","pistolControl.sqf",[false]];
	};

	if (!("swat_training" call INV_HasLicense)) then {
		format['%1 setObjectTexture [0, "images\gcpolice.paa"]', player] call broadcast;
	};
} else {
	saveWeaponPistol = ["",false,false];
};

weaponsloaded = true;
wipewanted = true;

if (('handy' call INV_GetItemAmount) < 1) then {
  ["handy", 1] call INV_AddInventoreItem;
};