_lotto     = (_this  select 0) call GetLottoArray;
_lottocost = (_lotto select 2);
_lottowin  = (_lotto select 3);
_chance    = (_lotto select 4);
_winner    = random 100;
_cash      = 'cash' call INV_GetItemAmount;

if (playing_lotto == 1) exitWith {player groupChat "You can only buy one ticket at a time.";};
if (_cash < _lottocost) exitWith {role groupChat localize "STRS_lotto_nomoney";};
['cash', -(_lottocost)] call INV_AddInventoreItem;
player groupChat format[localize "STRS_lotto_wait"];
playing_lotto = 1;
sleep 1800;
playing_lotto = 0;

if (_winner >= _chance) then

{

player groupChat localize "STRS_lotto_lost";

}
else
{

['cash', _lottowin] call INV_AddInventoreItem;
player groupChat format[localize "STRS_lotto_winner", (_lottowin call ISSE_str_IntToStr)];

};

