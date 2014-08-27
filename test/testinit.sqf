gc_assert_equal = {
  _expected = _this select 0;
  _actual = _this select 1;
  _message = _this select 2;

  if !(_expected == _actual) then {
    player commandChat _message;
  };
};

if (testMode and local server and local player) then {
  _tests = [
    "test\gc\global\FNC_Loading_test.sqf"
  ];

  {
    _output = format["Running: %1", _x];
    player sideChat _output;
    _runner = execVM _x;
    waitUntil { scriptDone _runner};
  } forEach _tests;
};