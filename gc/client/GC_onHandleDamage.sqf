onHandleDamage = {
	private ["_vehicle","_selection","_damage","_shooter","_ammo"];
	_vehicle   = _this select 0;
	_selection = _this select 1;
	_damage    = _this select 2;
	_shooter   = _this select 3;
	_ammo      = _this select 4;
	stun_damage = 0;
	if (player == _vehicle and alive player and _ammo != stunfxammo and !isnull _shooter) then {
		if((_ammo in stunammo) and (side _shooter == west)) then {
			_stun_handle = [_selection,_damage,_shooter,_ammo] spawn {
				private ["_timeout","_mag","_selection","_damage","_shooter","_ammo"];
				_selection = _this select 0;
				_damage = _this select 1;
				_shooter = _this select 2;
				_ammo = _this select 3;
				_timeout = 0;
				_mag = _shooter getvariable "firedmag";
				while {isnil "_mag"} do {
					_timeout = _timeout + 1;
					if (_timeout == 5) exitwith {stun_damage = 0;};
					sleep 0.35;
					_mag = _shooter getvariable "firedmag";
				};
				if (!isnil "_mag" and _mag in stunmags) then {
					[_shooter, _selection, _damage] spawn onStun;
					stun_damage = 0;
				} else {
					stun_damage = [_selection,_damage,_shooter,_ammo] call GC_dealDamage;
				};
			};
			while {!scriptDone _stun_handle} do {};
			_damage = stun_damage;
		} else {
			_damage = [_selection,_damage,_shooter,_ammo] call GC_dealDamage;
		};
	} else {
		_damage = 0;
	};
	if (_damage > 0) then {
		[_vehicle,_selection,_damage] spawn GC_Blood;
	};
_damage;
};