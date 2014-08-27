private ["_ui","_uiradar","_wantedList","_searchRadius","_control2","_car","_tag","_vcls","_distTP","_distCP","_playerIsWanted","_hasradar","_digits","_target","_radardigits","_radartarget","_bounty","_starCount","_text","_stars","_wanted","_i","_control","_atm","_hidden","_range","_dirV","_pos","_posFind","_objs","_atms","_loopcount"];
disableSerialization;

format_integer = {
	private["_value", "_nan", "_separator"];
	_nan = "NotANumber"; 
	_value = _this select 0;
	_separator = _this select 1;
	
	if (isNil "_value") exitWith {_nan};
	if (typeName _value != "SCALAR") exitWith {_nan};
	
	if (_value == 0) exitWith {"0"};
	
	private["_string_value", "_digits", "_remainder", "_sign"];
	_string_value = "";
	_digits = 0;
	_sign = if (_value < 0) then {"-"} else {""};
	_value = abs(round(_value));
	while { _value >= 1 } do {
		_digits = _digits + 1;
		if ( _digits > 1 && ((_digits - 1) % 3) == 0) then {
			_string_value = _separator + _string_value;
		};
		_remainder = _value % 10;
		_string_value = str(_remainder) + _string_value;
		_value = floor(_value / 10);
	};
	
	_sign+_string_value
};

_wantedCount = 0;
_loopcount = 0;


5 cutRsc ["GCHUD_Status", "PLAIN"];
_ui = uiNameSpace getVariable "GCHUD_Status";
_starsui = _ui displayCtrl 63302; _starsui ctrlShow false;			
_wtextui = _ui displayCtrl 63303; _wtextui ctrlShow false;
_healthui = _ui displayCtrl 63307; _healthui ctrlShow false;
_armorui = _ui displayCtrl 63308; _armorui ctrlShow false;
_cashui = _ui displayCtrl 63309; _cashui ctrlShow false;		
_wantedui = _ui displayCtrl 63310; _wantedui ctrlShow false;
_Status_Hud = false;

