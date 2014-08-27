_art  = _this select 0;
_item = _this select 1;
_vcl  = vehicle player;
_type = typeof _vcl;

if (_art == "use") then {
  if (_vcl == player) exitwith { player groupchat "you must be in a vehicle" };
  if (_vcl iskindof "Motorcycle" or _type call INV_getitemTypeKg > 2) exitwith { player groupchat "you cannot tune this vehicle" };
  if (_vcl iskindof "tank" and ( _item == "supgrade2" or _item == "supgrade3" or _item == "supgrade4" or _item == "supgrade5")) exitwith {
    player groupchat "You can only tune tanks with Speed Upgrade 1.";
  };
  _installing = _vcl getvariable "installing";
  if (!isnil "_installing")exitwith{player groupchat "Already upgrading, try again in a moment."};

  [_item, -1] call INV_AddInventoreItem;
  call compile format['SFXPvEh_%1 = ["%2","tunesfx"];',rolenumber,rolestring];
  publicVariable format["SFXPvEh_%1", rolenumber];
  vehicle player say "tunesfx";
  _vcl setvariable ["installing", 1, false];
  if (_item == "supgrade1") then {player groupchat "tuning vehicle..."; _fuel = fuel _vcl; _vcl setfuel 0; sleep 6;  _vcl setfuel _fuel; _vcl setvariable ["tuning", 1, true]; player groupchat "vehicle tuned!";};
  if (_item == "supgrade2") then {player groupchat "tuning vehicle..."; _fuel = fuel _vcl; _vcl setfuel 0; sleep 7;  _vcl setfuel _fuel; _vcl setvariable ["tuning", 2, true]; player groupchat "vehicle tuned!";};
  if (_item == "supgrade3") then {player groupchat "tuning vehicle..."; _fuel = fuel _vcl; _vcl setfuel 0; sleep 8;  _vcl setfuel _fuel; _vcl setvariable ["tuning", 3, true]; player groupchat "vehicle tuned!";};
  if (_item == "supgrade4") then {player groupchat "tuning vehicle..."; _fuel = fuel _vcl; _vcl setfuel 0; sleep 9;  _vcl setfuel _fuel; _vcl setvariable ["tuning", 4, true]; player groupchat "vehicle tuned!";};
  if (_item == "supgrade5") then {player groupchat "tuning vehicle..."; _fuel = fuel _vcl; _vcl setfuel 0; sleep 10; _vcl setfuel _fuel; _vcl setvariable ["tuning", 5, true]; player groupchat "vehicle tuned!";};
  _vcl setvariable ["installing",nil, false];
};