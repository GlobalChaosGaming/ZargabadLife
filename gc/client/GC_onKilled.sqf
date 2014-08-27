private ["_i","_object","_item","_amount","_gangFlagUser"];
_killed = player getvariable "killed";
if (!isnil "_killed") exitWith{};
player setvariable["killed",1,false];
if ("bomb" in INV_LizenzOwner) then {
	INV_LizenzOwner = INV_LizenzOwner - ["bomb"];
	["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;
	last_terror_time = time;
};
closeDialog 0;
weaponsloaded = false;
INV_hunger = 25;
deadtimes  = deadtimes + 1;
["deadtimes", deadtimes] call ClientSaveVar;
if (isciv) then {	
	for [{_i=0}, {_i < (count INV)}, {_i=_i+1}] do {
		_item   = ((INV select _i) select 0);
		_amount = (_item call INV_GetItemAmount);
		if (_amount > 0 and (_item call INV_getitemDropable)) then {
			private "_class";
			if(_item == "cash")then{_class = "EvMoney"}else{_class = "Suitcase"};
			_object = _class createvehicle position player;
			_object setvariable ["droparray", [_amount, _item], true];

		};
	};
	call INV_InventarLeeren;

	if(isdead == 0)then {
		[] spawn {
			[player, "suicide",""] call GC_Victim;
			["isdead", isdead] call ClientSaveVar;
		};
	};

	shoveldur=20;
	pickaxedur=50;
	hammerdur=100;
	alreadygotaworkplacejob=0;
	isterror=false;
	takingFlag = false;
	{
		_gangFlagUser = _x getVariable "mover";
		if (player == _gangFlagUser) then {
			_x setVariable["mover", nil, true];
		};
	} forEach gangAreas;
	
	if (gangleader) then {group player selectLeader player};

	DeadWaitSec = DeadWaitSec + respawntimeinc;
	if (DeadWaitSec > DeadTimeMax) then {DeadWaitSec = DeadTimeMax};
	["DeadWaitSec", DeadWaitSec] call ClientSaveVar;
	[] execVM "respawncamera.sqf";
};

if (iscop) then {
	if (name player in copraidarray) then {
		copraidarray = copraidarray - [name player];
		format['
			if (iscop and "%1" in copraidarray) then {
				copraidarray = copraidarray - ["%1"];
			};
		',name player] call broadcast;
		
		if (count copraidarray < 2) then {
			_last_checkpoint = player getvariable "last_checkpoint";
			raidarray = raidarray - [_last_checkpoint];
			format['
				if (iscop or isServer) then {raidarray = raidarray - ["%1"];};
			',_last_checkpoint] call broadcast;	
		};		
	};
	_amount = ("cash" call INV_GetItemAmount);
	if (_amount > 0) then {
		_object = "EvMoney" createvehicle position player;
		_object setvariable ["droparray", [_amount, "cash"], true];
		["cash", -(_amount)] call INV_AddInventoreItem;
	};
	if (DeadWaitSec > DeadTimeMax) then {DeadWaitSec = DeadTimeMax};
	["DeadWaitSec", DeadWaitSec] call ClientSaveVar;
	[] execVM "respawncamera.sqf";
};
