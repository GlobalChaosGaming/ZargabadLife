//.da.dcthehole <dcthehole@gmail.com> for Chaos Life
_art = _this select 0;
_item = _this select 1;

if(_art == "Use") then {
	_allowedvcls = ["LandRover_TK_CIV_EP1","LandRover_CZ_EP1","BAF_Offroad_D","MTVR_DES_EP1","MTVR","V3S_TK_GUE_EP1"];
	_vcl  = vehicle player;
	if(player == _vcl) exitwith {player groupchat localize "STRS_inv_items_repair_refuel_notincar";};
	if(player != driver _vcl) exitwith {player groupchat localize "STRS_inv_items_repair_refuel_notdriver";};
	if ((!('bomb' call INV_HasLicense)) && !gangmember) exitwith {player groupchat "You need to be a terrorist or in a gang to do this!";};
	_vcltype = typeof _vcl;
	if(!(_vcltype in _allowedvcls)) exitwith {player groupchat format["You cannot install %1 on this vehicle!",_item];};
	[_item,-1] call INV_AddInventoreItem;
	call compile format['SFXPvEh_%1 = ["%2","tunesfx"];',rolenumber,rolestring];
	publicvariable format["SFXPvEh_%1", rolenumber];
	vehicle player say "tunesfx";
	switch (_vcltype) do {
		case "LandRover_TK_CIV_EP1": {_wep = "DSHkM_Mini_TriPod_TK_GUE_EP1" createvehicle (getpos _vcl);_wep attachto [_vcl,[0,-1.35,.25]];_wep setdir 180;};
		case "LandRover_CZ_EP1": {_wep = "DSHkM_Mini_TriPod_TK_GUE_EP1" createvehicle (getpos _vcl);_wep attachto [_vcl,[0,-1.35,.25]];_wep setdir 180;};
		case "BAF_Offroad_D": {_wep = "DSHkM_Mini_TriPod_TK_GUE_EP1" createvehicle (getpos _vcl);_wep attachto [_vcl,[0,-1.35,.25]];_wep setdir 180;};
		case "MTVR_DES_EP1": {_wep = "DSHkM_Mini_TriPod_TK_GUE_EP1" createvehicle (getpos _vcl);_wep attachto [_vcl,[0,-2.35,.6]];_wep setdir 180;};
		case "MTVR": {_wep = "DSHkM_Mini_TriPod_TK_GUE_EP1" createvehicle (getpos _vcl);_wep attachto [_vcl,[0,-2.35,.6]];_wep setdir 180;};
		case "V3S_TK_GUE_EP1": {_wep = "DSHkM_Mini_TriPod_TK_GUE_EP1" createvehicle (getpos _vcl);_wep attachto [_vcl,[0,-1.95,.3]];_wep setdir 180;};
	};
	_vcl setvariable ["carwep",1,true];
	player groupchat "Installation Finished!";
};