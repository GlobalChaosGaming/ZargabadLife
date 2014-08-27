//detect bug slot
{
	_npc = _x getvariable "NPC";
	if (not isnil "_npc") then {
		_slot = format["%1",_x];
		{
			if (_slot == _x) then {
				_unit = playerarray select _foreachindex;
				if (name player == name _unit) then {
					call GC_EndMission;
				};
			};
		}foreach playerstringarray;
	};
} foreach allUnits;

//ensure empty group
if (!gangmember) then {
	while {count units group player > 1} do {
		[player] joinsilent grpNull;
		sleep 0.5;
	};
};

//delete blown up aircraft
{
	if (!alive _x) then {
		if (_x isKindof "Air") then {
			deletevehicle _x;
		}
	};
} foreach vehicles;

//clear any existing backpacks in case of custom skin
removeBackpack player;

//keep terrorists wanted
if ("bomb" in INV_LizenzOwner) then {
	"TK_INS_Soldier_AAT_EP1" call GC_ChangeSkin;
	call compile preprocessFileLineNumbers "briefing.sqf"
	call addActions;
	format [" [""Terror"", %1] spawn Isse_AddCrimeLogEntry; if(!(""known terrorist"" in %1_reason))then{%1_reason = %1_reason + [""known terrorist""]; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 25000;}; ", player] call broadcast;
	player setVariable ["terrorist", true, true];
} else {
	player setVariable ["terrorist", false, true]; //durandal did this
};

//keep SWAT licensees skinned
if ("swat_training" in INV_LizenzOwner) then {
	"US_Delta_Force_EP1" call GC_ChangeSkin;
	call compile preprocessFileLineNumbers "briefing.sqf";
	call addActions;
};

//keep npcs in right spot
{
	player reveal [(_x select 0), 4];
  (_x select 0) setPosASL (_x select 1);
} forEach npcposASLs;

//set gang area markers locally
if (count gangsarray > 0) then {
	{
		_gangmarker = "";
		_label = "";
		_read = _x getvariable "control";
		if (!isnil "_read") then {
			if(_x == gangarea1) then {
				_label = format["%1's Area 1 (cocaine - lsd)", _read];
				_gangmarker = "gangmarker1";
			};
			if(_x == gangarea2) then {
				_label = format["%1's Area 2 (heroin - lsd)", _read];
				_gangmarker = "gangmarker2";
			};
			if(_x == gangarea3) then {
				_label = format["%1's Area 3 (heroin - marijuana)", _read];
				_gangmarker = "gangmarker3";
			};
		};
		_gangmarker setMarkerColorLocal "ColorOrange";
		_gangmarker setMarkerTextLocal _label;
	} foreach gangareas;
};

if (!GC_HC) then {
	if (isnil "DisplayReports") then {DisplayReports = true;};

	[player,0.8,0.8,false] call GC_Sandstorm;
	[player,100,8,40] call GC_Crows;
};
