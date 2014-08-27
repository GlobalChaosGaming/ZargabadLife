_art  = _this select 2;
_cash = 'cash' call INV_GetItemAmount;

GC_wireMoneySFX = {
	_sfx = _this select 0;
	if(_sfx == "add") then {
		call compile format['SFXPvEh_%1 = ["%2","acctmoresfx"];',rolenumber,rolestring];
 		publicvariable format["SFXPvEh_%1",rolenumber];
 		vehicle player say "acctmoresfx";
 	};
 	if(_sfx == "remove") then {
		call compile format['SFXPvEh_%1 = ["%2","acctlesssfx"];',rolenumber,rolestring];
 		publicvariable format["SFXPvEh_%1",rolenumber];
 		vehicle player say "acctlesssfx";
 	};
};

if(_art == "deposit") then {
	if(atmscriptrunning == 1) exitwith {player groupchat "script already running"};
	atmscriptrunning = 1;
	_transfer = _this select 0;
	_transfermoney = _this select 1;
	if(!(_transfermoney call ISSE_str_isInteger)) exitwith {player groupChat localize "STRS_bank_no_valid_number";};
	_transfermoney = _transfermoney call ISSE_str_StrToInt;
	if(_transfermoney <= 0) exitwith {};
	_steuern = round((_transfermoney*100)/(100-bank_steuer));
	_targetString = INV_PLAYERLIST select _transfer;
	if(INV_PLAYERLIST select _transfer == player) exitwith {
		if(_cash < _transfermoney) then {
			player groupchat format[localize "STRS_bank_deposit_self_no",(_transfermoney call ISSE_str_IntToStr)];
		} else {
			player groupchat format[localize "STRS_bank_deposit_self_yes",(_transfermoney call ISSE_str_IntToStr)];
			Kontostand = Kontostand + _transfermoney;
			['cash', -(_transfermoney)] call INV_AddInventoreItem;
		};
	};

	if(!((format["%1", (INV_PLAYERLIST select _transfer)]) call ISSE_UnitExists)) exitwith {player groupchat localize "STRS_bank_player_not_ingame";};

	if(Kontostand < _steuern) then {
		player groupchat format[localize "STRS_bank_no_money",(_transfermoney call ISSE_str_IntToStr),(bank_steuer call ISSE_str_IntToStr)];
	} else {
		Kontostand = Kontostand - _steuern;
		["remove"] call GC_wireMoneySFX;
		INV_SteuernGezahlt = (INV_SteuernGezahlt + (_steuern - _transfermoney));
		(format ["
		if(INV_ROLESTRING == ""%1"") then {
			Kontostand = Kontostand + %2;
			player groupchat format[localize ""STRS_bank_account_getmoney"",%2,%3];
			[""add""] call GC_wireMoneySFX;
		};", _targetString,(_transfermoney call ISSE_str_IntToStr),player]) call broadcast;
		player groupchat format[localize "STRS_bank_deposit_yes",(_transfermoney call ISSE_str_IntToStr),(bank_steuer call ISSE_str_IntToStr),(_steuern call ISSE_str_IntToStr)];
	};
};

if(_art == "withdraw") then {
	if(atmscriptrunning == 1) exitwith {player groupchat "script already running"};
	atmscriptrunning = 1;
	_withdraw = _this select 0;
	if(!(_withdraw call ISSE_str_isInteger)) exitwith {player groupchat localize "STRS_bank_no_valid_number";};
	_withdraw = _withdraw call ISSE_str_StrToInt;
	if(_withdraw <= 0) exitwith {};

	if(Kontostand >= _withdraw) then {
		Kontostand = Kontostand - _withdraw;
		['cash', (_withdraw)] call INV_AddInventoreItem;
		player groupchat format[localize "STRS_bank_withdraw_yes",(_withdraw call ISSE_str_IntToStr)];
	} else {
		player groupchat localize "STRS_bank_no_money";
	};
};
sleep 2;
atmscriptrunning = 0;