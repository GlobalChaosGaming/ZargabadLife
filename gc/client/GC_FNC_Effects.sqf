/*

The FunctionManager load fails at high runtime and has dependancy 
on BIS multiplayer framework code we don't want to use

*/

GC_Crows = {
	private ["_flockPos","_flockArea","_flockCount","_wp0","_wp1","_wp2","_wp3","_wps","_crowList","_crow"];

	_flockPos = _this select 0;
	_flockArea = if (count _this > 1) then {_this select 1} else {50};
	_flockCount = if (count _this > 2) then {_this select 2} else {_flockArea / 5};
	_flockHeight = if (count _this > 3) then {_this select 3} else {30 + random 10};

	if (typename _flockPos == typename objnull) then {_flockPos = position _flockPos};
	if (typename _flockPos == typename "") then {_flockPos = markerpos _flockPos};

	_flockPos set [2,_flockHeight];
	_wp0 = [_flockPos, _flockArea, 00] call GC_relPos;
	_wp1 = [_flockPos, _flockArea, 090] call GC_relPos;
	_wp2 = [_flockPos, _flockArea, 180] call GC_relPos;
	_wp3 = [_flockPos, _flockArea, 270] call GC_relPos;
	_wps = [_wp0,_wp1,_wp2,_wp3];

	_crowList = [];
	for "_i" from 1 to _flockCount do {
		_crow = "crow" camcreate [
			(_flockPos select 0) - _flockArea + (random _flockArea)*2,
			(_flockPos select 1) - _flockArea + (random _flockArea)*2,
			_flockHeight
		];
		[_crow,_wp0,_wp1,_wp2,_wp3,_flockArea] execfsm "ca\modules_PMC\Functions\Environment\fn_crows.fsm";
		_crowList = _crowList + [_crow];
	};

	_crowList;
};

GC_Sandstorm = {
	private ["_obj","_density","_colorCoef","_newspapers","_pos","_velocity","_relPos","_color","_alpha","_ps","_newsParams","_newsRandom","_newsCircle","_newsInterval","_times","_herald","_tribune","_result"];

	_obj = _this select 0;
	_density = if (count _this > 1) then {_this select 1} else {0.07}; if (_density < 0) then {_density = 0.07};
	_colorCoef = if (count _this > 2) then {_this select 2} else {1}; if (_colorCoef < 0) then {_density = 1};
	_newspapers = if (count _this > 3) then {_this select 3} else {true};
	_pos = position _obj;

	//--- Dust
	_duration = 2;
	_velocity = [0,7,0];
	_relPos = [-((_velocity select 1) * (_duration / 2)), 0, -6];
	_color = [1.0 * _colorCoef, 0.9 * _colorCoef, 0.8 * _colorCoef];
	_alpha = 0.2;
	_ps = "#particlesource" createVehicleLocal _pos;  
	_ps setParticleParams [["\Ca\Data\ParticleEffects\Universal\universal.p3d", 16, 12, 8, 0], "", "Billboard", 1, _duration, _relPos, _velocity, 1, 1.275, 1, 0, [5], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _obj];
	_ps setParticleRandom [3, [10, 10, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.05], 0, 0];
	_ps setParticleCircle [0.1, [0, 0, 0]];
	_ps setDropInterval _density;

	//--- Newspapers
	_result = if (_newspapers) then {
		_newsParams = [["\ca\Missions_PMC\gnews1.p3d", 1, 0, 1], "", "SpaceObject", 1, 5, [0, 0, 1], _velocity, 1, 1.25, 1, 0.2, [0,1,1,1,0], [[1,1,1,1]], [0.7], 1, 0, "", "", _obj];
		_newsRandom = [0, [30, 30, 0], [5, 5, 0], 2, 0.3, [0, 0, 0, 0], 10, 0];
		_newsCircle = [0.1, [1, 1, 0]];
		_newsInterval = 1;

		_times = "#particlesource" createVehicleLocal _pos;  
		_times setParticleParams _newsParams;
		_times setParticleRandom _newsRandom;
		_times setParticleCircle _newsCircle;
		_times setDropInterval _newsInterval;

		_newsParams set [0,["\ca\Missions_PMC\gnews2.p3d", 1, 0, 1]];
		_herald = "#particlesource" createVehicleLocal _pos;  
		_herald setParticleParams _newsParams;
		_herald setParticleRandom _newsRandom;
		_herald setParticleCircle _newsCircle;
		_herald setDropInterval _newsInterval;

		_newsParams set [0,["\ca\Missions_PMC\gnews3.p3d", 1, 0, 1]];
		_tribune = "#particlesource" createVehicleLocal _pos;  
		_tribune setParticleParams _newsParams;
		_tribune setParticleRandom _newsRandom;
		_tribune setParticleCircle _newsCircle;
		_tribune setDropInterval _newsInterval;

		[_ps,_times,_herald,_tribune]
	} else {
		[_ps]
	};

	_result

};

