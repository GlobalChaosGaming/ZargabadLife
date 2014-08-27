_this    = _this select 3;
_number  = _this select 0;
_art     = _this select 1;

if ((_art == "remove") or (_art == "add")) then

{

if (_art == "add") then

	{
	_license = ((INV_Lizenzen select _number) select 0);
	_name    = ((INV_Lizenzen select _number) select 2);
	_cost    = ((INV_Lizenzen select _number) select 3);
	if (_license call INV_HasLicense) exitWith {player groupChat localize "STRS_inv_buylicense_alreadytrue";};
	if (('cash' call INV_GetItemAmount) < _cost) exitWith {player groupChat localize "STRS_inv_buylicense_nomoney";};
	if(_license == "car" or _license == "truck")then{demerits = 10};
	if (_license == "bomb" and gangmember) exitWith {player groupChat "You can't sign a terror pact while in a gang!";};
	if (_license == "bomb" and last_terror_time > 0 and (time - last_terror_time) < 1800) exitWith {player groupChat "You can't sign another terror pact so soon, try again later!";};
	if (_license == "bomb") then {
		_prostitutes = false;
  		{if (!isPlayer _x) then {_x setDamage 1; _prostitutes = true;};} forEach units group player;
  		if (_prostitutes) then {player groupChat "You can't have prostitutes as a terrorist! Your prostitutes have been killed."};
		"TK_INS_Soldier_AAT_EP1" call GC_ChangeSkin;
		call compile preprocessFileLineNumbers "briefing.sqf"
		call addActions;
		format [" [""Terror"", %1] spawn Isse_AddCrimeLogEntry; if(!(""known terrorist"" in %1_reason))then{%1_reason = %1_reason + [""known terrorist""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 50000;server globalChat ""%2 IS NOW A TERRORIST, THEY MAY BE KILLED ON SIGHT!"";", player, name player] call broadcast;
	};
	if (_license == "swat_training") then {
		"US_Delta_Force_EP1" call GC_ChangeSkin;
		call compile preprocessFileLineNumbers "briefing.sqf"
		call addActions;
	};
	['cash', -(_cost)] call INV_AddInventoreItem;
	player groupChat format[localize "STRS_inv_buylicense_gottraining", (_cost call ISSE_str_IntToStr), _name];

	//if(_license == "terrorist")exitwith{[terroristarray select round random(count terroristarray - 1)] execVM "changeclass.sqf";};
	//if(_license == "swat_training")exitwith{["MVD_soldier"] execVM "changeclass.sqf";};

	INV_LizenzOwner = INV_LizenzOwner + [_license];
	["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;
	}
	else
	{

	_license = ((INV_Lizenzen select _number) select 0);
	name    = ((INV_Lizenzen select _number) select 2);
	if (not(_license call INV_HasLicense)) exitWith {player groupChat localize "STRS_inv_buylicense_alreadyfalse";};
	INV_LizenzOwner = INV_LizenzOwner - [_license];
	player groupChat format[localize "STRS_inv_buylicense_losttraining", _name];
	["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;

	};

};
