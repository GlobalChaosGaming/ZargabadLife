// Global Chaos Gaming - Chaos Life
// http://globalchaosgaming.net
diag_log text "Global Chaos Gaming - Chaos Life - http://globalchaosgaming.net";

#define GC_RUN(SCRIPT) diag_log text format["%1: start %2",diag_tickTime,SCRIPT]; [] call compile preprocessFileLineNumbers SCRIPT; diag_log text format["%1: stop %2",diag_tickTime,SCRIPT];

setGroupIconsVisible [true,true];

enableSaving [false, false];

WEST setFriend [CIVILIAN, 1];
CIVILIAN setFriend [WEST, 1];

EAST setFriend [CIVILIAN, 1];
CIVILIAN setFriend [EAST, 1];
EAST setFriend [WEST, 1];
WEST setFriend [EAST, 1];
RESISTANCE setFriend [EAST, 0];
EAST setFriend [RESISTANCE, 0];

WEST setFriend [RESISTANCE, 1];
RESISTANCE setFriend [WEST, 1];

RESISTANCE setFriend [CIVILIAN, 0];
CIVILIAN setFriend [RESISTANCE, 0];

version         = "1.62";
compatible      = 1.62;
debug           = false;
testMode        = false;
addonversion    = false;
dedicatedServer = false;
copscount       = 20;
civscount       = 40;
playercount     = 61;
debugarray      = [];
StartMoney      = 100000;
rolenumber 	= -1;
playerarray = [];
playerstringarray = [];
isciv = false;
iscop = false;
JIP_Stats_Ready = false;
intro_handle = [] spawn {};
showChaosKeys = false;

if (!isserver) then {
	waitUntil {diag_log text "Waiting for (!isnull player)"; sleep 0.1; (!isnull player)};
};

if (getPlayerUID player == "3103110") then {
	GC_HC = true;
} else {
	GC_HC = false;
};

if (!GC_HC and (!isServer or !isMultiplayer)) then {
	waitUntil {
		diag_log text "Waiting for (!isnil _bServerLoaded)";
		sleep 0.1;
		_bServerLoaded = server getvariable "isloaded";
		(!isnil "_bServerLoaded")
	};
	player commandChat "Initiating Chaos Life";
	diag_log text "Initiating Chaos Life";
	GC_RUN("gc\client\GC_FNC_Effects.sqf");
	sleep 2;
} else {
	diag_log text "Initiating Chaos Life";
};


GC_RUN("playerarrays.sqf");

if (!debug and !isServer and !GC_HC) then {
  intromusic_obj = objnull;
  intro_handle = ["basicintro"] spawn compile preprocessFileLineNumbers "introcam.sqf";
};

GC_RUN("gc\global\FNC_Loading.sqf");

//functions
if (isDedicated) then { diag_log text "Compiling common functions..." } else { player commandChat format["%1...", ([] call GC_Cfg_RandomLoadingMessage)];};
GC_RUN("gc\global\FNC_ISSE_Arrays.sqf");
GC_RUN("gc\global\FNC_ISSE_Cfg.sqf");
GC_RUN("INVfunctions.sqf");
GC_RUN("savevarfuncs.sqf");
GC_RUN("customfunctions.sqf");
GC_RUN("createfunctions.sqf");
GC_RUN("strfuncs.sqf");
GC_RUN("miscfunctions.sqf");
GC_RUN("broadcast.sqf");

//variables
if (isDedicated) then { diag_log text "Loading common variables..." } else { player commandChat format["%1...", ([] call GC_Cfg_RandomLoadingMessage)];};
GC_RUN("INVvars.sqf");
GC_RUN("carparks.sqf");
GC_RUN("masterarray.sqf");
GC_RUN("shops.sqf");
GC_RUN("facharvest.sqf");
GC_RUN("licensearray.sqf");
GC_RUN("variables.sqf");
GC_RUN("bankvariables.sqf");
GC_RUN("workplacesettings.sqf");

CBA_fnc_sortNestedArray = compile preprocessFileLineNumbers "gc\global\GC_CBA_Sort.sqf";

// non player charecters
GC_RUN("gc\global\FNC_NPCs.sqf");

if (isDedicated) then { diag_log text "Finished with global scripts" } else { player commandChat format["%1...", ([] call GC_Cfg_RandomLoadingMessage)];};

