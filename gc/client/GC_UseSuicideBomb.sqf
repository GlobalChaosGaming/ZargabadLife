_art = _this select 0;
_item   = _this select 1;
if (_art == "use") then {
	_exp0 = "Explosive" createVehicle getPos player;
	_exp0 attachto [player,[-0.17,0.13,1.2]];
	[_exp0, 0, 90] call setPitchBank;

	_exp3 = "Explosive" createVehicle getPos player;
	_exp3 attachto [player,[0,0.18,1.2]];
	[_exp3, 0, 90] call setPitchBank;

	_exp5 = "Explosive" createVehicle getPos player;
	_exp5 attachto [player,[0.17,0.13,1.2]];
	[_exp5, 0, 90] call setPitchBank;

	_exp6 = "Explosive" createVehicle getPos player;
	_exp6 attachto [player,[0.11,0.15,1.2]];
	[_exp6, 0, 90] call setPitchBank;

	_exp7 = "Explosive" createVehicle getPos player;
	_exp7 attachto [player,[0.05,0.17,1.2]];
	[_exp7, 0, 90] call setPitchBank;

	_exp8 = "Explosive" createVehicle getPos player;
	_exp8 attachto [player,[-0.01,0.17,1.2]];
	[_exp8, 0, 90] call setPitchBank;

	_exp9 = "Explosive" createVehicle getPos player;
	_exp9 attachto [player,[-0.06,0.17,1.2]];
	[_exp9, 0, 90] call setPitchBank;

	_exp10 = "Explosive" createVehicle getPos player;
	_exp10 attachto [player,[-0.12,0.15,1.2]];
	[_exp10, 0, 90] call setPitchBank;
	
	[_item, (-1)] call INV_AddInventoreItem;
	if (([player, (civarray + coparray), 40] call INV_Seen) and !iscop) then {
		format [" [""Bomb"", %1] spawn Isse_AddCrimeLogEntry; if(!(""used a bomb"" in %1_reason))then{%1_reason = %1_reason + [""used a bomb""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 50000;", player] call broadcast;
	};	
	[player,5,false] execVM "ammo_burn.sqf";
	call compile format['SFXPvEh_%1 = ["%2","bombscreamsfx"];',rolenumber,rolestring];
	publicVariable format["SFXPvEh_%1", rolenumber];          
	vehicle player say ["bombscreamsfx",100];
	sleep 6;
	_posx = getPosATL player select 0;
	_posy = getPosATL player select 1;
	_posz = getPosATL player select 2;
	{ deletevehicle _x; } foreach (player nearObjects ["Explosive",5]);
	"Grenade" createvehicle (getPos player);
	sleep 0.25;
	_rocket = "R_57mm_HE" createvehicle [_posx,_posy,_posz+1];
	[_rocket, -90, 0] call setPitchBank;
	_rocket2 = "R_80mm_HE" createvehicle [_posx,_posy,_posz+1];
	[_rocket2, -90, 0] call setPitchBank;		
	{
		_x setdammage 1;
	} foreach (_bomb nearObjects["Man", 10]);	
	player setdammage 1;
};
