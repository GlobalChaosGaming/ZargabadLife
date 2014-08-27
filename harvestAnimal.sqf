if doingSomething exitwith {};
doingSomething = true;
_animal = _this select 3;
_r = floor(random 2);
_item = "";
_no = 0;

switch _animal do
{
	case "boar":
	{
		switch _r do
		{
			case 0: {
				_item = "boar";
				_no = ceil(random 2);
			};
			case 1: {
				_item = "boarpelt";
				_no = 1;
			};
		};
		if (((call INV_GetOwnWeight) + (_item call INV_getitemTypeKg)*_no) > INV_Tragfaehigkeit) exitwith
		{
			player groupChat localize "STRS_inv_buyitems_maxgewicht"
		};
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		(nearestObjects [getpos player, ["wildboar"],  3] select 0) setVariable ["inuse", 1, true];
 		call compile format['SFXPvEh_%1 = ["%2","harvestsfx"];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];			
		vehicle player say ["harvestsfx",100];
		
		sleep 3;
		waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
		deleteVehicle (nearestObjects [getpos player, ["wildboar"],  3] select 0);
		[_item, _no] call INV_AddInventoreItem;
		_addskill = (_no / 100);
		["SKILL_HUNTING",_addskill] call GC_addSkill;
		player groupChat format["you got %1 %2", _no, (_item call INV_getItemName)];
	};
	case "cow":
	{
		switch _r do
		{
			case 0: {
				_item = "cow";
				_no = ceil(random 2);
			};
			case 1: {
				_item = "cowleather";
				_no = 1
			};
		};
		if (((call INV_GetOwnWeight) + (_item call INV_getitemTypeKg)*_no) > INV_Tragfaehigkeit) exitwith
		{
			player groupChat localize "STRS_inv_buyitems_maxgewicht"
		};
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		(nearestObjects [getpos player, ["Cow01"],  3] select 0) setVariable ["inuse", 1, true];
 		call compile format['SFXPvEh_%1 = ["%2","harvestsfx"];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];					
		vehicle player say ["harvestsfx",100];
		sleep 3;
		waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
		deleteVehicle (nearestObjects [getpos player, ["Cow01"],  3] select 0);
		[_item, _no] call INV_AddInventoreItem;
		_addskill = (_no / 100);
		["SKILL_HUNTING",_addskill] call GC_addSkill;
		player groupChat format["you got %1 %2", _no, (_item call INV_getItemName)];
	};
};

doingSomething = false;