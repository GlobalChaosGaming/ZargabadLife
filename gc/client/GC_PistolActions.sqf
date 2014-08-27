_weaponsArray = _this;
_numWeapon = count _weaponsArray;
_prevention = true;
for [{_p = 0},{_p < _numWeapon},{_p = _p + 1}] do {
	_gun = (_weaponsArray select _p);
	if ([_gun] call isPistol) exitWith {
		_prevention = false;
		if ((_gun != saveWeaponPistol select 0) && saveWeaponPistol select 1) then {
			_prevention = true;
			saveWeaponPistol set [1,false];
		};
		saveWeaponPistol set [0,_gun];
	};
};
if (_prevention && !(saveWeaponPistol select 1)) then {
	saveWeaponPistol set [2,true];
	player removeAction holsterPistol;
	player removeAction unholsterPistol;
} else {
	if (saveWeaponPistol select 2) then {
		holsterPistol = player addAction ["Holster Pistol","pistolControl.sqf",[true]];
		saveWeaponPistol set [2,false];
	};
};