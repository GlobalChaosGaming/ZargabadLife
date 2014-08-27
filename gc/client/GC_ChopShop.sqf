private["_vcl","_horn","_tune","_nitro","_carwep","_caralarm","_payout","_lowpay","_medpay","_highpay","_dshkm"];
player groupchat "Please get back into your vehicle to strip it. You have 10 seconds!";
sleep 10;
_vcl = vehicle player;
if(player == _vcl) exitwith {player groupchat "You have must be in a vehicle to use this shop!";};

_horn = _vcl getvariable "customhorn";
_tune = _vcl getvariable "tuning";
_nitro = _vcl getvariable "nitro";
_carwep = _vcl getvariable "carwep";
_caralarm = _vcl getvariable "caralarm";

_payout = 0;
_lowpay = floor(random(10)*150);
_medpay = floor(random(20)*200);
_highpay = floor(random(25)*250);

player groupchat "Stripping car of nice things!";

call compile format['SFXPvEh_%1 = ["%2","tunesfx"];',rolenumber,rolestring];
publicvariable format["SFXPvEh_%1",rolenumber];
vehicle player say "tunesfx";

if(!isnil _horn) then {_payout = _payout + _lowpay;_vcl setvariable["customhorn",nil,true];};
if(_tune == 1) then {
	switch (_tune) do {
		case "1": {_payout = _payout + _lowpay;_vcl setvariable["tuning",0,true];};
		case "2": {_payout = _payout + _medpay;_vcl setvariable["tuning",0,true];};
		case "3": {_payout = _payout + _highpay;_vcl setvariable["tuning",0,true];};
	};
};
if(_nitro == 1) then {_payout = _payout + _lowpay;_vcl setvariable["nitro",0,true];};
if(_carwep == 1) then {
	_payout = _payout + _highpay;
	_vcl setvariable["carwep",0,true];
	_dshkm = nearestobject [_vcl,"DSHkM_Mini_TriPod_TK_GUE_EP1"];
	deletevehicle _dshkm;
};
if(_caralarm == 1) then {_payout = _payout + _medpay;_vcl setvariable["caralarm",0,true];};

player groupchat format["You made $%1 from the car parts!",_payout];
['cash',_payout] call INV_AddInventoreItem;