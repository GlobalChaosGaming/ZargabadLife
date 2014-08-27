private ["_i","_LastVehicles","_loopcount","_LastInventarArray","_LastKontostand","_LastKillsCop","_LastKillsCiv","_LastKillsSelf","_LastWanted","_arrest","_wanted","_reasons","_bounty","_weapons","_weaponsstr","_weaponsstr2","_mags","_magsstr","_magsstr2"];
_LastVehicles =  format["%1",INV_VehicleArray];
_LastInventarArray =  format["%1",INV];
_LastWanted = format["%1",GC_Wanted];
_LastKontostand = Kontostand;
_LastKillsSelf = SelfKilled;
_LastKillsCop = CopsKilled;
_LastKillsCiv = CivsKilled;
_LastBusts = CivsBusted;
_LastRewards = RewardsCollected;
_LastBailPaid = BailPaid;
_loopcount = 0;
while {_loopcount <= 720} do {
	_loopcount = _loopcount + 1;
	
	if (alive player) then {
		//vehicle save
		for [{_i=0}, {_i < (count INV_VehicleArray)}, {_i=_i+1}]do{if (isNull (INV_VehicleArray select _i))then{INV_VehicleArray set [_i, ""];INV_VehicleArray = INV_VehicleArray - [""];};};

		if (_LastVehicles != format["%1", INV_VehicleArray]) then {	
			_LastVehicles = format["%1", INV_VehicleArray];
			["INV_VehicleArray", INV_VehicleArray] call ClientSaveVar;
		};

		//inventory save
		for [{_i=0}, {_i < (count INV)}, {_i=_i+1}]do{
			if (count (INV select _i) < 2)then{
				INV set [_i, ""];
				INV = INV - [""];
			} else {
				_itemarr = INV select _i;
				_item = _itemarr select 0;
				_qty = _itemarr select 1;
				if (_qty <= 0) then {
					INV set [_i, ""];
					INV = INV - [""];				
				};
			};
		};
		if (_LastInventarArray != format["%1",INV]) then {
			_LastInventarArray = format["%1",INV];
			["INV", INV] call ClientSaveVar; 
		};

		//storage save (only if changed)
		_storagechanged = false;
		for [{_i=0}, {_i < (count private_storage)}, {_i=_i+1}]do{
			if (count (private_storage select _i) < 2)then{
				private_storage set [_i, ""];
				private_storage = private_storage - [""];
				_storagechanged = true;
			} else {
				_itemarr = private_storage select _i;
				_item = _itemarr select 0;
				_qty = _itemarr select 1;
				if (_qty <= 0) then {
					private_storage set [_i, ""];
					private_storage = private_storage - [""];
					_storagechanged = true;
				};
			};
		};
		if (_storagechanged) then {["private_storage", private_storage] call ClientSaveVar;};

		//bank save
		if (_LastKontostand != Kontostand) then {["Kontostand", Kontostand] call ClientSaveVar;_LastKontostand = Kontostand;};

		//kill counter saves
		if (CopsKilled != _LastKillsCop) then {["CopsKilled", CopsKilled] call ClientSaveVar; _LastKillsCop = CopsKilled;};
		if (CivsKilled != _LastKillsCiv) then {["CivsKilled", CivsKilled] call ClientSaveVar; _LastKillsCiv = CivsKilled;};
		if (SelfKilled != _LastKillsSelf) then {["SelfKilled", SelfKilled] call ClientSaveVar; _LastKillsSelf = SelfKilled;};	
		if (CivsBusted != _LastBusts) then {["Busts", CivsBusted] call ClientSaveVar; _LastBusts = CivsBusted;};	
		if (RewardsCollected != _LastRewards) then {["Rewards", RewardsCollected] call ClientSaveVar; _LastRewards = RewardsCollected;};	
		if (BailPaid != _LastBailPaid) then {["Bail", BailPaid] call ClientSaveVar; _LastBailPaid = BailPaid;};	

		//weapons and mags, wanted
		if(weaponsloaded and local_arrest != 1)then {
			if (isciv) then {
				_arrest = 0;
				_wanted = 0;
				_reasons = [];
				_bounty = 0;
				call compile format ['
					if(!isnil "kopfcash_civ%1")then{_bounty = kopfcash_civ%1};
					if(!isnil "civ%1_arrest")then{_arrest = civ%1_arrest};
					if(!isnil "civ%1_wanted")then{_wanted = civ%1_wanted};
					if(!isnil "civ%1_reason")then{_reasons = civ%1_reason};
				', rolenumber];		
				GC_Wanted = [[_arrest,_wanted,_reasons,_bounty]];
				if (format["%1",GC_Wanted] != _LastWanted) then {
					["GC_Wanted", GC_Wanted] call ClientSaveVar; 
					_LastWanted = format["%1",GC_Wanted];
				};	
			};
			_weapons = (weapons player) - nonlethalweapons;
			_weaponsstr = format["%1",_weapons];
			_weaponsstr2 =  format["%1",playerweapons];
			if (_weaponsstr != _weaponsstr2) then {
					playerweapons = _weapons;
					["playerweapons", playerweapons] call ClientSaveVar;
			};
			_mags	 = magazines player;
			_magsstr = format["%1",_mags];
			_magsstr2 =  format["%1",playermagazines];
			if (_magsstr != _magsstr2) then {
					playermagazines = _mags;
					["playermagazines", playermagazines] call ClientSaveVar;
			};

			//holster actions
			_weapons call GC_PistolActions;
		};
	};
	sleep 5;
};
diag_log text format["flushing %1",__FILE__];
execVM "gc\client\GC_Save.sqf";