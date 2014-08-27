_unit = _this select 0;
_animArray = _this select 1;
_random = false;
if (count _this > 2) then {_random = _this select 2;};

_unit switchMove (_animArray select 0);

while {alive _unit} do
{
	if (_random) then
	{
		_i = floor (random (count _animArray));
		_anim = _animArray select _i;
		_unit playMove (_anim);
		waitUntil {animationState _unit != _anim};
	}
	else
	{
		{
			_unit playMove _x;
			player groupChat format["%1",_unit];
			waitUntil {animationState _unit != _x};
		} forEach _animArray;
	};
	sleep 1;
};