GC_dealDamage = {
	private ["_damage","_selection","_shooter","_ammo","_nearVehicles"];
	_nearVehicles = nearestObjects [vehicle player, ["LandVehicle","Air"], 15] - [vehicle player];
	_selection = _this select 0;
	_damage    = _this select 1;
	_shooter   = _this select 2;
	_ammo   = _this select 3;
	if (!(call GC_PlayerInCrimeFree)) then {
		if (!(iscop and (call GC_PlayerInCopBase))) then {				
			_damage = [_selection,_damage,_ammo] call GC_DamageModifier;
			player SetHit [_selection, _damage];
			if(_selection == "" and _damage >= 1 and !isnull _shooter)then{player setdamage 1};
			if(!alive player) then {[_shooter, _nearVehicles, _ammo] call GC_Victim;};
		} else {
			_damage = 0;
		};
	} else {
		_damage = 0;
	};
_damage;
};