_art = _this select 0;

if (_art == "use") then 

{

_item    = _this select 1;
_class	 = "Fort_Razorwire";


[_item, -1] call INV_AddInventoreItem;	

_pos = [(position player select 0) + (sin(getdir player)*2), (position player select 1) + (cos(getdir player)*2), 0];
_obj = _class createvehicle [0, 0, 0];
_obj setdir getdir player;
_obj setpos _pos;
_obj setDammage 1;
call compile format['_obj setvehicleinit "this setvehiclevarname ""%1%2""; %1%2 = this"; processinitcommands', player, _class];

(format ["publicarbeiterarctionarray = publicarbeiterarctionarray + [ [%1%2, %1] ];", player, _class]) call broadcast_srv;


};
