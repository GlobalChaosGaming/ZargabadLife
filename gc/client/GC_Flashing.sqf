private ["_pos","_array","_bullet"];
_bullet = _this;
_pos = getpos _bullet;
_ctime = round(time);
sleep 0.1; //allow grenade to fly a bit

[_ctime,_bullet] spawn {
	private ["_bullet","_vel","_pos","_teiler","_newbullet","_flashsfx_obj"];
	_array = [];
	_ctime = _this select 0;
	_bullet = _this select 1;
	_vel   = velocity _bullet;
	_pos   = getpos   _bullet;
	_teiler = 1;
	//create a sfx round on the same path
	_newbullet = stunfxammo createVehicle _pos;
	_newbullet setVelocity [(_vel select 0)/_teiler, (_vel select 1)/_teiler, (_vel select 2)/_teiler];
	sleep 0.5;
	//create a placeholder for the sfx after it travels a bit
	_flashsfx_obj = "HeliHEmpty" createVehicle (getpos _newbullet);
	_flashsfx_obj setpos [(getpos _newbullet select 0),(getpos _newbullet select 1),-1];
	call compile format ['_flashsfx_obj setvehicleinit "flashsfx_obj_%1_%2 = this;this setVehicleVarName ""flashsfx_obj_%1_%2"";"',player,_ctime];
	processInitCommands;
	sleep 0.5;
	//play the sound (for everyone...)
	call compile format['SFXPvEh_%1 = ["%2","flashbangsfx"];',rolenumber,_flashsfx_obj]; //can i attach the sfx source to the grenade?
	publicVariable format["SFXPvEh_%1", rolenumber];
	_flashsfx_obj say ["flashbangsfx",50];
	deletevehicle _newbullet;
	//set everyone flashed that is 25m from the "final spot"
	{
		if (isPlayer _x and alive _x) then { 
			_x setVariable ["flashed",true, true];
			_array set [count _array,_x];			
		};
	} foreach nearestObjects [_flashsfx_obj, ["Man"], 25];	
	//make sure the client loop detects a flashbang
	sleep 3;
	{
		_x setVariable ["flashed",false, true];
		_array = _array - [_x];	
	} foreach _array;	
};

//delete the grenade before it actually explodes
deletevehicle _bullet;

//wait for ringing to stop
sleep 12;
call compile format['deletevehicle flashsfx_obj_%1_%2;',player,_ctime];
