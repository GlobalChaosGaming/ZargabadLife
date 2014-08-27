//ImagoTrigger <imagotrigger@gmail.com> for Chaos Life
if (isServer) then {
	GC_ServerFunc = compile preprocessFileLineNumbers "servermissionfile\GC_serverFunctions.sqf";
} else {

	_carshop3bldg = "Land_HouseBlock_A1_1" createVehicleLocal (getPosATL carshop3bldg);
	_carshop3bldg setPosATL (getPosATL carshop3bldg);
	_carshop3bldg setDir (getDir carshop3bldg);
	_carshop3bldg allowdamage false;

	_mosquelight = "#lightpoint" createVehicleLocal getpos mosquelights;
	_mosquelight lightAttachObject [mosquelights, [0,0,0.1]];
	_mosquelight setLightBrightness 0.1;
	_mosquelight setLightAmbient    [0.6,0.7,0.85];
	_mosquelight setLightColor [0.6,0.7,0.85];
};

_buildpos = [
	[3944.23,2771.06,11.0973],
	[3538.3,3022.04,12.1633],
	[3551.47,3039.53,12.3319],
	[3986.84,3176.9,17.0647],
	[4535.54,3304.47,13.6969],
	[4528.97,3315.93,13.9438],
	[4461.78,3424.83,16.8868],
	[4464.88,3438.32,17.0011],
	[4452.5,3449.67,17.3149],
	[4412.86,3514.77,17.398],
	[4379.78,3583.98,17.5678],
	[4029.84,3592.48,25.3985],
	[4377.9,3602.21,17.4875],
	[4076.79,3623.65,24.8838],
	[4014.56,3663.41,22.5014],
	[4001.59,3684.65,21.7959],
	[3977.94,3674.19,21.4991],
	[4272.59,3833.54,17.2389],
	[3954.13,3831.72,16.9364],
	[4229.56,3886.09,17.2758],
	[3970.37,3926.06,16.9613],
	[4218.68,3953.62,17.9183],
	[4003.21,3971.49,16.1914],
	[4195.91,3981.75,17.485],
	[4209.43,3978.27,17.7257],
	[4189.98,4019.99,17.7336],
	[4015.15,4057.11,16.6084],
	[4049.22,4058.61,16.8522],
	[3564.06,4126.59,22.3138],
	[4073.53,4102.66,16.2713],
	[4245.73,4106.32,17.163],
	[3898.79,4157.3,15.2732],
	[4092.7,4133.91,16.4212],
	[4115.96,4133.92,16.9097],
	[4204.59,4157.98,16.6748],
	[4227.86,4143.9,16.5065],
	[4240.64,4158.61,17.0001],
	[4252.62,4142.72,16.3864],
	[4308.71,4147.47,17.5213],
	[4214.43,4183.07,16.6748],
	[4240.8,4172.19,17],
	[4277.26,4159.31,16.6748],
	[4308,4172.95,17.4766],
	[3951.48,4236.24,15.8146],
	[3964.23,4244.65,15.9003],
	[3757.05,4289.3,14.655],
	[4909.53,4619.37,39.1523],
	[4932.92,4610.18,39.0814],
	[4126.75,4719.55,15.0919],
	[2951.14,4812.07,27.4551],
	[3711.34,5088.49,33.7453],
	[4269.84,4192.72,17.3506],
	[4265.19,4193.15,18.1861],
	[4253.15,4193.36,18.177],
	[4249.21,4193.42,17.4911],
	[4279.57,4189.58,18.201],
	[4278.69,4178.33,18.1011],
	[4222.5,4193.37,17.1254],
	[4276.14,4123.32,17.9006],
	[4279.36,4128.17,18.2003],
	[4278.57,4123.96,17.6129],
	[4266.62,4124.56,18.0187],
	[4254.56,4125.02,18.2006],
	[4240.64,4123.35,17.1303],
	[4229,4124.11,17.1221],
	[4218.07,4124.51,17.1176],
	[4202.05,4123.2,17.1304],
	[4201.98,4137.33,17.1303],
	[4202.51,4177.83,18.0721],
	[3986.86,4056.84,17.7859],
	[3979.08,4062.87,17.049],
	[2702.94,5110.1,38.0594],
	[4248.37,4076.53,17.5602],
	[4278.91,4139.65,18.0722],
	[4240.66,4192.98,18.2793],
	[4228.31,4193.1,18.2075],
	[4217.07,4193.19,18.1905],
	[4205.42,4191.11,17.8472],
	[4203.01,4178.51,18.2959]
];
{nearestObject[_x,"House"] allowdamage false;} foreach _buildpos;

{
	if (!(_x in playerarray) and !((typeOf _x) in civprostitutearray)) then {
		_x setVariable ["BIS_noCoreConversations", true];
		_x setVariable ["NPC", true];
		player reveal[_x,4];
		removeBackpack _x;
		
		if (_x in sitNPCs) then {
			if (isServer) then {["seat",_x] call GC_ServerFunc;};
			_chair = getPos _x nearestObject "Land_Chair_EP1";
			_x setDir (getDir _chair);
			_x setPos (getPos _chair);
			_i = floor (random (count sitAnims));
			_anim = sitAnims select _i;
			_x switchMove _anim;
			_x disableAI "MOVE";
			_x disableAI "AUTOTARGET";
			_x disableAI "FSM";
			_x disableAI "TARGET";
			if (!isServer) then {sleep 0.02;};
			_x disableAI "ANIM";
			_x enableSimulation false;
			if (!isServer) then {
				_nolight = _x getVariable "noLight";
				if (isnil "_nolight") then {
					_light = "#lightpoint" createVehicleLocal getpos _x;
					_light lightAttachObject [_x, [0,0,-0.5]];
					_light setLightBrightness 0.08;
					_light setLightAmbient    [0.6,0.7,0.85];
					_light setLightColor [0.6,0.7,0.85];
				};
			};
		} else {
			_i = floor (random (count idleAnims));
			_anim = idleAnims select _i;
			_x switchMove _anim;
			_x disableAI "MOVE";
			_x disableAI "AUTOTARGET";
			_x disableAI "FSM";
			_x disableAI "TARGET";
			if (!isServer) then {sleep 0.02;};
			_x disableAI "ANIM";
			_x enableSimulation false;
			if (!isServer) then {
				_nolight = _x getVariable "noLight";
				if (isnil "_nolight") then {
					_light = "#lightpoint" createVehicleLocal getpos _x;
					_light lightAttachObject [_x, [0,0,-0.5]];
					_light setLightBrightness 0.08;
					_light setLightAmbient    [0.6,0.7,0.85];
					_light setLightColor [0.6,0.7,0.85];
				};
			};
		};
	};
} forEach allUnits;

if (isServer) then {
	["groups",6] call GC_ServerFunc;
};

{
  (_x select 0) setPosASL (_x select 1);
} forEach npcposASLs;
