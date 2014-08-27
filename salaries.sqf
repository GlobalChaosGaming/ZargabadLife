_loopcount = 0;

if (iscop) then {
  // Cop Income
  while {_loopcount <= 20} do {
    _loopcount = _loopcount + 1;
    sleep 60;
    player groupChat format[localize "STRS_cash_countdown", "2"];
    sleep 60;
    player groupChat format[localize "STRS_cash_countdown", "1"];
    sleep 60;
    _patrol_check      = 0;
    _response_check    = 0;
    _air_support_check = 0;
    _swat_check        = 0;
    _workplacepaycheck = 0;
    _training_income   = 0;

    _income = add_copmoney + donatorcashbonus;

    if ("patrol_training" call INV_HasLicense) then {
      _patrol_check = (200 + random 50);
    };

    if ("response_training" call INV_HasLicense) then {
      _response_check = (500 + random 100);
    };

    if ("air_support_training" call INV_HasLicense) then {
      _air_support_check = (750 + random 150);
    };

    if ("swat_training" call INV_HasLicense) then {
      _swat_check = (1000 + random 200);
    };

    if (timeinworkplace > 0) then {
      _workplacepaycheck = (round(add_checkpoint/180*timeinworkplace));
    };

    _training_income =  _patrol_check + _response_check + _air_support_check + _swat_check;
    _income = _income + _training_income + _workplacepaycheck;

    timeinworkplace = 0;

    kontostand = kontostand + (round _income);
    player groupChat format[localize "STRS_cash_copmoneyadd", rolestring, ((round _income) call ISSE_str_IntToStr)];
    if (donatorcashbonus > 0) then {
      player groupChat format[localize "STRS_cash_copmoney_paycheck_donor", (add_copmoney call ISSE_str_IntToStr), (_training_income call ISSE_str_IntToStr), (_workplacepaycheck call ISSE_str_IntToStr), (donatorcashbonus call ISSE_str_IntToStr)];
    } else {
      player groupChat format[localize "STRS_cash_copmoney_paycheck", (add_copmoney call ISSE_str_IntToStr), (_training_income call ISSE_str_IntToStr), (_workplacepaycheck call ISSE_str_IntToStr)];
    };
    sleep 1;
  };
  diag_log text format["flushing %1",__FILE__];
  execVM "salaries.sqf";
};

if (isciv) then {
  // Civ Income
  while {_loopcount <= 20} do {
    _loopcount = _loopcount + 1;
    sleep 60;
    player groupChat format[localize "STRS_cash_countdown", "2"];
    sleep 60;
    player groupChat format[localize "STRS_cash_countdown", "1"];
    sleep 60;

    if ((alive player) and (deadcam == 0)) then {
      _workplacepaycheck = 0;
      _uniPaycheck       = 0;
      _gangcheck         = 0;
      _unimsg            = "";
      _atworkplacemsg    = localize "STRS_cash_nowere";
      _hashideoutmsg     = "";
      _income            = add_civmoney + donatorcashbonus;
      _mygang            = "None";
      _activecount       = 0;

      for [{_i=0}, {_i < (count BuildingsOwnerArray)}, {_i=_i+1}] do {
        _workplacepaycheck = _workplacepaycheck + ( round( (random 2)*((BuyAbleBuildingsArray select _i) select 4) ) );
      };
      _income = _income + (_workplacepaycheck/2.5);

      if (timeinworkplace > 0) then {
        _workplacepaycheck = _workplacepaycheck + (round(add_workplace/180*timeinworkplace));
        _income = _income + _workplacepaycheck;
        _atworkplacemsg   = localize "STRS_cash_were";
      };

      if (gangmember) then {
        for "_c" from 0 to (count gangsarray - 1) do {
          _gangarray = gangsarray select _c;
          _gangname  = _gangarray select 0;
          _members   = _gangarray select 1;

          if((name player) in _members)then {
            _mygang = _gangname;

            for "_i" from 0 to (count _members - 1) do {
              _civ = [(_members select _i), civarray] call INV_findunit;
              if (!isnull _civ) then {_activecount = _activecount + 1};
            };
          };
        };
      };

      if(_mygang != "None") then {
        if (gangarea1 getvariable "control" == _mygang) then {_gangcheck = _gangcheck + round (gangincome/_activecount)};
        if (gangarea2 getvariable "control" == _mygang) then {_gangcheck = _gangcheck + round (gangincome/_activecount)};
        if (gangarea3 getvariable "control" == _mygang) then {_gangcheck = _gangcheck + round (gangincome/_activecount)};
        _income = _income + _gangcheck;
      };

      timeinworkplace = 0;
      _income = round _income;

      kontostand = kontostand + _income;
      player groupChat format[localize "STRS_cash_civmoneyadd", rolestring, (_income call ISSE_str_IntToStr)];
      if (donatorcashbonus > 0) then {
        player groupChat format[localize "STRS_cash_civmoney_paycheck_donor", (add_civmoney call ISSE_str_IntToStr), (_workplacepaycheck call ISSE_str_IntToStr), (_gangcheck call ISSE_str_IntToStr), (donatorcashbonus call ISSE_str_IntToStr)];
      } else {
        player groupChat format[localize "STRS_cash_civmoney_paycheck", (add_civmoney call ISSE_str_IntToStr), (_workplacepaycheck call ISSE_str_IntToStr), (_gangcheck call ISSE_str_IntToStr)];
      };
    } else {
      // Player is dead.
      player groupChat format[localize "STRS_cash_paycheckdead"];
    };
  };
  diag_log text format["flushing %1",__FILE__];
  execVM "salaries.sqf";
};
