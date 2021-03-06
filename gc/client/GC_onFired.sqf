private ["_firedmag","_shooter","_ammo","_mag","_bullet"];
_shooter = _this select 0;
_ammo   = _this select 4;
_mag   = _this select 5;
_bullet   = _this select 6;

if(call GC_PlayerInCopBase and iscop) exitwith { deletevehicle _bullet; };

if ((_ammo in teargas)) exitWith { _bullet spawn GC_Gasing; };
if ((_ammo in flashbangs)) exitWith { _bullet spawn GC_Flashing; };

if (iscop) then {
	_firedmag = _shooter getvariable "firedmag";
	if (!isnil "_firedmag") then {
		if (_firedmag != _mag) then {
			_shooter setvariable["firedmag",_mag,true];
		};
	} else {
		_shooter setvariable["firedmag",_mag,true];
	};
};

if (isciv or not(_mag in stunmags)) exitWith {};

_bullet spawn {
    private ["_bullet","_vel","_pos","_teiler","_newbullet"];
    sleep 0.01;
	_bullet = _this;
	_vel   = velocity _bullet;
	_pos   = getpos   _bullet;
	_teiler = 1;
	_newbullet = stunfxammo createVehicle _pos;
	_newbullet setVelocity [(_vel select 0)/_teiler, (_vel select 1)/_teiler, (_vel select 2)/_teiler];
  	sleep 2;
  	deletevehicle _newbullet;
};