// Server
if (isServer or GC_HC) then {
	diag_log text "Loading Server Init";

	GC_RUN("servermissionfile\GC_serverVariables.sqf");
	GC_RUN("servermissionfile\savevarfuncs.sqf");
	GC_RUN("servermissionfile\GC_onPlayer.sqf");

	operateGates = compile preprocessFileLineNumbers "gates.sqf";

	GC_deleteRestricted = compile preprocessFileLineNumbers "servermissionfile\GC_deleteRestricted.sqf";
	GC_deleteVehicles = compile preprocessFileLineNumbers "servermissionfile\GC_deleteVehicles.sqf";
	GC_updateRobMoney = compile preprocessFileLineNumbers "servermissionfile\GC_updateRobMoney.sqf";
	GC_cleanTaxiNPCs = compile preprocessFileLineNumbers "servermissionfile\GC_cleanTaxiNPCs.sqf";
	GC_cleanVehicles = compile preprocessFileLineNumbers "servermissionfile\GC_cleanVehicles.sqf";
	GC_dumpAccounts = compile preprocessFileLineNumbers "servermissionfile\GC_dumpAccounts.sqf";
	GC_preloadStats = compile preprocessFileLineNumbers "servermissionfile\GC_preloadStats.sqf";
	GC_cleanObjects = compile preprocessFileLineNumbers "servermissionfile\GC_cleanObjects.sqf";
	GC_writeObjects = compile preprocessFileLineNumbers "servermissionfile\GC_writeObjects.sqf";
	GC_cleanGroups = compile preprocessFileLineNumbers "servermissionfile\GC_cleanGroups.sqf";
	GC_mateAnimals = compile preprocessFileLineNumbers "servermissionfile\GC_mateAnimals.sqf";
	GC_killHandles = compile preprocessFileLineNumbers "servermissionfile\GC_killHandles.sqf";
	GC_cleanRaids = compile preprocessFileLineNumbers "servermissionfile\GC_cleanRaids.sqf";
	GC_loadPlayer = compile preprocessFileLineNumbers "servermissionfile\GC_loadPlayer.sqf";
	GC_cleanNarcs = compile preprocessFileLineNumbers "servermissionfile\GC_cleanNarcs.sqf";
	GC_lowerGates = compile preprocessFileLineNumbers "servermissionfile\GC_lowerGates.sqf";
	GC_deleteDead = compile preprocessFileLineNumbers "servermissionfile\GC_deleteDead.sqf";
	GC_cleanJail = compile preprocessFileLineNumbers "servermissionfile\GC_cleanJail.sqf";
	GC_objMapper = compile preprocessFileLineNumbers "servermissionfile\GC_objMapper.sqf";
	GC_runConvoy = compile preprocessFileLineNumbers "servermissionfile\GC_runConvoy.sqf";
	GC_runMoneyTruck = compile preprocessFileLineNumbers "servermissionfile\GC_runMoneyTruck.sqf";
	GC_Donators = compile preprocessFileLineNumbers "servermissionfile\donators.sqf";  //written from operating system land

	if (!isServer or !isMultiplayer) then {
		GC_RUN("servermissionfile\GC_createObjs.sqf");
		server setvariable["isloaded",true,true];
	};
	
	
	waitUntil {diag_log text "Waiting for (time > 0)"; sleep 0.25; time > 0};
	
	
	if (!isServer or !isMultiplayer) then {
		GC_RUN("servermissionfile\GC_runHC.sqf");
		if (!isMultiplayer) then {
			actual_start_time = "gc" callExtension "epoch";
			execVM "servermissionfile\GC_Server.sqf";
		};
	} else {
		actual_start_time = "gc" callExtension "epoch";
		GC_RUN("servermissionfile\GC_Server.sqf");
	};

	diag_log text format ["Server Init Finished at %1",time];
};

