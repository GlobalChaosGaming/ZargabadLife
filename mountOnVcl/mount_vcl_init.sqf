// mount_vcl_init.sqf
// © JUNE 2009 - norrin (norrin@iinet.net.au)
/*
	Name playable units and vehicle in the editor
	Put this in the init line of the vehicle in the editor: nul = [this] execVM "mountOnVcl\mount_vcl_init.sqf";
*/
//modified by DOA for GC Chaos Life 2013 <imagotrigger@gmail.com>
_vcl 		= _this select 0;
_c 		= _this select 1;
_typeOfVcl	= ["Motorcycle","Bicycle","ATV_Base_EP1"];
_exitarray = [
	"datsun1_civil_3_open",
	"datsun1_civil_1_open",
	"hilux1_civil_1_open",
	"hilux1_civil_3_open_EP1",
	"KamazOpen",
	"V3S_Open_TK_CIV_EP1"
];
if (!((typeof _vcl) in _exitarray)) exitWith {};
_toAttach 	= objNull;
if (isServer and _c == 0) exitWith {_vcl setVariable ["mount", [false, _toAttach], true];};

_load = _vcl addAction ["<t color=""#ED2744"">Load into truck</t>", "mountOnVcl\mount_vcl.sqf", _typeOfVcl, 0, false, true];
_unload = _vcl addAction ["<t color=""#ED2744"">Unload truck</t>", "mountOnVcl\dismount_vcl.sqf","", 0, false, true];

_vcl removeAction _load;
_vcl removeAction _unload;


while {alive _vcl} do
{ 
	if (!((_vcl getVariable "mount") select 0) && _c == 0 && count (nearestObjects [_vcl, ["man"], 10]) > 0 && count (nearestObjects [_vcl, _typeOfVcl, 10]) > 0) then
	{	
		_load = _vcl addAction ["<t color=""#ED2744"">Load into truck</t>", "mountOnVcl\mount_vcl.sqf", _typeOfVcl, 0, false, true];
		_vcl removeAction _unload;
		_c = 1;
	};
		
	if (((_vcl getVariable "mount") select 0) && _c == 1) then
	{	
		_unload = _vcl addAction ["<t color=""#ED2744"">Unload truck</t>", "mountOnVcl\dismount_vcl.sqf","", 0, false, true];
		_vcl removeAction _load;
		_c = 0;
	};
	if (count (nearestObjects [_vcl, ["man"], 10]) == 0 || count (nearestObjects [_vcl, _typeOfVcl, 10]) == 0) then
	{
		_vcl removeAction _load;
		_vcl removeAction _unload;
		if (!((_vcl getVariable "mount") select 0)) then {_c = 0};
		if ((_vcl getVariable "mount") select 0) then {_c = 1};
	};	
	//hint format ["%1", (_vcl getVariable "mount")];
	sleep 2;
};
if (!alive _vcl) exitWith {};