GC_infoText = {
	3100 cutrsc ["rscInfoText","plain"];


	//--- Separate lines
	_text = _this;
	_textArrayUnicode = [];
	{_textArrayUnicode = _textArrayUnicode + [toarray _x]} foreach _text;


	//--- Separate letters
	_textArrayLines = [];
	for "_i" from 0 to (count _textArrayUnicode - 1) do {
		_line = _textArrayUnicode select _i;
		_textArrayTemp = [];
		{_textArrayTemp = _textArrayTemp + [tostring [_x]]} foreach _line;
		_textArrayLines set [_i,_textArrayTemp];
	};


	//--- Merge arrays
	_textArray = [];
	_emptyArray = [];
	_nArrayTemp = [];
	_n = 0;
	{
		_line = _x;
		_textArray = _textArray + _line + ["\n"];
		{
			//_emptyArray = _emptyArray + [_line call bis_fnc_selectrandom]; //--- Shuffled text
			//_emptyArray = _emptyArray + [str floor random 2]; //--- Binary Solo
			//_emptyArray = _emptyArray + [""]; //--- Rolling text
			_emptyArray = _emptyArray + [" "]; //--- Space
			_nArrayTemp = _nArrayTemp + [_n];
			_n = _n + 1;
		} foreach _x;
		_n = _n + 1;
		_emptyArray = _emptyArray + ["\n"];
	} foreach _textArrayLines;
	_finalArray = _emptyArray;
	_text = composetext _finalArray;


	//--- Random order
	_nArray = [];
	while {count _nArrayTemp > 0} do {
		_element = _nArrayTemp select (floor random (count _nArrayTemp));
		_nArray = _nArray + [_element];
		_nArrayTemp = _nArrayTemp - [_element];
	};


	//--- Visualization
	disableserialization;
	_display = uinamespace getvariable "BIS_InfoText";
	_textControl = _display displayctrl 3101;


	_text = composetext _finalArray;
	_textControl ctrlsettext str _text;
	_textControl ctrlcommit 0.01;
	sleep 1;

	{
		_finalArray set [_x,_textArray select _x];
		_text = composetext _finalArray;
		_textControl ctrlsettext str _text;
		_textControl ctrlcommit 0.01;
		playsound "counter";
		if (random 1 > 0.9) then {sleep 0.1};
		sleep 0.01;
	} foreach _nArray;

	sleep 2;


	//--- Fade away
	{
		_finalArray set [_x," "];
		_text = composetext _finalArray;
		_textControl ctrlsettext str _text;
		_textControl ctrlcommit 0.01;
		playsound "counter";
		//if (random 1 > 0.9) then {sleep 0.2};
		sleep 0.01;
	} foreach _nArray;


	3100 cuttext ["","plain"];
};

GC_dynamicText = {
	disableserialization;

	_text = _this select 0;
	_x = if (count _this > 1) then {_this select 1} else {-1};
	_y = if (count _this > 2) then {_this select 2} else {-1};
	_w = -1;
	_h = -1;
	_delay = if (count _this > 3) then {_this select 3} else {4};
	_fade = if (count _this > 4) then {_this select 4} else {1};
	_moveY = if (count _this > 5) then {_this select 5} else {0};
	_layer = if (count _this > 6) then {_this select 6} else {789};
	if (_delay < 0) then {_delay = 4};
	if (_fade < 0) then {_fade = 1};

	//--- Width and Height
	if (typename _x == typename []) then {
		_array = _x;
		_x = _array select 0;
		_w = _array select 1;
	};
	if (typename _y == typename []) then {
		_array = _y;
		_y = _array select 0;
		_h = _array select 1;
	};

	_layer cutrsc ["rscDynamicText","plain"];

	_display = uinamespace getvariable "BIS_dynamicText";
	_control = _display displayctrl 9999;
	_control ctrlsetfade 1;
	_control ctrlcommit 0;
	_pos = ctrlposition _control;
	if (_x != -1) then {_pos set [0,_x]};
	if (_y != -1) then {_pos set [1,_y]};
	if (_w != -1) then {_pos set [2,_w]};
	if (_h != -1) then {_pos set [3,_h]};
	_control ctrlsetposition _pos;
	_control ctrlsetstructuredtext parsetext _text;
	_control ctrlcommit 0;

	_control ctrlsetfade 0;
	_control ctrlcommit _fade;
	waituntil {ctrlcommitted _control};

	if (_moveY != 0) then {
		_y = _pos select 1;
		_pos set [1,_y + _moveY];
		_control ctrlsetposition _pos;
		_control ctrlcommit _delay;
	};

	//if (_layer != 789) exitwith {};

	_spawn = missionnamespace getvariable format ["bis_dynamicText_spawn_%1",_layer];
	if (!isnil "_spawn") then  {terminate _spawn};
	_spawn = [_control,_delay,_fade,_moveY,_layer] spawn {
		disableserialization;
		_control = _this select 0;
		_delay = _this select 1;
		_fade = _this select 2;
		_moveY = _this select 3;
		_layer = _this select 4;

		if (_moveY != 0) then {waituntil {ctrlcommitted _control}} else {sleep _delay};

		_control ctrlsetfade 1;
		_control ctrlcommit 1;
		waituntil {ctrlcommitted _control};

		_layer cuttext ["","plain"];
	};
	missionnamespace setvariable [format ["bis_dynamicText_spawn_%1",_layer],_spawn];
	waituntil {scriptdone _spawn};
};

