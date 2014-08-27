//spawned scripts
_gassed_handle = 0 spawn {};
_flashed_handle = 0 spawn {};
_infoboard_handle = 0 spawn {};
_speedcam_handle = 0 spawn {};

_counter3 = 1; // 3 seconds for fuel action

//flush counter 1hr
_loopcount = 1;

//raid vars
_last_checkpoint = nil;
_raidsize = 3;
_gracetime = 310;
_clearhint = false;

//for cop location markers on map
_copnumber = 1;
_copmarkernamearray = [];
while {_copnumber <= copscount} do {
	_copmarker = createMarkerLocal[format["cop%1_marker", _copnumber], [0, 0]];
	_markername = format["cop%1_marker", _copnumber];
	_copmarkernamearray = _copmarkernamearray + [_markername];
	_markername setMarkerShapeLocal "ICON";
	_markername setMarkerTypeLocal "DestroyedVehicle";
	_markername setMarkerColorLocal "ColorBlueFaded50";
	_markername setMarkerSizeLocal [0.01, 0.01];
	_copnumber = _copnumber + 1;
};

while {_loopcount <= 3600} do {
	_ctime = time;

	//NYI - get rid of these, use AllUnits
	coparray = [cop1,cop2,cop3,cop4,cop5,cop6,cop7,cop8,cop9,cop10,cop11,cop12,cop13,cop14,cop15,cop16,cop17,cop18,cop19,cop20];
	civarray = [civ1,civ2,civ3,civ4,civ5,civ6,civ7,civ8,civ9,civ10,civ11,civ12,civ13,civ14,civ15,civ16,civ17,civ18,civ19,civ20,civ21,civ22,civ23,civ24,civ25,civ26,civ27,civ28,civ29,civ30,civ31,civ32,civ33,civ34,civ35,civ36,civ37,civ38,civ39,civ40];
	playerarray = [civ1,civ2,civ3,civ4,civ5,civ6,civ7,civ8,civ9,civ10,civ11,civ12,civ13,civ14,civ15,civ16,civ17,civ18,civ19,civ20,civ21,civ22,civ23,civ24,civ25,civ26,civ27,civ28,civ29,civ30,civ31,civ32,civ33,civ34,civ35,civ36,civ37,civ38,civ39,civ40,cop1,cop2,cop3,cop4,cop5,cop6,cop7,cop8,cop9,cop10,cop11,cop12,cop13,cop14,cop15,cop16,cop17,cop18,cop19,cop20,chaosbot];
	for [{_i=0}, {_i < (count INV_PLAYERSTRINGLIST)}, {_i=_i+1}] do {INV_PLAYERLIST SET [_i, call compile (INV_PLAYERSTRINGLIST select _i)]};

	//huh?
	if (isnil "PlayerUID") exitWith {call GC_EndMission};
	if (typename PlayerUID != "ARRAY") exitWith {call GC_EndMission};
	if (typename (PlayerUID select 0) != "STRING" or str((PlayerUID select 0)) == " " or str((PlayerUID select 0)) == "") exitWith {call GC_EndMission};

	//normalize cash/bank
	_cash = 'cash' call INV_GetItemAmount;
	if (_cash < 0) then {['cash', 0] call INV_SetItemAmount; _cash = 0;};
	if (Kontostand > bank_limit) then {Kontostand = bank_limit;player groupChat localize "STRS_maxbank";};
	if (_cash > money_limit) then {['cash', money_limit] call INV_SetItemAmount; player groupChat localize "STRS_maxmoney";};
	if (debug and Kontostand <= 100000) then {Kontostand = 5000000;};

	//normlize rating and gangleader
	if (isciv) then {
		if (rating player != 0.01) then {
			player addRating ((rating player * -1) + 0.01);
		};
		if (gangleader) then {
			if (leader (group (vehicle player)) != player) then {
				format["group %1 selectLeader %1;",rolestring] call broadcast;
			};
		};
	};

	//stuff i do only when alive
	if (alive player) then {

		//this dosent make sense....
		if (DeadWaitSec > (respawnzeit+deadtimebonus)) then {DeadWaitSec = DeadWaitSec - deadtimebonus;};

		//listen to operated radios
		if (scriptDone radio_handle) then {
			{
				if (player distance _x <= 80) exitWith {
					if ((_x getvariable "on") == 1) then {
						_track = _x getvariable "track";
						_duration = _x getvariable "duration";
						_elapsed = _x getvariable "elapsed";
						radio_handle = [_track,_duration,_elapsed,_x] spawn {
							_track = _this select 0;
							_duration = _this select 1;
							_elapsed = _this select 2;
							_radio = _this select 3;
							_newaction = nil;
							_lasttrack = "";
							_lvl = (0.9*3/8);
							_mod = 1;
							while{(_radio getvariable "on") == 1 and player distance _radio <= 80 and alive player} do {
								_dist = vehicle player distance _radio;
								if (_dist > 5) then {_mod = 2;} else {_mod = 1};
								if (_dist > 25) then {_mod = 3;} else {_mod = 1};
								if (_dist > 40) then {_mod = 4;} else {_mod = 1};
								_fadeamt = (10/_dist*_lvl) / _mod;
								if (_fadeamt > 0.9) then { _fadeamt = 0.9; };
								if (_dist > 80) then {0.1 fadeMusic 0; _mod = 1} else {0.1 fadeMusic _fadeamt;};
								_track = _radio getvariable "track";
								if (_track != _lasttrack) then {
									if (!isnil "_newaction") then {player removeaction _newaction;};
									call compile format['_newaction = player addaction ["Turn off %1", "gc\client\GC_Music.sqf", [%2,2], 1, false, true, "", "player distance %2 <= 2"]',_track,_radio];
									_elapsed = _radio getvariable "elapsed";
									if (isnil "_track" or isnil "_elapsed") exitWith{};
									_lasttrack = _track;
									playMusic [_track, _elapsed];
								};
								sleep 1;
							};
							if (!isnil "_newaction") then {player removeaction _newaction;};
							3 fademusic 0;
							playMusic "";
						};
					};
				};
			} foreach [radio1,radio2,radio3];
		};

		//animate infoboards
		if (scriptDone _infoboard_handle) then {
			if (player distance storage < 15) then {
				_infoboard_handle = [] spawn {
					while {player distance storage < 15} do {
						storage setObjectTexture [0, "images\storage1.jpg"];
						sleep 0.5;
						storage setObjectTexture [0, "images\storage2.jpg"];
						sleep 0.5;
					};
				};
			};
			if (player distance storage_2 < 15) then {
				_infoboard_handle = [] spawn {
					while {player distance storage_2 < 15} do {
						storage_2 setObjectTexture [0, "images\storage1.jpg"];
						sleep 0.5;
						storage_2 setObjectTexture [0, "images\storage2.jpg"];
						sleep 0.5;
					};
				};
			};
		};

		//factory actions
		{
			_flag   = _x select 0;
			_name   = _x select 1;
			_cost   = _x select 6;
			_ablage = _x select 7;
			_owner   = false; if (_name in INV_Fabrikowner) then {_owner = true};
			if (player distance _flag <= 5) then {
				if ( (_owner) and (factory_action_a2 == 0) ) then {
					INV_action_facablage     = player addaction [localize "STRS_inv_fac_storage", "storage.sqf", [_ablage, "save"]];
					INV_action_facherstellen = player addaction [localize "STRS_inv_fac_mani", "facmani.sqf", [_forEachIndex]];
					INV_action_facworkers = player addaction [format["Buy factory worker ($%1)", facworkercost], "facqueue.sqf", _forEachIndex, 0, false, false];
					if (factory_action_a3 == 1) then {
						player removeaction INV_action_facbuy;
					};
					factory_action_a2 = 1;
					factory_action_f2 = _forEachIndex;
				};
				if ( (not(_owner)) and (factory_action_a3 == 0) ) then {
					INV_action_facbuy = player addaction [format[localize "STRS_inv_fac_buy", (_cost call ISSE_str_IntToStr)], "facbuy.sqf", [_forEachIndex]];
					factory_action_a3 = 1;
					factory_action_f2 = _forEachIndex;
				};
			};
			if ((player distance _flag >  4) and (factory_action_a2 == 1) and (factory_action_f2 == _forEachIndex)) then {
				player removeaction INV_action_facablage;
				player removeaction INV_action_facherstellen;
				player removeaction INV_action_facworkers;
				factory_action_a2 = 0;
			};
			if ((player distance _flag >  4) and (factory_action_a3 == 1) and (factory_action_f2 == _forEachIndex)) then {
				player removeaction INV_action_facbuy;
				factory_action_a3 = 0;
			};
		} foreach INV_ItemFabriken;

		//license actions
		{
			_license     = (_x select 0);
			_flag        = (_x select 1);
			_licensename = (_x select 2);
			_cost        = (_x select 3);
			_added       = licenses_purchased_array select _forEachIndex;

			if ((player distance _flag <= 5) and !(_license call INV_HasLicense) and (_added == 0)) then {
				call compile format ["a_license%1 = player addaction [format[localize ""STRS_inv_actions_buy"", ""%2"", %3], ""addlicense.sqf"", [%1, ""add""]];", _forEachIndex, _licensename, (_cost call ISSE_str_IntToStr)];
				licenses_purchased_array set [_forEachIndex, 1];
			};

			if ((player distance _flag > 5) and (_added == 1) || (_license call INV_HasLicense)) then {
				call compile format ["if (!isNil ""a_license%1"") then {player removeaction a_license%1;};", _forEachIndex];
				licenses_purchased_array set [_forEachIndex,0];
			};
		} foreach INV_Lizenzen;

		//pickup action
		{
			_exitvar = false;
			for "_i" from 0 to (count iactionarr) do {
				_arr = iactionarr select _i;
				if (!isnil "_arr") then {
					if(_x in _arr)exitwith{_exitvar=true};
				};
			};

			if(_exitvar)exitwith{};

			if(_x distance player < 3 and [_x, playerarray, 3] call ISSE_ArrayNumberNear < 2) then {
				_arr	= _x getvariable "droparray";
				if(isnil "_arr")exitwith{};
				_amount	= _arr select 0;
				_item 	= _arr select 1;
				_infos	= _item call INV_getitemarray;
				_name	= _infos call INV_getitemname;
				_action = player addaction [format["Pickup %1 (%2)", _name, _amount],"pickup.sqf",[_x, _item, _amount]];
				iactionarr = iactionarr + [[_x, _action]];
			};
		} foreach nearestobjects [player, ["Suitcase", "EvMoney"], 5];

		{
			deletevehicle _x;
		} foreach nearestobjects [player,["DSHkM_Mini_TriPod_TK_GUE_Bag_EP1","Tripod_Bag"],5];

		for [{_i=0}, {_i < (count iactionarr)}, {_i=_i+1}] do {
			_arr	= iactionarr select _i;
			_obj    = _arr select 0;
			_action = _arr select 1;
			_var	= _obj getvariable "droparray";
			if(isnull _obj or _obj distance player > 2 or (isnil "_var")) then {
				player removeaction _action;
				iactionarr set [_i, 0];
				iactionarr = iactionarr - [0];
			};
		};

		// refuel action (3 seconds)
		if (_counter3 >= 3) then {
			_counter3 = 0;
			for [{_i=0}, {_i < (count TankstellenArray)}, {_i=_i+1}] do {
				_flag = (TankstellenArray select _i);
				_vcl  = vehicle player;
				if (_vcl != player and driver _vcl == player and (vehicle player distance _flag <= 16) and (refuel_action_a1 == 0)) then {
					action_tankstelle = vehicle player addAction [format [localize "STRS_addAction_buy_gas", TankenCost],"petrolrefuel.sqf"];
					refuel_action_a1 = 1;
					refuel_action_v1 = vehicle player;
					refuel_action_f1 = _i;
				};
				if (((vehicle player == player) or (vehicle player distance _flag > 15)) and (refuel_action_f1 == _i) and (refuel_action_a1 == 1)) then {
					refuel_action_v1 removeAction action_tankstelle;
					refuel_action_a1 = 0;
				};
			};

		};

		//only do this if driving a vehicle
		if (vehicle player != player and player == driver vehicle player) then {
			if (scriptDone _speedcam_handle) then {
				_speedcam_handle = (vehicle player) spawn GC_SpeedCams;
			};
			if (iscop) then {
				if (!cop_is_driving) then {
					siren_action_veh = vehicle player;
					action_code0 = siren_action_veh addaction ["Lights/Siren Off","siren.sqf",["activate",0],1,false,true,"","cop_is_driving and siren_is_on"];
					action_code1 = siren_action_veh addaction ['<t color="#0000FF">Code 1</t>',"siren.sqf",["activate",1],1,false,true,"","cop_is_driving and !siren_is_on"];
					action_code2 = siren_action_veh addaction ['<t color="#FF0000">Code 2</t>',"siren.sqf",["activate",2],1,false,true,"","cop_is_driving and !siren_is_on"];
				};
				cop_is_driving = true;
			};
		} else {
			if (iscop) then {
				if (cop_is_driving) then {
					cop_is_driving = false;
					siren_action_veh removeAction action_code0;
					siren_action_veh removeAction action_code1;
					siren_action_veh removeAction action_code2;
				};
			};
		};

		//civs
		if (isciv) then {
			//not in jail
			if (local_arrest == 0) then {
				{if ((player distance (_x select 0)) < (_x select 1)) then {timeinworkplace = timeinworkplace + 1;};} forEach workplacearray;

				//gas fx
				if (player getVariable "gassed" and scriptDone _gassed_handle) then {
					_gassed_handle = [] spawn GC_Gassed;
				};
				
				//flashbang fx
				if (player getVariable "flashed" and scriptDone _flashed_handle) then {
					_flashed_handle = [] spawn GC_Flashed;
				};				

				//position restrictions
				if (!debug) then {
					_veh = vehicle player;
					if (player distance impoundarea1 < 400 or player distance impoundarea3 < 400) then {
						playSound "warnsfx";
						titleText [localize "STRS_southChernarus_area", "plain"];
					};
					if (player distance impoundarea1 < 300 or player distance impoundarea3 < 300) then {
						call TeleToMainbaseFunc;
					};
					if (player distance getmarkerpos "policebase" < 150 and !(_veh isKindOf "Air")) then {
						call TeleToMainbaseFunc;
					};
					if (player distance getMarkerPos "jailarea" <= 27 and player == vehicle player and local_arrest != 1) then {
						player setpos (getmarkerpos "jail_freemarker");
						player groupChat "Just visiting!";
					};

					//terror anti-camp
					_awaydist = 400;
					if (vehicle player distance terrornpc < _awaydist) then {
						_entertime = player getvariable "enter_terror";
						if (isnil "_entertime") then {
							player setvariable ["enter_terror",_ctime,false];
						} else {
							if (!kickedout) then {
								if ((time - _entertime) > 300) then {
									player groupchat "You have been at terror camp zone for over 5 minutes.  Wrap it up!";
									kickedout = true;
									player setvariable ["enter_terror",_ctime,false];
								};
							} else {
								if ((time - _entertime) > _gracetime) then {
									player setdammage 1;
								} else {
									_grace = round(abs((time - _entertime) - _gracetime));
									_seconds = _grace;
									_graceremains = "";
									if (_grace > 59) then {
										_minutes = floor (_grace / 60);
										_seconds = _seconds - (_minutes * 60);
										if (_seconds == 0) then {
											_graceremains = format["%1 min",_minutes];
										} else {
											_graceremains = format["%1 min, %2 seconds",_minutes,_seconds];
										};
									} else {
										 _graceremains = format["%1 seconds",_seconds];
									};
									if ((_gracetime - _grace) >= 10) then {
										hintsilent format["You have %1 remaining to get %2m away from terror camp!",_graceremains,_awaydist];
										_clearhint = true;
									};
								};
							};
						};
					} else {
						if (_clearhint) then {_clearhint = false; hintsilent "";};
						player setvariable ["enter_terror",nil,false];
						kickedout = false;
					};
				};

				//gangs
				if (gangmember) then {
					if (leader group player == player and !gangleader) then {
						for "_c" from 0 to (count gangsarray - 1) do {
							_gangarray = gangsarray select _c;
							_gang      = _gangarray select 0;
							_members   = _gangarray select 1;
							_leader    = _members select 0;
							if (!isnil "_leader") then {
								if (_leader == name player) exitWith {
									gangleader = true;
								};
								_lunit = [_leader, civarray] call INV_findunit;
								if (!isnull _lunit and alive _lunit) then {
									if (name player in _members) then {
										if (!(player in units group _lunit)) exitWith {
											[player] joinsilent group _lunit;
											diag_log text format["joining %1 group %2 cause im in a gang and not a leader and not already in his group",_lunit, group _lunit];
										};
									};
								};
							};
						};
					};
				};

				//gathering
				{
					_arr    = _x;
					_isInArea = false;
					{
						if (((vehicle player) distance (getMarkerPos (_x select 0))) < (_x select 1)) then {_isInArea = true;};
					} forEach (_arr select 0);

					_hasVehicle = false;
					{
						if ((vehicle player) isKindOf _x) then {_hasVehicle = true;};
					} forEach (_arr select 4);

					if ((_isInArea) and (_hasVehicle) and (speed (vehicle player) > 2 or ((_arr select 4) select 0) == "Ship")) then {
						[(_arr select 1), (_arr select 2), (_arr select 3), (_arr select 4)] execVM "gathergen.sqf";
					};
				} foreach INV_FarmItemArray;
				
				//proximity alert
				if (!isnil "convoytruck") then {
					if(player distance convoytruck <= 150) then {
						titleText ["The Government is operating in this area! Turn back or you will be shot!", "plain down"]
					};
				};
				
			};

		};
		//cops
		if (iscop) then {
			//markers
			_copcounter = 0;
			while {_copcounter < count coparray} do {
				_cop = coparray select _copcounter;
				if (isnull _cop or !isPlayer _cop or copmarker_on == 0) then {
					(_copmarkernamearray select _copcounter) setMarkerSizeLocal  [0.01, 0.01];
					(_copmarkernamearray select _copcounter) SetMarkerPosLocal [0,0];
					(_copmarkernamearray select _copcounter) setMarkerTextLocal "";
				} else {
					if (alive _cop) then {
						(_copmarkernamearray select _copcounter) setMarkerSizeLocal  [1, 1];
						(_copmarkernamearray select _copcounter) setMarkerTextLocal format["Cop%1" , (_copcounter + 1)];
						(_copmarkernamearray select _copcounter) SetMarkerPosLocal [position _cop select 0, position _cop select 1];
					};
				};
				_copcounter = _copcounter + 1;
			};

			{if ((player distance (_x select 0)) < (_x select 1)) then {timeinworkplace = timeinworkplace + 1;};} forEach checkpointarray;
			if (rating player < 1) then {player addRating (1 - rating player);};
			//position restrictions
			if (!debug) then {
				_veh = vehicle player;
				if (call GC_PlayerNotInBorder) then {
					_entertime = player getvariable "enter_border";
					_cparray = call GC_NearbyCheckpoint;
					_checkpoint = _cparray select 0;
					_cpobj = _cparray select 1;
					if (!(_veh iskindof "Air")) then {
						_westCount = {alive _x && side _x == west && _x distance _cpobj <= 100} count playableUnits;
						if (!isnull _cpobj) then {
							if (_westCount >= _raidsize) then {
								if (!(name player in copraidarray)) then {
									copraidarray = copraidarray + [name player];
								};
								format['
									if (iscop and !("%1" in copraidarray)) then {
										copraidarray = copraidarray + ["%1"];
									};
								',name player] call broadcast;
								not_raiding = false;
								_last_checkpoint = _checkpoint;
								player setvariable["last_checkpoint",_last_checkpoint,false];
							};
						} else {
							if (_westCount < 2) then {
								if (count raidarray == 0 and count copraidarray == 1 and name player in copraidarray) then {
									not_raiding = true;
									player setvariable ["raid_border",nil,false];
								};
							};
						};
					};

					if (isnil "_entertime") then {
						_rachanged = false;
						if (!(_checkpoint in raidarray) and !isnull _cpobj and !not_raiding and count(copraidarray) >= _raidsize) then {
							raidarray = raidarray + [_checkpoint];
							format['
								hint "Police are raiding outside the border from the %1 checkpoint!";
								if ((iscop or isServer) and !("%1" in raidarray)) then {raidarray = raidarray + ["%1"];};
							',_checkpoint] call broadcast;
							_last_checkpoint = _checkpoint;
							player setvariable["last_checkpoint",_last_checkpoint,false];
							_rachanged = true;
						};
						if (_veh iskindof "Air") then {
							if (count raidarray > 0 or (count(crew _veh) + count(copraidarray)) >= _raidsize) then {
								_last_checkpoint = _checkpoint;
								player setvariable["last_checkpoint",_last_checkpoint,false];
								[_rachanged,_cpobj,_checkpoint,_veh] spawn {
									_rachanged = _this select 0;
									_cpobj = _this select 1;
									if (!isnull _cpobj) then {
										_checkpoint = _this select 2;
										_veh = _this select 3;
										not_raiding = false;
										if (_rachanged) then {
											sleep 5;
										} else {
											if (!(_checkpoint in raidarray)) then {
												raidarray = raidarray + [_checkpoint];
											};
											format['
												if ((iscop or isServer) and !("%1" in raidarray)) then {
													raidarray = raidarray + ["%1"];
												};
											',_checkpoint] call broadcast;
										};
										if (driver _veh == player) then {
											format['hint "A Police helicopter is raiding from the %1 checkpoint!"',_checkpoint] call broadcast;
										};
										if (!(name player in copraidarray)) then {
											copraidarray = copraidarray + [name player];
										};
										{
											format['
												if (iscop and !("%1" in copraidarray)) then {
													copraidarray = copraidarray + ["%1"];
												};
												not_raiding = false;
											',name _x] call broadcast;
										} foreach (crew _veh);
									};
								};
							};
						};
						player setvariable ["enter_border",_ctime,false];
					};

					if (not_raiding) then {
						_raid_ctime = player getvariable "raid_border";
						if (!isnil "_raid_ctime") then {
							if ((time - _raid_ctime) > _gracetime) then {
								call GC_OOB;
							} else {
								_grace = round(abs((time - _raid_ctime) - _gracetime));
								_seconds = _grace;
								_graceremains = "";
								if (_grace > 59) then {
									_minutes = floor (_grace / 60);
									_seconds = _seconds - (_minutes * 60);
									if (_seconds == 0) then {
										_graceremains = format["%1 min",_minutes];
									} else {
										_graceremains = format["%1 min, %2 seconds",_minutes,_seconds];
									};
								} else {
								         _graceremains = format["%1 seconds",_seconds];
								};
								if ((_gracetime - _grace) >= 10) then {
									hintsilent format["You have %1 remaining to get back to the city!",_graceremains];
									_clearhint = true;
								};
							};
						} else {
							if (!isnil "_last_checkpoint") then {
								if (!(_last_checkpoint in raidarray)) then {
									call GC_OOB;
								} else {
									if (!(name player in copraidarray)) then {
										copraidarray = copraidarray + [name player];
									};
									not_raiding = false;
								};
							} else {
								call GC_OOB;
							};
						};
					} else {
						player setvariable ["raid_border",_ctime,false];
						_westCount = {alive _x && side _x == west && _x distance vehicle player <= 500} count playableUnits;
						if (_westCount < 2) then {
							if (name player in copraidarray) then {
								copraidarray = copraidarray - [name player];
								format['
									if (iscop and "%1" in copraidarray) then {
										copraidarray = copraidarray - ["%1"];
									};
								',name player] call broadcast;
							};
							not_raiding = true;
						};
						if (count copraidarray < _raidsize) then {
							if (_last_checkpoint in raidarray) then {
								format['
									hint "Police raid from the %1 checkpoint has ended.";
									if (iscop or isServer) then {
										raidarray = raidarray - ["%1"];
										not_raiding = true;
									};
								',_last_checkpoint] call broadcast;
							};
						};
						if (!isnil "_entertime") then {
							if ((time - _entertime) >= 600) then {
								player groupchat "You have been raiding for 10 minutes.  Wrap it up!";
								not_raiding = true;
							};
						};

					};
				} else {
					if (_clearhint) then {_clearhint = false; hintsilent "";};
					OutOFBoundsTicks = 0;
					player setvariable ["enter_border",nil,false];
					player setvariable ["raid_border",nil,false];
					if (name player in copraidarray) then {
						copraidarray = copraidarray - [name player];
						format['
							if (iscop and "%1" in copraidarray) then {
								copraidarray = copraidarray - ["%1"];
							};
						',name player] call broadcast;
					};

					if (count copraidarray < _raidsize) then {
						if (!isnil "_last_checkpoint") then {
							if (_last_checkpoint in raidarray) then {
								format['
									hint "Police raid from the %1 checkpoint has ended.";
									if (iscop or isServer) then {
										raidarray = raidarray - ["%1"];
										not_raiding = true;
									};
								',_last_checkpoint] call broadcast;
							};
						};
					};
					not_raiding = true;
					_last_checkpoint = nil;
				};
			};
		};
	};
	_counter3 = _counter3 + 1;
	_loopcount = _loopcount + 1;
	sleep 1;
};
diag_log text format["flushing %1",__FILE__];
execVM "clientloop.sqf";
