// Improved gang flags by Durandal and Amerine

takingFlag  = true;

_this     = _this select 3; //discard unused passed data from action
_gangarea = _this select 0; //the ga (flag) where the calling action was used
_type     = _this select 1; //"capture" or "neutralise"

_rate   = 0;
_dir    = 0;
if (_type == "neutralise") then {_dir = -1};
if (_type == "capture") then {_dir = 1};


// ============ for gang area map markers ============

_setLabel = {

  _label = "";
  _gangmarker = nil;

  if(_type == "neutralise") then {
    if(_gangarea == gangarea1) then {
      _label = "Gang Area 1 (cocaine - lsd)";
      _gangmarker = "gangmarker1";
    };
    if(_gangarea == gangarea2) then {
      _label = "Gang Area 2 (heroin - lsd)";
      _gangmarker = "gangmarker2";
    };
    if(_gangarea == gangarea3) then {
      _label = "Gang Area 3 (heroin - marijuana)";
      _gangmarker = "gangmarker3";
    };

    _gangmarker setMarkerColor "ColorBrown";
  };

  if(_type == "capture") then {
    _mygang = call INV_mygang;

    if(_gangarea == gangarea1) then {
      _label = format["%1's Area 1 (cocaine - lsd)", _mygang];
      _gangmarker = "gangmarker1";
    };
    if(_gangarea == gangarea2) then {
      _label = format["%1's Area 2 (heroin - lsd)", _mygang];
      _gangmarker = "gangmarker2";
    };
    if(_gangarea == gangarea3) then {
      _label = format["%1's Area 3 (heroin - marijuana)", _mygang];
      _gangmarker = "gangmarker3";
    };

    _gangmarker setMarkerColor "ColorOrange";
  };

  _gangmarker setMarkerText _label;
};


// ============ capture and neutralize action ============

flagCancel = player addaction ["Stop Taking Flag", "gc\client\GC_StopTakingFlag.sqf", _gangarea];

while {takingFlag} do {

  player playmove "AinvPknlMstpSlayWrflDnon_medic";

  waitUntil {animationState player == "AinvPknlMstpSlayWrflDnon_medic"};

  //determine the nearby players
  _near = nearestObjects[_gangarea, ["Man"], 10];
  _working = [];
  _i = 0;
  {
    if (animationState _x == "AinvPknlMstpSlayWrflDnon_medic") then {
      _working set [_i, _x];
      _i = _i + 1;
    };
  } forEach _near;

  _mover = _gangarea getVariable "mover";

  //actual movement is done by the closest player to the flag
  if((_working select 0 == player) and (isNil "_mover")) then {

    _gangarea setVariable["mover", player, true];

    //set the rate based on number of nearby working
    switch (count _working) do {
    	case 0: {
    		_rate = 0.00;
    	};
      case 1: {
        _rate = 0.15;
      };
      case 2: {
        _rate = 0.20;
      };
      case 3: {
        _rate = 0.25;
      };
      case 4: {
        _rate = 0.30;
      };
      case 5: {
        _rate = 0.50;
      };
    };

    _delta = _rate * _dir;

    _oldHeight = _gangarea getVariable "height";

    // GC_FNC_NormalizeGangFlagHeight will never return a height less than -7 or greater than 0.
    _newHeight = [_oldHeight, _delta] call GC_FNC_NormalizeGangFlagHeight;

    _gangarea setVariable["height", _newHeight, true];

    _gangarea setPosATL [getPosATL _gangarea select 0, getPosATL _gangarea select 1, _newHeight];

    // warn
    if (_newHeight <= -4.0) then {

      _current_owner = _gangarea getVariable "control";

      if (!(isNil "_current_owner")) then {
        format["if (isciv and ""%2"" == (call INV_mygang)) then { hint ""%2 is taking %3"";};", _current_owner, (call INV_mygang), _gangarea, "%1"] call broadcast;
      };
    };

    // neutralize
    if(_newHeight <= -7.0) then {

      _mygang = call INV_mygang;
      _control = _gangarea getVariable "control";

      if(_mygang != "" and !isnil "_control") then {

        _gangarea setVariable["control", nil, true];

        call _setLabel;

        format["if (isciv) then{hint ""%1 has been neutralised by %2!"";};", _gangarea, _mygang] call broadcast;
      };
    };

    // capture
    if(_newHeight >= 0.0) then {

      _mygang = call INV_mygang;
      _control = _gangarea getVariable "control";

      if(_mygang != "" and isnil "_control") then {

        _gangarea setVariable["control", _mygang, true];

        call _setLabel;

        format["if (isciv) then {hint ""%1 has been captured by %2!"";};", _gangarea, _mygang] call broadcast;
      };
    };

    waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};

    _gangarea setVariable["mover", nil, true];
  };

  //all players stop working when gang area reaches an end point
  if((_gangarea getVariable "height" <= -7.00) and _type == 'neutralise') then {
    takingFlag = false;
    player removeAction flagCancel;
  };

  if((_gangarea getVariable "height" >= 0.00) and _type == 'capture') then {
    takingFlag = false;
    player removeAction flagCancel;
  };

  waituntil {animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};
};