GC_customGPS = {
	_params = ["ca\missions_pmc\data\ui_gps_ca.paa",-0.26,0.16];
	_frame = _params select 0;
	_dx = if (count _params > 1) then {_params select 1} else {0};
	_dy = if (count _params > 2) then {_params select 2} else {0};

	#define GPS_DISPLAY	(_this select 0)
	#define GPS_MAP		(GPS_DISPLAY displayctrl 101)
	#define GPS_FRAME	(GPS_DISPLAY displayctrl 101000)

	_posMap = ctrlposition GPS_MAP;
	_posMap set [0,(_posMap select 0) + _dx];
	_posMap set [1,(_posMap select 1) + _dy];
	GPS_MAP ctrlsetposition _posMap;
	GPS_MAP ctrlcommit 0;   

	_posFrame = ctrlposition GPS_FRAME;
	_posFrame set [0,(_posFrame select 0) + _dx];
	_posFrame set [1,(_posFrame select 1) + _dy];

	GPS_FRAME ctrlsetposition _posFrame;
	GPS_FRAME ctrlsettext _frame;
	GPS_FRAME ctrlcommit 0;
};

GC_Blood = {
	disableserialization;

	_unit = _this select 0;
	_selection = _this select 1;
	_damage = _this select 2;

	//--- Different player - terminate
	if (_selection != "" || _unit != player) exitwith {};

	//--- Calculate blood size
	_int = 0.5 + (_damage min 1);

	//--- Display not created
	if (isnil {uinamespace getvariable "BIS_RscMissionScreen_Blood"}) then {
		15 cutrsc ["RscMissionScreen","plain"];
		waituntil {!isnull (uinamespace getvariable "BIS_RscMissionScreen")};
		uinamespace setvariable ["BIS_RscMissionScreen_Blood",uinamespace getvariable "BIS_RscMissionScreen"];
	} else {
		if (isnull (uinamespace getvariable "BIS_RscMissionScreen_Blood")) then {
			15 cutrsc ["RscMissionScreen","plain"];
			waituntil {!isnull (uinamespace getvariable "BIS_RscMissionScreen")};
			uinamespace setvariable ["BIS_RscMissionScreen_Blood",uinamespace getvariable "BIS_RscMissionScreen"];
		};
	};
	_display = uinamespace getvariable "BIS_RscMissionScreen_Blood";

	/// EW ///////////////////////////////////////////////////////
	"dynamicblur" ppeffectenable true;
	"dynamicblur" ppeffectadjust [1];
	"dynamicblur" ppeffectcommit 0;
	"dynamicblur" ppeffectadjust [0];
	"dynamicblur" ppeffectcommit (1 + random 1);

	//--- Vignette
	_vignette = _display displayctrl 1106;
	_vignette ctrlsettext "ca\missions_PMC\data\ui_screen_vignette_ca.paa";
	_vignette ctrlsetposition [safezoneX,safezoneY,safezoneW,safezoneH];
	_vignette ctrlsetfade 0;
	_vignette ctrlcommit 0.1;

	//--- Select free layer
	_control = controlnull;
	_id = 0;
	for "_i" from 1100 to 1105 do {
		_c = _display displayctrl _i;
		_f = ctrlfade _c;
		_p = ctrlposition _c;
		if ((_p select 3) == safezoneH) then {_f = 1};
		if (_f == 1) exitwith {_control = _c; _id = _i % 3};
	};
	if (isnull _control) exitwith {};

	//--- Select position
	_w = safezoneW * _int;
	_h = _w / 0.75;
	_pos = [
		((safezoneX - _w/2) + random (safezoneW)),
		((safezoneY - _h/2) + random (safezoneH)),
		_w,
		_h
	];

	//--- Fade out (0s)
	_control ctrlsettext format ["ca\missions_PMC\data\ui_screen_blood_%1_ca.paa",_id + 1];
	_control ctrlsetposition _pos;
	_control ctrlsetfade 1;
	_control ctrlcommit 0;

	//--- Fade in (0.1s)
	_control ctrlsetfade 0;
	_control ctrlcommit 0.1;
	waituntil {ctrlcommitted _control};

	sleep 0.1;
	_vignette ctrlsetfade 1;
	_vignette ctrlcommit 6;

	sleep 3;

	//--- Fade out (random 5-15s)
	_control ctrlsetfade 1;
	_control ctrlcommit (5 + random 10);
	waituntil {ctrlcommitted _control};

	//--- Reset
	if (ctrlfade _control == 0) then {
		_control ctrlsetposition [0,0,0,0];
		_control ctrlcommit 0;
	};
	_vignette ctrlsetfade 1;
	_vignette ctrlcommit 0.1;
};

