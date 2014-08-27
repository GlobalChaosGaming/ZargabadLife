//if (SunOrMoon != 0) exitWith {player groupchat "Wait until it's dark out to set off fireworks!";};
if (player != vehicle player) exitWith {player groupChat "You can't use this in a vehicle!";};
if (call GC_PlayerInCrimeFree) exitWith {player groupChat "You can't set off fireworks inside the No Crime Zone!";};
if (count(nearestObjects[player,["House"],15]) != 0) exitWith {player groupChat "You are too close to a building!";};
if (count(nearestObjects[player,["car", "air"],10]) != 0) exitWith {player groupChat "You are too close to a vehicle!";};
if (iscop and call GC_PlayerInCopBase) exitWith {player groupChat "You can't set off fireworks inside the Cop Base!";};
_spam = player getvariable "fireworks";
if (!isnil "_spam") exitWith {player groupChat "You can only set off one at a time!";};
player setvariable["fireworks",true,false];
["fireworks", (-1)] call INV_AddInventoreItem;
format ["%1 switchmove ""AinvPknlMstpSlayWrflDnon_medic"";", player] call broadcast;
sleep 3;
_table = "SmallTable" createvehicle getpos player;
call compile format ['_table setvehicleinit "fireworks_%1_%2 = this;this setVehicleVarName ""fireworks_%1_%2"";"',player,round(time)];
processInitCommands;
_b1 = "Bomb" createvehicle getpos player;
_b2 = "Bomb" createvehicle getpos player;
_b3 = "Bomb" createvehicle getpos player;
_b4 = "Bomb" createvehicle getpos player;
_b5 = "Bomb" createvehicle getpos player;
_b1 attachto [_table,[0.1,0,0.41]];
_b2 attachto [_table,[-0.1,0,0.41]];
_b3 attachto [_table,[0,0,0.41]];
_b4 attachto [_table,[0,0.1,0.41]];
_b5 attachto [_table,[0,-0.1,0.41]];
[_b1, -90, 0] call setPitchBank;
[_b2, -90, 0] call setPitchBank;
[_b3, -90, 0] call setPitchBank;
[_b4, -90, 0] call setPitchBank;
[_b5, -90, 0] call setPitchBank;
_table setPos [(getPos player select 0) + (1 * sin (getdir player)), (getPos player select 1) + (1 * cos (getdir player)), (getPos player select 2)];
_table setdir (getdir player);
sleep 0.2;
_table enableSimulation false;
waituntil {sleep 0.1; animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};
call compile format['SFXPvEh_%1 = ["%2","fireworklightsfx"];',rolenumber,_table];
publicVariable format["SFXPvEh_%1", rolenumber];
_table say ["fireworklightsfx",100];
player groupchat "You lit the fuze, better stand back!";
sleep 8.6;
popoffpos = [0,0,0];
{
	[_x,_table] spawn {
		_model = _this select 0;
		_table = _this select 1;
		_posx = getPosATL _model select 0;
		_posy = getPosATL _model select 1;
		_posz = getPosATL _model select 2;
		deletevehicle _model select 0;
		call compile format['SFXPvEh_%1 = ["%2","fireworklaunchsfx"];',rolenumber,_table];
		publicVariable format["SFXPvEh_%1", rolenumber];
		_table say ["fireworklaunchsfx",100];
		_rocket = "M_47_AT_EP1" createvehicle [_posx,_posy,_posz+0.8];
		[_rocket, 90, 0] call setPitchBank;
		_waitforme = _rocket spawn {
			_slow = 0;
			_random = random 20 - random 20;
			_random2 = random 5 - random 5;
			_random3 = random 5 - random 5;
			while{alive _this and _slow < 200} do {
				_this setVelocity[_random2,_random3,12];
				sleep 0.01;
				_slow = _slow + 1;
			};
			_pos = getpos _this;
			deletevehicle _this;
			_rocket = "M_NLAW_AT" createvehicle _pos;
			_rocket setpos _pos;
			[_rocket, 90, 0] call setPitchBank;

			while{alive _rocket} do {
				_rocket setVelocity[_random,_random,100];
				popoffpos = getpos _rocket;
				sleep 0.01;
			};
			waituntil{sleep 0.1; !alive _rocket};
		};
		waituntil {sleep 0.1; scriptDone _waitforme};
		_boom2="HelicopterExploBig" createVehicle popoffpos;
		sleep 0.5;
		for "_c" from -10 to 10 do {
			_sparkles = "CMflare_Chaff_Ammo" createvehicle popoffpos;
			_flare = objnull;
			if (_c %10 == 0) then {_flare = "F_40mm_Yellow" createvehicle (getpos _sparkles);};
			_waitforme = [_sparkles,_c, _flare] spawn {
				_sparkles = _this select 0;
				_c = _this select 1;
				_flare = _this select 2;
				_slow = 0;
				_pos = getposATL _sparkles;
				while{alive _sparkles} do {
					if (_slow > 15) then {
						_sparkles setVelocity[random 25,_c,-1];
						_flare setVelocity[random 25 * 1,_c,-1];
						_sparkles setdammage 1;
					} else {
						_sparkles setVelocity[random 25 * 2,_c,-25];
						_flare setVelocity[random 40 * 2,_c,-25];
					};
					sleep 0.01;
					_slow = _slow + 1;
					_pos = getposATL _sparkles;
				};
				_flare spawn {sleep 5; deletevehicle _this;};
				if (_c %3 == 0) then {_sparkles spawn{sleep random 4; "SmallSecondary" createvehicle (getpos _this);};};
			};
		};
		for "_c" from -30 to -11 do {
			_sparkles = "CMflare_Chaff_Ammo" createvehicle popoffpos;
			_flare = objnull;
			if (_c %10 == 0) then {_flare = "F_40mm_Red" createvehicle (getpos _sparkles);};
			_waitforme = [_sparkles,_c,_flare] spawn {
				_flare = _this select 2;
				_sparkles = _this select 0;
				_c = _this select 1;
				_slow = 0;
				while{alive _sparkles} do {
					if (_slow > 20) then {
						_sparkles setVelocity[random 25 * -1,_c,-1];
						_flare setVelocity[random 25 * -1,_c,-1];
						_sparkles setdammage 1;
					} else {
						_sparkles setVelocity[random 25 * -2,_c,-25];
						_flare setVelocity[random 40 * -2,_c,-25];
					};
					sleep 0.01;
					_slow = _slow + 1;
				};
				_flare spawn {sleep 5; deletevehicle _this;};
				if (_c %3 == 0) then {_sparkles spawn{sleep random 4; "SmallSecondary" createvehicle (getpos _this);};};
			};
		};
		for "_c" from 11 to 30 do {
			_sparkles = "CMflare_Chaff_Ammo" createvehicle popoffpos;
			_flare = objnull;
			if (_c %10 == 0) then {_flare = "F_40mm_Green" createvehicle (getpos _sparkles);};
			_waitforme = [_sparkles,_c,_flare] spawn {
				_flare = _this select 2;
				_sparkles = _this select 0;
				_c = _this select 1;
				_slow = 0;
				while{alive _sparkles} do {
					if (_slow > 25) then {
						_sparkles setVelocity[random 25 * -1,_c,-1];
						_flare setVelocity[random 25 * -1,_c,-1];
						_sparkles setdammage 1;

					} else {
						_sparkles setVelocity[random 25 * -2,_c,-25];
						_flare setVelocity[random 40 * -2,_c,-25];
					};
					sleep 0.01;
					_slow = _slow + 1;
				};
				_flare spawn {sleep 5; deletevehicle _this;};
				if (_c %3 == 0) then {_sparkles spawn{sleep random 4; "SmallSecondary" createvehicle (getpos _this);};};
			};
		};
	};
	sleep 2.1;
} foreach [_b1,_b2,_b3,_b4,_b5];
sleep 1;
deletevehicle _table;
player setvariable["fireworks",nil,false];
