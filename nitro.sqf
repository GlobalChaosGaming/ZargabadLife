_art = _this select 0;

if (_art == "use") then

{

_item   = _this select 1;
_vcl  	= vehicle player;
_type	= typeof _vcl;

if(_vcl getvariable "nitro" == 1)exitwith{player groupchat "This vehicle already has nitro installed."};
if (player == _vcl) exitWith {player groupChat localize "STRS_inv_items_speed_car"};
if (!(_vcl iskindof "car") or _type call INV_getitemTypeKg > 2) exitWith {player groupChat localize "STRS_inv_items_speed_no";};
_installing = _vcl getvariable "installing";
if (!isnil "_installing")exitwith{player groupchat "Already upgrading, try again in a moment."};

[_item, -1] call INV_AddInventoreItem;
player groupchat "Tuning vehicle...";
call compile format['SFXPvEh_%1 = ["%2","tunesfx"];',rolenumber,rolestring];
publicVariable format["SFXPvEh_%1", rolenumber];
vehicle player say "tunesfx";
_vcl setvariable ["installing", 1, false];
_fuel = fuel _vcl;
_vcl setfuel 0;
sleep 10;
_vcl setfuel _fuel;
_vcl setvariable ["nitro", 1, true];
player groupchat "Vehicle tuned!";
sleep 2;
player groupchat "Press and hold SHIFT to activate nitro.";
_vcl setvariable ["installing", nil, false];
};



