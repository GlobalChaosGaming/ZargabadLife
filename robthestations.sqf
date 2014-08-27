_selection = ((_this select 3) select 0);
_stolen = 0;

if (!(call INV_isArmed)) exitwith {
  player groupchat "You need a gun to rob the store!";
};

if (!doingSomething) then {
  doingSomething = true;
  {
    if (_selection == _x) then
    {
      call compile format["
        _stolen = %1money;
      %1money = 0;
      publicVariable ""%1money"";
      ", _x];
    };
  } forEach robbable;
	_storename = _selection call INV_getItemShopName;
  (format['["Robbed", %1, %2, "%3"] spawn Isse_AddCrimeLogEntry; if(!("Robbed a store" in %1_reason))then{%1_reason = %1_reason + ["Robbed a store"]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + wantedamountforrobbing;', player,_stolen,_storename]) call broadcast;
  (format ["server globalChat ""Someone robbed %1!"";", _storename]) call broadcast;
   _addskill = ((_stolen / 150) * 0.0015);
  ["SKILL_ROBBERY",_addskill] call GC_addSkill;
  ['cash', _stolen] call INV_AddInventoreItem;
  player sidechat format ["You stole $%1 from the store!", _stolen];

  _stolen = 0;
  doingSomething = false;
};