GC_Gassed = {
	private ["_masktime","_i","_blur"];
	_masktime = 5;
	if (('GasMask' call INV_GetItemAmount) > 0) then {
		call compile format['SFXPvEh_%1 = ["%2","breathingsfx",5];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];
		player say "breathingsfx";
		if (random 100 > 75) then {
			['GasMask', (-1)] call INV_SetItemAmount;
			player GroupChat "Your mask's filter has been depleted!";
		};
		_masktime = 2.5;
	} else {
		call compile format['SFXPvEh_%1 = ["%2","coughsfx",5];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];
		player say "coughsfx";
		player playMoveNow "amovpercmstpsraswrfldnon_amovpknlmstpslowwrfldnon";
	};
	StunActiveTime = StunActiveTime + _masktime;
	player setVariable ["gassed",false, true];
	_blur = ppEffectCreate ["dynamicBlur", -13501];
	_blur ppEffectEnable true;
	_blur ppEffectAdjust [1];
	_blur ppEffectCommit 0;
	135210 cutText["", "WHITE IN",5];
	135210 cutFadeOut (2);
	_i = 1;
	while { _i < 40 } do {
		_blur ppEffectAdjust [_i + 1];
		_blur ppEffectCommit 4;
		_i = _i + 2;
		sleep 0.2;
	};
	135210 cutText["", "WHITE IN",0];
	135210 cutFadeOut (StunActiveTime);
	sleep StunActiveTime;
	_blur ppEffectAdjust [1];
	_blur ppEffectCommit 0;
	sleep 1;
	_blur ppEffectEnable false;
};

GC_Flashed = {
	private ["_i","_blur","_v1","_v2","_v3","_v1add","_v2add","_d","_dAdd"];
	player playMoveNow "amovpercmstpsraswrfldnon_amovpknlmstpslowwrfldnon";	
	StunActiveTime = StunActiveTime + 5;
	player setVariable ["gassed",false, true];
	_blur = ppEffectCreate ["dynamicBlur", -13501];
	_blur ppEffectEnable true;
	_blur ppEffectAdjust [1];
	_blur ppEffectCommit 0;
	135210 cutText["", "WHITE IN",5];
	135210 cutFadeOut (2);
	_i = 1;
	while { _i < 40 } do {
		_blur ppEffectAdjust [_i + 1];
		_blur ppEffectCommit 4;
		_i = _i + 2;
		sleep 0.2;
		if (vehicle player == player) then {
			_v1 = velocity player select 0;
			_v2 = velocity player select 1;
			_v3 = 1;
			_v1add = (random 2 - random 1); _v2add = (random 2 - random 1);
			player setVelocity [_v1+_v1add, _v2+_v2add, _v3];
		} else {
			_d = direction vehicle player;
			_dAdd = (random 30) - 15;
			vehicle player setDir (_d + _dAdd);
		};		
		
	};
	135210 cutText["", "WHITE IN",0];
	135210 cutFadeOut (StunActiveTime);
	sleep StunActiveTime;
	_blur ppEffectAdjust [1];
	_blur ppEffectCommit 0;
	sleep 1;
	_blur ppEffectEnable false;	
};