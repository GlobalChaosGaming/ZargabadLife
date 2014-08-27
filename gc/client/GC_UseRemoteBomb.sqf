private ["_item","_art","_ctime","_bomb","_exp","_exp2","_posx","_posy","_posz","_obj","_rocket","_rocket2"];
_art = _this select 0;
_item   = _this select 1;
if (_art == "use") then {
	if (_item == "remote_bomb") then {
		if (bombplanted) exitWith {
			player groupChat "You can only plant one bomb at a time!";
		};		
		if (player != vehicle player) exitWith {
			player groupChat "You can't use this in a vehicle!";
		};																						   
		if (call GC_PlayerInCrimeFree) exitWith {
			player groupChat "You can't plant a bomb inside the No Crime Zone!";
		};
		_ctime = round(time);
		format ["%1 switchmove ""AinvPknlMstpSlayWrflDnon_medic"";", player] call broadcast;
		sleep 4;
		waituntil {sleep 0.1; animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};
		_bomb = "SatPhone" createVehicle getPosATL player;
		_exp = "Explosive" createVehicle getPosATL player;
		_exp2 = "Explosive" createVehicle getPosATL player;
		call compile format ['_bomb setvehicleinit "bomb_%1_%2 = this;this setVehicleVarName ""bomb_%1_%2"";"',player,_ctime];
		processInitCommands;
		_exp attachto [_bomb,[-0.02,-0.09,-0.1]];
		_exp2 attachto [_bomb,[-0.02,-0.001,-0.1]];
		_bomb setposATL getposATL player;
		[_item, (-1)] call INV_AddInventoreItem;
		["remote_bomb_detonator", (+1)] call INV_AddInventoreItem;
		player setvariable["bomb_ctime",_ctime,false];
		player GroupChat "You have planted a remote time bomb.";
		player GroupChat "Use your detonator to make it explode!";
		bombplanted = true;
		_class	 = _item call INV_getitemClassName;
		(format ["publicarbeiterarctionarray = publicarbeiterarctionarray + [ [%1%2%3, %1] ];", player, _class, _ctime]) call broadcast_srv;
		if (([player, (civarray + coparray), 40] call INV_Seen) and !iscop) then {
			format [" [""Bomb"", %1] spawn Isse_AddCrimeLogEntry; if(!(""planted a bomb"" in %1_reason))then{%1_reason = %1_reason + [""planted a bomb""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 10000;", player] call broadcast;
		};		
	};
	if (_item == "remote_bomb_detonator") then {
		_ctime = player getvariable "bomb_ctime";
		_bomb = "";
		call compile format["_bomb = bomb_%1_%2;",player,_ctime];
		if (!alive _bomb) exitWith {
			player GroupChat "Your remote time bomb no longer exists.";
			[_item, (-1)] call INV_AddInventoreItem;
			bombplanted = false;
		};
		if (vehicle player distance _bomb > 300) exitWith {
			player GroupChat "Your remote time bomb is too far away.";
		};		
		[_bomb,10,false] execVM "ammo_burn.sqf";
		call compile format['SFXPvEh_%1 = ["%2","bombbeepsfx"];',rolenumber,_bomb];
		publicVariable format["SFXPvEh_%1", rolenumber];          
		_bomb say ["bombbeepsfx",100];
		call compile format['SFXPvEh_%1 = ["%2","bombscreamsfx"];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];          
		vehicle player say ["bombscreamsfx",100];
		sleep 6;
		_posx = getPosATL _bomb select 0;
		_posy = getPosATL _bomb select 1;
		_posz = getPosATL _bomb select 2;
		_obj = nearestObject[_bomb,"Explosive"];
		deletevehicle _obj;
		_obj2 = nearestObject[_bomb,"Explosive"];
		deletevehicle _obj2;
		"Grenade" createvehicle (getPos _obj);		
		sleep 0.25;
		_rocket = "R_57mm_HE" createvehicle [_posx,_posy,_posz+1];
		[_rocket, -90, 0] call setPitchBank;
		_rocket2 = "R_80mm_HE" createvehicle [_posx,_posy,_posz+1];
		[_rocket2, -90, 0] call setPitchBank;		
		{
			_x setdammage 1;
		} foreach (_bomb nearObjects["Man", 10]);
		_bomb setdammage 1;
		sleep 2;	
		deletevehicle _bomb;
		[_item, (-1)] call INV_AddInventoreItem;
		bombplanted = false;
		if (([player, (civarray + coparray), 40] call INV_Seen) and !iscop) then {
			format [" [""Bomb"", %1] spawn Isse_AddCrimeLogEntry; if(!(""detonated a bomb"" in %1_reason))then{%1_reason = %1_reason + [""detonated a bomb""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 50000;", player] call broadcast;
		};		
	};
};