while {_loopcount <= 14400} do {
	_loopcount = _loopcount + 1;
	if (alive player and isdead == 0 and deadcam == 0) then {
		  if (isCop) then {
		    if (player == driver vehicle player) then {
			_hasradar = vehicle player getvariable "radar";
			if (isNil "_hasradar") then {
				_hasradar = 0;
			};
			if (_hasradar == 1) then {
				4 cutRsc ["GCHUD_CopRadar", "PLAIN"];
				_digits = vehicle player getvariable "radardigits";
				if (isNil "_digits") then {
					_digits = "<img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/> <img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/> <img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/>";
				};
				_target = vehicle player getvariable "radartarget";
				if (isNil "_target") then {
					_target = " ";
				};
				_uiradar = uiNameSpace getVariable "GCHUD_CopRadar";
				_radardigits = _uiradar displayCtrl 63305;
				_radartarget = _uiradar displayCtrl 63306;
				_radardigits ctrlSetStructuredText parseText _digits;
				_radartarget ctrlSetStructuredText parseText _target;
			};

		    };

		  } else {

		    _playerIsWanted = call compile format ["%1_wanted", player];

		    if (_playerIsWanted == 1) then {
		      _bounty = call compile format ["kopfcash_%1", player];

		      _starCount = switch (true) do {
			case (_bounty >= 200000) : { 5 };
			case (_bounty >= 150000) : { 4 };
			case (_bounty >= 100000) : { 3 };
			case (_bounty >= 50000) : { 2 };
			default { 1 };
		      };

		      _text = [];
		      for "_i" from 0 to (_starCount - 1) do {
			_text set [_i, "<img size='.5' image='images\wanted_star.paa'/>"];
		      };

		      _wtextui ctrlSetText "W A N T E D";
		      _starsui ctrlSetStructuredText parseText format["<t align='center'>%1</t>", _text call ISSE_str_ArrToStr];
		    } else {
		      _wtextui ctrlSetText "";
		      _starsui ctrlSetStructuredText parseText "";
		    };
		  };

			
			_health = round((1 - damage player) * 100);
			_armor = player getvariable "bodyarmorhits";
			_armorstr = "";
			_light = 'LightArmor' call INV_GetItemAmount;
			_heavy = 'HeavyArmor' call INV_GetItemAmount;
			_mask = 'GasMask' call INV_GetItemAmount;
			_typestr = "No Armor";
			_maskstr = "";
			if (_light >= 1) then {
				_typestr = "Light Armor";
			};			
			if (_heavy >= 1) then {
				_typestr = "Heavy Armor";
			};			
			if (_heavy >= 1 or _light >= 1) then {
				if (isnil "_armor") then {
					_armorstr = format["<img size='1' image='images\armor_full.paa'/><t size='0.1'> </t><t shadow='1' shadowColor='#cc0000' font='Zeppelin33' align='left' size='0.8' valign='middle'>%1</t>",_typestr];
				} else {
					if (_armor <= 4) then {
						_armorstr = format["<img size='1' image='images\armor_full.paa'/><t size='0.1'> </t><t shadow='1' shadowColor='#cc0000' font='Zeppelin33' align='left' size='0.8' valign='middle'>%1</t>",_typestr];
					} else {
						if (_armor > 4) then {
							_armorstr = format["<img size='1' image='images\armor_half.paa'/><t size='0.1'> </t><t shadow='1' shadowColor='#cc0000' font='Zeppelin33' align='left' size='0.8' valign='middle'>%1</t>",_typestr];
						};
						if (_armor >= 7) then {
							_armorstr = format["<img size='1' image='images\armor_one.paa'/><t size='0.1'> </t><t shadow='1' shadowColor='#cc0000' font='Zeppelin33' align='left' size='0.8' valign='middle'>%1</t>",_typestr];
						};						
					};
				};
			} else {
				_armorstr = "<img size='1' image='images\armor_none.paa'/><t size='0.1'> </t><t shadow='1' shadowColor='#cc0000' font='Zeppelin33' align='left' size='0.8' valign='middle'>No Armor</t>";
			};
			if (_mask >= 1) then {
				_maskstr = "<img size='1' image='images\gasmask.paa'/>";
				_armorstr = _maskstr + _armorstr;
			};			
			_cash = 'cash' call INV_GetItemAmount;
			_healthui ctrlSetStructuredText parseText format["<img size='1' image='images\health.paa'/><t shadow='1' shadowColor='#cc0000' font='Zeppelin33' align='left' size='0.8' valign='middle'>%1%2</t>",_health,"%"];
			_armorui ctrlSetStructuredText parseText _armorstr;
			_cashui ctrlSetStructuredText parseText format["<img size='1' image='images\dollarsign.paa'/><t shadow='1' shadowColor='#cc0000' font='Zeppelin33' align='left' size='0.8' valign='middle'>%1</t>",[_cash,","] call format_integer];

			if (iscop) then {
				_unsorted = [];
				{
					if (side _x == civilian or side _x == east) then {
						_iswanted = call compile format ["%1_wanted", _x];
						_bounty = call compile format ["kopfcash_%1", _x];
						if (_iswanted == 1) then {
							_arr = [(round(_bounty / 1000) * -1),name _x];
							_unsorted = _unsorted + [_arr];
						};
					};
				} foreach playableunits;
				_sorted = [_unsorted,0] call CBA_fnc_sortNestedArray;
				_mwdata = "";
				{
					_mybounty = _x select 0;
					_spacer = " ";
					if (_mybounty < 1000) then {
						_spacer = "<t size='0.2'> </t>";
					};
					if (_mybounty < 100) then {
						_spacer = " <t size='0.1'> </t>";
					};					
					if (_mybounty < 10) then {
						_spacer = "  <t size='0.1'> </t>";
					};
					_mwdata = _mwdata + format["$%1K:%3%2<br/>",abs(_mybounty),_x select 1,_spacer];
				} foreach _sorted;
				_mwlist = format["<t shadow='1' shadowColor='#000000' font='EtelkaMonospaceProBold' size='0.6' valign='middle'>%1</t>",_mwdata];			
				_mw = "";
				if (count _sorted > 0) then {
					_mw = "<t size='0.1'>                      </t><img size='1' image='images\wanted_star.paa'/><t size='0.1'> </t><t shadow='1' underline='true' shadowColor='#cc0000' font='Zeppelin33' size='0.78' valign='middle'>Most Wanted</t><br/>" + _mwlist;
				};
				_wantedui ctrlSetStructuredText parseText _mw;
			};
			if (!_Status_Hud) then {
				_healthui ctrlShow true;	
				_armorui ctrlShow true;	
				_cashui ctrlShow true;
				_wantedui ctrlShow true;
				_wtextui ctrlShow true;
				_starsui ctrlShow true;
				_Status_Hud = true;
			};

			//display weight ??


		  for [{_i=1}, {_i < 25}, {_i=_i+2}] do {
		    _range   = _i;
		    _dirV    = vectorDir vehicle player;
		    _pos     = player modelToWorld [0,0,0];
		    _posFind = [(_pos select 0)+(_dirV select 0)*_range, (_pos select 1)+(_dirV select 1)*_range, (_pos select 2)+(_dirV select 2)*_range];

		    if (vehicle player == player) then {_searchRadius = 1} else {_searchRadius = 0};

		    _objs = nearestObjects [_posFind,["Man", "Misc_cargo_cont_tiny", "RUBasicAmmunitionBox","UNBasicAmmunitionBox_EP1"], _searchRadius];
		    _vcls = nearestobjects [_posFind,["LandVehicle", "Air", "ship", "LocalBasicWeaponsBox","Tank"], 4];
		    _atms = nearestObjects [_posFind,["Man", "Misc_cargo_cont_tiny"], 2];

		    if (count _vcls > 0 and INV_shortcuts) then {
		      _car    = _vcls select 0;
		      _distCP = (_car distance player);

		      if (typeof _car != "LocalBasicWeaponsBox" and !(isnull _car) and alive _car and !(locked _car) and vehicle player == player and _distCP <= 4) then {
			titleRsc["Rtags", "PLAIN"];
			_control = (uiNamespace getVariable 'TAGS_HUD') displayCtrl 64438;
			_control ctrlSetText "Enter (E)";
		      };

		      if ((_car in INV_VehicleArray) and typeof _car == "LocalBasicWeaponsBox" and !(isnull _car) and vehicle player == player and _distCP <= 3) then {
			titleRsc["Rtags", "PLAIN"];
			_control = (uiNamespace getVariable 'TAGS_HUD') displayCtrl 64438;
			_control ctrlSetText "Trunk (T)";
		      };
		    };

		    if (count _atms > 0 and INV_shortcuts) then {
		      _atm = _atms select 0;
		      _distTP = (_atm distance player);

		      if (_atm in bankflagarray and _distTP < 3) then {
			titleRsc["Rtags", "PLAIN"];
			_control = (uiNamespace getVariable 'TAGS_HUD') displayCtrl 64438;
			_control ctrlSetText "ATM (E)";
		      };
		    };

		    if (count _objs > 0 and INV_shortcuts) then {
		      _tag = _objs select 0;
		      _distTP = (_tag distance player);

		// Shops
		if (_tag in shopusearray and _distTP < 3) then {
			_text = (_tag call INV_getshopArray) select 1;
			titleRsc["Rtags", "PLAIN"];
			_control = (uiNamespace getVariable 'TAGS_HUD') displayCtrl 64438;
			if (iscop and _tag in drugsellarray) exitwith {
			  _control ctrlSetText "Drug Search (E)";
			  _control ctrlSetTextColor [0, 0, 1, 0.8];
			};
			_control ctrlSetText format["%1 (E)", _text];
			_control ctrlSetTextColor [1, 1, 1, 0.8];
		};

		// Players
		if (_tag != player and _tag in playerarray and alive _tag) then {
			_hidden = _tag getVariable "hidden";
			if (isNil "_hidden") then {
				3 cutRsc["Rtags", "PLAIN"];
				_control2 = (uiNamespace getVariable 'TAGS_HUD') displayCtrl 64437;
				_control2 ctrlSetText format ["%1 (%2)", _tag, (name _tag)];
				_control2 ctrlSetFontHeight (0.04 - (_i*0.001));

				if (_tag in coparray) then {
				  // Blue - Player is a police officer;
				  _control2 ctrlSetTextColor [0, 0, 1, 0.8];
				};

				if (_tag in civarray) then {
				  if ((call compile format ["%1_wanted;", _tag]) == 1) then {
				    // Red - Player is wanted;
				    _control2 ctrlSetTextColor [1, 0, 0, 0.8];
				  } else {
				    // Yellow - Player not wanted;
				    _control2 ctrlSetTextColor [1, 1, 0, 0.8];
				  };
				  
				  //always show gang members green
				  if (_tag in (units group player)) then {
				  	_control2 ctrlSetTextColor [0, 1, 0, 0.8];
				  };
				};
			};
		};

		      if (_distTP < 3 and _tag in civarray and _tag != player and alive _tag) then {
			titleRsc["Rtags", "PLAIN"];
			_control = (uiNamespace getVariable 'TAGS_HUD') displayCtrl 64438;
			_control ctrlSetText "Search (E)";
		      };
		    };
		  };
	} else {
		_healthui ctrlShow false;	
		_armorui ctrlShow false;	
		_cashui ctrlShow false;	
		_wantedui ctrlShow false;	
		_Status_Hud = false;
		waituntil{sleep 1; (alive player and isdead == 0)};
	};
  sleep 0.25;
};
diag_log text format["flushing %1",__FILE__];
[] spawn GC_HUD;