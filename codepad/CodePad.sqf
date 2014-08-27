private ["_code", "_OnTrue", "_OnFalse", "_CodeArea", "_Paper", "_ledGreen", "_ledRed", "_rightCode", "_CodeNumbers", "_CodeString"];
//Codepad script by Wolfrug @ OFPEC.com. Based on dialog based on Blanco's Code Pad script for OFP, all credit to him!.
//Usage: handler = [[1,2,3], {hint "On success"}, {hint "On fail"}] execvm "CodePad.sqf"
//Or: unit1 addAction ["Code pad", "CodePad.sqf", [[1,2,3], {hint "on Success"}, {hint "On fail"}]];
//[1,2,3] = array of numbers that need to be entered in the correct order.
//{hint "On success"} = code run if the right code is entered.
//{hint "On fail"} = code run if the wrong code is entered.
//Remember to #include "CodePad.h" and "CodePadSounds.h" into your description.ext!
//RUG_CodePad_KnownCodes = [RandomCodeString];
//hint format ["%1", RandomCodeString];
// Grabs the code arrays and the OnTrue, OnFalse codes

_CodeArray = _this select 0;
_OnTrue = _this select 1;
_OnFalse = _this select 2;

// In case of code being called via action, grab the data from the appropriate place.
if (count _this > 3) then {_CodeArray = (_this select 3) select 0; _OnTrue = (_this select 3) select 1; _OnFalse = (_this select 3) select 2};
keypad_num = 0;
_ok = createDialog "RUG_Codepad";
if (!_ok) exitWith {Player groupChat "Codepad dialog error!"};

// Some dialog IDCs
_CodeArea = 999;
_Paper = 599;
_ledGreen = 598;
_ledRed = 597;
_rightCode = 600;

// Makes certain controls invisible by default
{ctrlShow [_x, false]} forEach [_Paper, _ledGreen, _ledRed, _rightCode];

_CodeNumbers = count _CodeArray;
_CodeString = "";
for "_i" from 0 to (_CodeNumbers - 1) do {_CodeString = _CodeString + (format ["%1",(_CodeArray select _i)])};

// Main loop that runs while the codepad is visible. Will spawn _OnTrue at correct code, _OnFalse if wrong. Note: _this select 0 for both _OnTrue and _OnFalse scripts will be the code string!
while {ctrlVisible _CodeArea} do
{
	waitUntil {!ctrlVisible _CodeArea || ctrlText _CodeArea == _CodeString || keypad_num >= _CodeNumbers};
	if (!ctrlVisible _CodeArea) exitWith {};
	if (ctrlText _CodeArea == _CodeString) then {
		ctrlShow [_ledGreen, true];
		_n=[_CodeString] spawn _OnTrue;
		sleep 1;
		ctrlSetText [_CodeArea, ""];
		keypad_num = 0;
		closedialog 0;
	} else {
	if (keypad_num >= _CodeNumbers) then {
			ctrlShow [_ledRed, true];
			ctrlShow [_ledGreen, false];
			_n = [_CodeString] spawn _OnFalse;
			sleep 1;
			ctrlShow [_ledRed, false];
			ctrlSetText [_CodeArea, ""];
			keypad_num = 0;
			closedialog 0;
		};
	};
};
keypad_num = 0;