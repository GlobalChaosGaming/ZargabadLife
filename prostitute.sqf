_art  = ((_this select 3) select 0);
_cash = 'cash' call INV_GetItemAmount;

if (_art == "prostitute") exitWith

{

if (localprostitute >= maxprostitute) exitWith {role groupChat localize "STRS_prostitute_zuviele"};

if (_cash < prostitute_cost) exitWith {role groupChat localize "STRS_prostitute_nomoney"};

if (gangmember) exitWith {player groupChat "You cannot buy prostitutes while in a gang!"};

if (doingSomething) exitWith {};

doingSomething = true;

['cash', -(prostitute_cost)] call INV_AddInventoreItem;

player groupChat "Take your prostitute to a workplace to earn money.";

_arbeiternummer   = localprostitutecounter;
localprostitutecounter = localprostitutecounter + 1;
localprostitute        = localprostitute + 1;
_prostitutenumber      = localprostitutecounter;
_prostitutename        = player;
_civ 		  = civprostitutearray select round random(count civprostitutearray - 1);

doingSomething = false;

call compile format ['_prostitutename = "%3" createUnit [position player, group player, "%1prostitute%2 = this; this setvariable[""pimp"",""%4"",true]; this setVehicleVarName ""%1prostitute%2"";"]; _prostitutename = %1prostitute%2;_prostitutename setpos getpos player', rolestring, _prostitutenumber, _civ, (name player)];

(format ["publicarbeiterarctionarray = publicarbeiterarctionarray + [ [%1prostitute%2, %3] ];", rolestring, _prostitutenumber, player]) call broadcast_srv;

processInitCommands;

call compile format ["arbeitercash%1 = 0;", _arbeiternummer];
_prostitutemoney = 0;
_exitvar = 0;
_a1 = 0;
_action = 0;

while {true} do

	{

	if (_exitvar == 1) exitWith {};

		{

		if ((player distance (_x select 0)) < (_x select 1)) then {call compile format ["arbeitercash%1 = arbeitercash%1 + prostitutemoneyprosekunde + round(random 1000 - 500);", _arbeiternummer];};

		} forEach prostitutearray;

	for [{_i=0}, {_i < 60}, {_i=_i+1}] do

		{

		if ( (not(alive _prostitutename)) or (not(alive player)))  exitWith {sleep 2; if(!isnull _prostitutename)then{player groupChat localize "STRS_prostitute_tot"}else{player groupChat "A prostitute you owned has been set free. You're now wanted!"}; localprostitute = localprostitute - 1; _prostitutename SETDAMAGE 1; _exitvar = 1;};

		if ((player distance _prostitutename >= 5 or (call compile format ["arbeitercash%1 == 0", _arbeiternummer])) and _a1 == 1) then {player removeaction _action; _a1 = 0;};

		if (player distance _prostitutename < 5 and _a1 == 0 and (call compile format ["arbeitercash%1 > 0", _arbeiternummer])) then {_action = player addaction [localize "STRS_prostitute_moneyaction", "prostitute.sqf",["cash", _arbeiternummer]]; _a1 = 1;};

		if ((rolecop == 0) and ((vehicle _prostitutename) DISTANCE copbase1 <= 250) and (alive _prostitutename)) then

			{

			player groupChat localize "STRS_arbeiter_in_copbase";
			if (not((vehicle _prostitutename) == _prostitutename)) then {_prostitutename action ["eject", (vehicle _prostitutename)];};
			_prostitutename setpos getmarkerpos "civarea";

			};

		sleep 1;

		};

	};

player removeaction _action;
sleep 15;
deletevehicle _prostitutename;

};

if (_art == "cash") exitWith
{

	_arbeiternummer = (_this select 3) select 1;
	_arbeitercash   = call compile format ["arbeitercash%1;", _arbeiternummer];


	if ((_arbeitercash > 0) and !doingSomething) then
	{

		doingSomething = true;
		_addskill = (_arbeitercash / 225000);
		["SKILL_PROSTITUTION",_addskill] call GC_addSkill;
		_arbeitercash = floor(_arbeitercash + floor(SKILL_PROSTITUTION * 250));
		['cash',_arbeitercash] call INV_AddInventoreItem;
		call compile format ["arbeitercash%1 = 0;", _arbeiternummer];
		player groupChat format [localize "STRS_prostitute_cashabnahme_ja", (_arbeitercash call ISSE_str_IntToStr)];
		doingSomething = false;
	}

//else

//	{

//		player groupChat localize "STRS_prostitute_cashabnahme_nein";

//	};

};

