private ["_minearray"];

_art = _this select 0;

if (_art == "use") then {
  if(working)exitwith{};

  _item     = _this select 1;
  _anzahl   = _this select 2;
  working   = true;
  _isInArea = false;

  {
    if (player distance (getMarkerPos ((_x select 0) select 0)) < ((_x select 0) select 1) && isciv) then {_isInArea = true; _minearray = _x};
  } forEach miningarray;

  _resource = _minearray select 1;
  _max      = _minearray select 2;
  _infos    = _resource call INV_getitemArray;
  _name     = (_infos call INV_getitemName);
  _weight   = (_infos call INV_getitemTypeKg);

  if (!_isInArea) exitwith {
    player groupChat "You are not near a mine.";
    working = false;
  };

  if (_item == "Shovel") then {
    totalamount=0;
    _max = shovelmax;

    for [{_i=0}, {_i < 4}, {_i=_i+1}] do {
	_amount = floor((random (shovelmax + 1)) + (0.015 * SKILL_MINING));
      titletext ["Digging...", "PLAIN DOWN", 0.1];
      player playmove "AinvPknlMstpSlayWrflDnon";
      sleep 1.3;
      player switchmove "normal";
      shoveldur = shoveldur - (floor (random 2));

      if(shoveldur <= 0)exitwith{player groupchat "The shovel broke!"; ["Shovel", -1] call INV_AddInventoreItem; shoveldur=20;};

      _avail = floor (INV_Tragfaehigkeit - (call INV_GetOwnWeight));

      totalamount = totalamount + _amount;
      if((totalamount*_weight) >= _avail)exitwith{totalamount = (_avail/_weight); player groupchat "MAXIMUM WEIGHT REACHED"; _i=6;};
      player groupchat format["You got %1 %2.", _amount, _name];
      if (_amount < 1) then {player addMagazine ["HandGrenade_Stone", 2];}
    };

    totalamount = (floor (totalamount));
    [_resource, totalamount] call INV_AddInventoreItem;
    _addskill = (totalamount / 100);
    ["SKILL_MINING",_addskill] call GC_addSkill;
  };

  if (_item == "Pickaxe") then {
    totalamount=0;
    _max = pickaxemax;

    for [{_i=0}, {_i < 4}, {_i=_i+1}] do {
      _amount = floor((random (pickaxemax + 1)) + (0.075 * SKILL_MINING));
      titletext ["Working...", "PLAIN DOWN", 0.1];
      player playmove "AinvPknlMstpSlayWrflDnon";
      sleep 1.3;
      player switchmove "normal";
      pickaxedur = pickaxedur - (floor (random 2));

      if (pickaxedur <= 0) exitwith {player groupchat "The pickaxe broke!"; ["Pickaxe", -1] call INV_AddInventoreItem; pickaxedur=50;};

      _avail = floor (INV_Tragfaehigkeit - (call INV_GetOwnWeight));

      totalamount = totalamount + _amount;

      if((totalamount*_weight) >= _avail)exitwith{totalamount = (_avail/_weight); player groupchat "MAXIMUM WEIGHT REACHED"; _i=6;};

      player groupchat format["You got %1 %2.", _amount, _name];

      if (_amount < 1) then {player addMagazine ["HandGrenade_Stone", 2];};

    };

    totalamount = (floor (totalamount));
    [_resource, totalamount] call INV_AddInventoreItem;
    _addskill = (totalamount / 100);
    ["SKILL_MINING",_addskill] call GC_addSkill;
  };

  if (_item == "JackHammer") then {
    totalamount = 0;
    _max = hammermax;

    for [{_i=0}, {_i < 4}, {_i=_i+1}] do {
      titletext ["Drilling...", "PLAIN DOWN", 0.1];
      player playmove "AmovPercMstpSnonWnonDnon_exercisekneeBendB";

      _amount = round (random _max);
      hammerdur = hammerdur - (floor (random 2));
      if (hammerdur <= 0) exitwith { player groupchat "The Jackhammer broke!"; ["JackHammer", -1] call INV_AddInventoreItem; hammerdur=100;};
      _avail = floor (INV_Tragfaehigkeit - (call INV_GetOwnWeight));
      totalamount = totalamount + _amount;
      if ((totalamount*_weight) >= _avail) exitwith {totalamount = (_avail/_weight); player groupchat "MAXIMUM WEIGHT REACHED"; _i=6;};
      player groupchat format["You got %1 %2", _amount, _name];
      if (_amount < 1) then {player addMagazine ["HandGrenade_Stone", 2];};
      sleep 0.8;

      _amount = round (random _max);
      hammerdur = hammerdur - (floor (random 2));
      if (hammerdur <= 0) exitwith {player groupchat "The Jackhammer broke!"; ["JackHammer", -1] call INV_AddInventoreItem; hammerdur=100;};
      _avail = floor (INV_Tragfaehigkeit - (call INV_GetOwnWeight));
      totalamount = totalamount + _amount;
      if((totalamount*_weight) >= _avail)exitwith{totalamount = (_avail/_weight); player groupchat "MAXIMUM WEIGHT REACHED"; _i=6;};
      player groupchat format["You got %1 %2", _amount, _name];
      if (_amount < 1) then {player addMagazine ["HandGrenade_Stone", 2];};
      sleep 0.8;

      _amount = round (random _max);
      _amount = floor((random (hammermax + 1)) + (0.115 * SKILL_MINING));
      if(hammerdur <= 0)exitwith{player groupchat "The Jackhammer broke!"; ["JackHammer", -1] call INV_AddInventoreItem; hammerdur=100;};
      _avail = floor (INV_Tragfaehigkeit - (call INV_GetOwnWeight));
      totalamount = totalamount + _amount;
      if((totalamount*_weight) >= _avail)exitwith{totalamount = (_avail/_weight); player groupchat "MAXIMUM WEIGHT REACHED"; _i=6;};
      player groupchat format["You got %1 %2", _amount, _name];
      if (_amount < 1) then {player addMagazine ["HandGrenade_Stone", 2];};

      waituntil{animationstate player != "amovPercMstpSnonWnonDnon_exercisekneeBendB"};
    };

    totalamount = (floor (totalamount));
    [_resource, totalamount] call INV_AddInventoreItem;
    _addskill = (totalamount / 100);
    ["SKILL_MINING",_addskill] call GC_addSkill;
  };

  working=false;
};