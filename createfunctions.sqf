INV_CreateGunboxLocal = {};

INV_DialogPlayers =

{

private ["_c", "_Fid", "_Fname", "_Fingame", "_Findex", "_Flistlen", "_Feigenenum"];
_Fid        = _this select 0;
_Fname      = _this select 1;
_Fingame    = _this select 2;
_Findex     = 0;
_Flistlen   = 0;
_Feigenenum = -1;

for [{_c=0}, {_c < (count INV_PLAYERSTRINGLIST)}, {_c=_c+1}] do

	{

	_Fspieler = INV_PLAYERSTRINGLIST select _c;
	_unit = (call compile _Fspieler);
	_Fpname = nil;
	if (!alive _unit) then {
		_Fpname = _unit getVariable "deadname";
	} else {
		_Fpname = name _unit;
	};
	
	if ( ((_Fingame) or (_Fspieler call ISSE_UnitExists)) ) then

		{

		if (_Fname and _Fpname != "ChaosBot") then

			{

			_Findex = lbAdd [_Fid, format ["%1 - (%2)", _Fspieler, _Fpname]];

			}
			else
			{

			_Findex = lbAdd [_Fid, _Fspieler];

			};

			lbSetData [_Fid, _Findex, format["%1", _c]];
			if (_Fspieler == INV_ROLESTRING) then {_Feigenenum = _Flistlen;};
			_Flistlen = _Flistlen + 1;

		};

	};

[_Flistlen, _Feigenenum]

};

INV_CreateVehicle = {
	private ["_classname", "_position","_dir"];
	_classname = _this select 0;
	_logic	   = _this select 1;

	_code = " ";
	_code2 = "";
	_ctime = round(time);
	if (_classname == "TT650_Civ" and (_logic == ccarspawn_0 or _logic == ccarspawn_1 or _logic == ccarspawn_2 or _logic == ccarspawn_3)) then {
		_code = format['vehicle_%1_%2 setObjectTexture [0, "images\copbike.jpg"];vehicle_%1_%2 setvariable ["customskin","images\copbike.jpg",true];',player, _ctime];
	};
	if (iscop) then {
		_code2 = format['vehicle_%1_%2 setvariable ["customhorn","airhornsfx",true];',player, _ctime];
	};
	call compile format ['
		newvehicle = _classname createVehicle %4;
		newvehicle addEventHandler ["GetIn", {_this call onGetIn;}];
		newvehicle setpos %4;
		newvehicle setdir %5;
		newvehicle setVariable["created",time,true];
		newvehicle setVehicleInit "
			[this,0] execVM ""mountOnVcl\mount_vcl_init.sqf"";
			this setVehicleVarName ""vehicle_%1_%2"";
			vehicle_%1_%2 = this;
			clearWeaponCargo this;
			clearMagazineCargo this;
			vehicle_%1_%2 removeWeapon ""FFARLauncher_14"";
			newvehicle lock true;
		";
		processInitCommands; 
		%6 
		%7
		INV_VehicleArray = INV_VehicleArray + [vehicle_%1_%2];
	', player, _ctime, INV_CALL_CREATVEHICLE, getpos _logic, getdir _logic, _code,_code2];
	format['INV_ServerVclArray = INV_ServerVclArray + [vehicle_%1_%2]; %3',player, _ctime,_code] call broadcast;
	call compile format['
		if (vehicle_%1_%2 iskindof "Air") then {
			vehicle_%1_%2 say "createairsfx";
			SFXPvEh_%3 = ["vehicle_%1_%2","createairsfx"];
			publicVariable "SFXPvEh_%3";
		} else {
			vehicle_%1_%2 say "createlandsfx";
			SFXPvEh_%3 = ["vehicle_%1_%2","createlandsfx"];
			publicVariable "SFXPvEh_%3";
		};
	',player, _ctime, rolenumber];	
	
};

INV_CreateWeapon =

{

private["_class", "_menge", "_crate"];
_class = _this select 0;
_menge = _this select 1;
_crate = _this select 2;
_crate setDamage 0;

_crate setvehicleinit format["
this addweaponCargo [""%1"",%2];
", _class, _menge];
processInitCommands;

};

INV_CreateMag =

{

private["_class", "_menge", "_crate"];
_class = _this select 0;
_menge = _this select 1;
_crate = _this select 2;
_crate setDamage 0;

_crate setvehicleinit format["
this addmagazineCargo [""%1"",%2];
", _class, _menge];
processInitCommands;

};

INV_CreateItem =

{

private["_class", "_menge", "_stor"];
_class = _this select 0;
_menge = _this select 1;
_stor  = _this select 2;
[_class, _menge, _stor] call INV_AddItemStorage;

};
