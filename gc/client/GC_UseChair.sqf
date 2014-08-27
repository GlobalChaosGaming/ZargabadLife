private ["_opt","_item","_chair","_model","_brug","_carpet","_rotate","_chairname"];
_opt  = _this select 0;
_item = _this select 1;

if (count _this > 2) then {
	if (TypeName (_this select 3) == "ARRAY") then {
		if (count (_this select 3) > 1) then {
			_opt = (_this select 3 select 0);
			_item = (_this select 3 select 1);
			_chairname = (_this select 3 select 2);
		};
	};
};

if (_opt == "use") then {
	_model = "Land_Chair_EP1";
	_brug = false;
	_carpet = objnull;
	_rotate = 90;
	switch (_item) do {
		 case "chair":  {
		 	_model = "Land_Chair_EP1";
		 	_rotate = 90;
		 };
		 case "chair_rug":  {
		 	_model = "Land_Chair_EP1";
		 	_brug = true;
		 	_rotate = 90;
		 };	
		 case "bench":  {
		 	_model = "Land_Bench_EP1";
		 	_rotate = 90;
		 };
		 case "bench_rug":  {
		 	_model = "Land_Bench_EP1";
		 	_brug = true;
		 	_rotate = 90;
		 };
		 case "wood_chair":  {
		 	_model = "WoodChair";
		 	_rotate = 180;
		 };
		 case "wood_chair_rug":  {
		 	_model = "WoodChair";
		 	_brug = true;
		 	_rotate = 180;
		 };		 
	};
	if(vehicle player != player)exitwith{player groupchat "You cannot use this in a vehicle!"};
	if (player distance getMarkerPos "jailarea" <= 30) exitWith { hint "You cannot take out your chair while in jail."; };
	_weapons = weapons player;
	_weparray = _weapons - nonlethalweapons;
	_allpistol = true;
	{
		if ([_x] call isPistol) then {
			_allpistol = true;
		} else {
			_allpistol = false;
		};
	} foreach _weparray;
	
	if (!_allpistol) exitWith {player GroupChat "Drop the large weapon in order to take out your chair!";};
	if (count _weparray > 0 and _allpistol) then {
		if (('pistole' call INV_GetItemAmount) <= 0) then {
			player removeaction unholsterPistol;
			_pc_handle = [false,false,false,[true]] execVM "pistolControl.sqf";
			waituntil{sleep 0.1; scriptDone _pc_handle};
			player removeaction unholsterPistol;
		};
	};
	if (_brug) then {
		_carpet = "Land_Carpet_EP1" createVehicle getPosATL player;
	};	
	_chair = _model createVehicle getPosATL player;
	_chair setPosATL (getPosATL player);
	_chair setDir (getDir player);
	if (_brug) then {
		_carpet setPosATL (getPosATL _chair);
		_carpet setDir (getDir _chair);	
	};
	player setDir ((getDir _chair) + 90);
	(format ["%1 switchmove ""%2"";", player, "shaftoe_c0briefing_odpovedel_loop"]) call broadcast;
	_chair setDir ((getDir _chair) - _rotate);
	player setDir ((getDir player) - 90);	
	[_chair,_carpet] spawn {
		_chair = _this select 0;
		_carpet = _this select 1;
		while {true} do {
			if (player distance _chair > 1) exitWith {
				(format ["%1 switchmove ""%2"";", player, ""]) call broadcast;
				player removeAction chairaction;
				deletevehicle _chair;
				deletevehicle _carpet;
				chairaction = -1;
			};
			sleep 0.5;
			player removeaction unholsterPistol;
		};
	};
	chairaction = player addAction ["Get up","gc\client\GC_UseChair.sqf",["GetUp",_model,_item]];
	player GroupChat "You are now sitting in your chair!";
	[_item, (-1)] call INV_AddInventoreItem;
};

if (_opt == "GetUp") then {
	if (('pistole' call INV_GetItemAmount) > 0) then {
		player removeaction unholsterPistol;
		unholsterPistol = player addAction ["Unholster Pistol","pistolControl.sqf",[false]];
	};
	player removeAction chairaction;
	chairaction = -1;
	_chair = getPosATL player nearestObject _item;
	_carpet = getPosATL player nearestObject "Land_Carpet_EP1";
	(format ["%1 switchmove ""%2"";", player, ""]) call broadcast;
	deletevehicle _chair;
	deletevehicle _carpet;
	player GroupChat "You have put your chair away!";
	[_chairname, (+1)] call INV_AddInventoreItem;
};
