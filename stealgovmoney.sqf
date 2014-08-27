// written by Gman
//script called by steal money addaction for government convoy
if (!(call INV_isArmed)) exitwith
	{
	player groupchat "You need a gun to rob the convoy!";
	};
convoytruck removeAction stealgovmoney;
player groupchat format ["You got $%1 extra for stealing the Government funds!", govconvoythiefbonus];
['cash', govconvoythiefbonus] call INV_AddInventoreItem;
["SKILL_ROBBERY",0.25] call GC_AddSkill;
(format['["Convoy", %1, %2] spawn Isse_AddCrimeLogEntry; if(!("Theft of Government funds" in %1_reason))then{%1_reason = %1_reason + ["Theft of Government funds"]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 10000;', player, govconvoythiefbonus]) call broadcast;
moneyintruck = false;
publicvariable "moneyintruck";