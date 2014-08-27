private ["_item","_art"];
_art = _this select 0;
if (_art == "use") then {
	_item   = _this select 1;
	if (player == vehicle player)  exitWith {
		player groupChat "You must arm this inside a vehicle!";
	};
	if ((damage vehicle player) >= 0.95) exitWith {
		player groupChat "This vehicle is already destroyed!";
	};																							   
	if (call GC_PlayerInCrimeFree) exitWith {
		player groupChat "You can't arm a bomb inside the No Crime Zone!";
	};
	_veh = vehicle player;
	[_item, (-1)] call INV_AddInventoreItem;
	if (!(_veh isKindOf "bicycle")) then {[_veh,15,false] execVM "ammo_burn.sqf";};
	player groupchat "The bomb has been armed!! GET OUT QUICKLY BEFORE IT EXPLODES!";
	if (([player, (civarray + coparray), 40] call INV_Seen or _incarpark) and !iscop) then {
		format [" [""Bomb"", %1] spawn Isse_AddCrimeLogEntry; if(!(""used a bomb"" in %1_reason))then{%1_reason = %1_reason + [""used a bomb""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 50000;", player] call broadcast;
	};	
	call compile format['SFXPvEh_%1 = ["%2","bombbeepsfx"];',rolenumber,rolestring];
	publicVariable format["SFXPvEh_%1", rolenumber];          
	_veh say ["bombbeepsfx",100];	
	sleep 6;
	"SmallSecondary" createvehicle (getPos _veh);
	_veh setDamage 0.95;
	sleep 0.25;
	"SmallSecondary" createvehicle (getPos _veh);
	{
		if (getdammage _x < 0.75) then {
			_x setdamage 0.75;
		};
	} foreach crew _veh;
};