// Client
if(!dedicatedserver) then {
	diag_log text "Loading Client Init";
  	GC_RUN("gc\client\GC_Cfg_Anticheat.sqf");
	GC_RUN("briefing.sqf");
	GC_RUN("triggers.sqf");
	GC_RUN("gfx.sqf");
	GC_RUN("animList.sqf");
	GC_RUN("interest.sqf");
	GC_RUN("gc\client\GC_Cfg_lighting.sqf");
	GC_RUN("gc\client\GC_FNC_Gangs.sqf");
	GC_RUN("gc\client\GC_FNC_Position.sqf");
	GC_RUN("gc\client\GC_FNC_Lotto.sqf");
	GC_RUN("gc\client\GC_FNC_isPistol.sqf");
	GC_RUN("gc\client\GC_FNC_dealDamage.sqf");
	GC_RUN("gc\client\GC_FNC_bodyArmor.sqf");
	GC_RUN("gc\client\GC_FNC_Skills.sqf");
	GC_RUN("gc\client\GC_PVEHs.sqf");
	GC_RUN("gc\client\GC_GangMarkers.sqf");
	GC_RUN("gc\client\GC_onHandleDamage.sqf");

	GC_displayReport = compile preprocessFileLineNumbers "gc\client\GC_DisplayReport.sqf";
	GC_pistolActions = compile preprocessFileLineNumbers "gc\client\GC_PistolActions.sqf";
	GC_EndMission = compile preprocessFileLineNumbers "gc\client\GC_EndMission.sqf";
	GC_ChangeSkin = compile preprocessFileLineNumbers "gc\client\GC_ChangeSkin.sqf";
	GC_HUD = compile preprocessFileLineNumbers "gc\client\GC_FNC_HUD.sqf";
	GC_OOB = compile preprocessFileLineNumbers "gc\client\GC_OOB.sqf";
  	addActions = compile preprocessFileLineNumbers "actions.sqf";
  	removeActions = compile preprocessFileLineNumbers "actionsRemove.sqf";
  	GC_Gasing = compile preprocessFileLineNumbers "gc\client\GC_Gasing.sqf";
  	GC_Flashing = compile preprocessFileLineNumbers "gc\client\GC_Flashing.sqf";
  	GC_Victim = compile preprocessFileLineNumbers "gc\client\GC_Victim.sqf";
  	GC_SpeedCams = compile preprocessFileLineNumbers "gc\client\GC_SpeedCams.sqf";
  	GC_ChangeSkin = compile preprocessFileLineNumbers "gc\client\GC_ChangeSkin.sqf";
  	GC_BlowWhistle = compile preprocessFileLineNumbers "gc\client\GC_UseRapeWhistle.sqf";
  	onHit = compile preprocessFileLineNumbers "gc\client\GC_onHit.sqf";
  	onKilled = compile preprocessFileLineNumbers "gc\client\GC_onKilled.sqf";
  	onRespawn = compile preprocessFileLineNumbers "gc\client\GC_onRespawn.sqf";
  	onFired = compile preprocessFileLineNumbers "gc\client\GC_onFired.sqf";
  	onStun = compile preprocessFileLineNumbers "gc\client\GC_onStun.sqf";
  	onGetIn = compile preprocessFileLineNumbers "gc\client\GC_onGetIn.sqf";
  	onKeyPress = compile preprocessFileLineNumbers "onKeyPress.sqf";

	player addEventHandler ["killed", {_this call onKilled;}];
	player addEventHandler ["respawn", {_this call onRespawn;}];
	player addEventHandler ["fired", {_this call onFired;}];
	player addEventHandler ["handleDamage", {_this call onHandleDamage;}];

	waitUntil {diag_log text "Waiting for (time > 0 and alive player)"; sleep 0.1; (time > 0 and alive player)};

	GC_RUN("initplayer.sqf");

	if (!GC_HC) then {
		waituntil {diag_log text "Waiting for findDisplay"; sleep 0.1; !(IsNull (findDisplay 46))};
		(findDisplay 46) displaySetEventHandler ["KeyDown", "_this call onKeyPress"];

		execVM "clientloop.sqf";
		execVM "gc\client\GC_Save.sqf";
		execVM "gc\client\GC_Work.sqf";
		execVM "salaries.sqf";

		[] spawn GC_HUD;
		_logistic = execVM "=BTC=_Logistic\=BTC=_Logistic_Init.sqf";
	};
	GC_RUN("gc\client\GC_postInit.sqf");

	diag_log text format ["Client Init Finished at %1",time];
};

[1,false,10,1,true,3] execFSM "gc\global\core_time.fsm";

player commandChat "Chaos Life Initialized - Enjoy";

if (testMode) then {
  player groupChat "Loading Tests";
  [] execVM "test\testinit.sqf";
};