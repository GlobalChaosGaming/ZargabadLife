private ["_dummyGroup","_type","_oldtype","_oldUnit","_ar","_fSelectWeapon","_score","_rank","_damage","_armor","_jail","_newUnit"];
_type = _this;
_oldtype = typeof player;
_oldUnit = player;
_oldUnit allowdammage false;
_ar = [weapons _oldUnit, magazines _oldUnit, rank _oldUnit, score _oldUnit, group _oldUnit, getPos _oldUnit, (leader _oldUnit) == _oldUnit, vehicleVarName _oldUnit, getDir _oldUnit, name _oldUnit];

_fSelectWeapon = {
	private ["_unit", "_weap", "_cfg", "_muz", "_ar"];
	_unit = _this select 0;
	_weap = _this select 1;
	_cfg = (configFile >> "CfgWeapons" >> _weap >> "muzzles");
	if (isArray _cfg) then {
		_ar = getArray _cfg;
		_muz = _ar select 0;
		if (_muz == "this") then { _muz = _weap };
	} else {
		_muz = _weap;
	};

	if (player hasWeapon _weap) then { _unit selectWeapon _muz };
};

_score = score _oldUnit;
_rank = rank _oldUnit;
_damage = damage _oldUnit;
_armor = _oldUnit getVariable "bodyarmorhits";
_jail = _oldUnit getVariable "releasetime";
_bombtime = _oldUnit getvariable "bomb_ctime";

_oldUnit switchCamera "INTERNAL";
_dummyGroup = grpNull;
_becomingTerrorist = false;

if (side _oldUnit == civilian) then {
	_dummyGroup = createGroup EAST;
	_becomingTerrorist = true;
	diag_log "changeskin -> terrorist";
};

if (side _oldUnit == EAST) then {
	_dummyGroup = createGroup CIVILIAN;
	_becomingTerrorist = false;
	diag_log "changeskin -> civ";
};

if (side _oldUnit == WEST) then {
	_dummyGroup = createGroup WEST;
	_becomingTerrorist = false;
	diag_log "changeskin -> SWAT";
};

_newUnit = _dummyGroup createUnit [_type, _ar select 5, [], 0, "CAN_COLLIDE"];
_newUnit allowdammage false;
_newUnit setPos (_ar select 5);
_newUnit setDir (_ar select 8);
addSwitchableUnit _newUnit;
clearVehicleInit _oldUnit;
_oldUnit setVehicleVarName format["old_%1", _ar select 7];
_newUnit setVehicleInit format["this setVehicleVarName '%1'; %1 = this;", _ar select 7];
processInitCommands;
setPlayable _newUnit;
selectPlayer _newUnit;
removeSwitchableUnit _oldUnit;
removeSwitchableUnit _newUnit;
removeAllWeapons _newUnit;
{ _newUnit addMagazine _x } forEach (_ar select 1);
{ _newUnit addWeapon _x } forEach (_ar select 0);
if ((primaryWeapon _newUnit) != "") then { [_newUnit, primaryWeapon _newUnit] call _fSelectWeapon };
if (side _newUnit == east) then {
	_newUnit addBackpack "TK_RPG_Backpack_EP1";
	clearMagazineCargo (unitBackpack _newUnit);
} else {
	removeBackpack _newUnit;
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
[_oldUnit] joinsilent grpNull;
[_newUnit] joinsilent _dummyGroup;
_dummyGroup selectLeader _newUnit;
_oldUnit setpos getpos deadcamlogic;
_oldUnit removeAllEventHandlers "killed";
_oldUnit removeAllEventHandlers "respawn";
_oldUnit removeAllEventHandlers "fired";
_oldUnit removeAllEventHandlers "handleDamage";
_oldUnit hideobject true;
_oldUnit enablesimulation false;
_newUnit setRank _rank;
_newUnit addscore _score;
_newUnit setdamage _damage;
_newUnit setvariable["oldclass",_oldtype,false];
_newUnit setVariable["deadname",(_ar select 9),true];
_newUnit setvariable["loaded",true,true];
_newUnit setVariable["terrorist", _becomingTerrorist, true];
if (!isnil "_armor") then {_newUnit setvariable["bodyarmorhits",_armor,false];};
if (!isnil "_jail") then {_newUnit setvariable["releasetime",_jail,false];};
if (!isnil "_bombtime") then {_newUnit setvariable["bomb_ctime",_bombtime,false];};
_newUnit removeAllEventHandlers "killed";
_newUnit addEventHandler ["killed", {_this call onKilled;}];
_newUnit removeAllEventHandlers "respawn";
_newUnit addEventHandler ["respawn", {_this call onRespawn;}];
_newUnit removeAllEventHandlers "fired";
_newUnit addEventHandler ["fired", {_this call onFired;}];
_newUnit removeAllEventHandlers "handleDamage";
_newUnit addEventHandler ["handleDamage", {_this call onHandleDamage;}];
_newUnit allowdammage true;
{_newUnit reveal _x;} forEach (_newUnit nearObjects ["AllVehicles",100]);
{_newUnit reveal _x;} forEach (_newUnit nearObjects ["ReammoBox_EP1",50]);
