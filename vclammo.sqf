_vcl = vehicle player;
_item = _this select 1;
_inInv = format["%1", _item] call INV_GetItemAmount;

if (_vcl != player) then {

  if (_inInv > 0) then {

    _turret = (assignedVehicleRole player) select 1;

    if ((count (_vcl magazinesTurret _turret)) > 1) then {
      _i = 0;
      {
        if (!(createDialog "ja_nein")) exitWith {hint "Dialog Error!"};

        ctrlSetText [1, format["Do you want to rearm the %1?", _x]];

        waitUntil{(not(ctrlVisible 1023))};

        if (Antwort == 1) exitWith {
          _ammo = (_vcl magazinesTurret _turret) select _i;
          if (!isNil "_ammo") then {
            _vcl addMagazineTurret [_ammo, _turret];
            player groupChat localize "STRS_inv_item_vclammo_rearmed";
            [_item, -1] call INV_AddInventoreItem;
          };
        };
        _i = _i + 1;
      } forEach ((vehicle player) weaponsTurret ((assignedVehicleRole player) select 1));
    } else {

      _ammo = (_vcl magazinesTurret _turret) select 0;

      if (!isNil "_ammo") then {

          _vcl addMagazineTurret [_ammo, _turret];
        player groupChat localize "STRS_inv_item_vclammo_rearmed";
        [_item, -1] call INV_AddInventoreItem;

      } else {
        player groupChat localize "STRS_inv_item_vclammo_nomg";
      };
    };

  } else {
    player groupChat "You do not have any ammo remaining";
  };

} else {
  player groupChat localize "STRS_inv_item_vclammo_novehicle";
};
