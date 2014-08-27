_num     = ((_this select 3) select 0);
_facname = ((INV_ItemFabriken select _num) select 1);
_cost    = ((INV_ItemFabriken select _num) select 6);
_cash    = 'cash' call INV_GetItemAmount;

if (_facname in INV_Fabrikowner) exitwith {player groupchat localize "STRS_inv_alreadygotshop";};
if (_cash < _cost) exitwith {player groupchat localize "STRS_inv_kein_cash";};
if (_facname == "factory5" && (!("airfaclicense" call INV_HasLicense))) exitwith {player groupchat localize "STRS_inv_buylicense_alreadyfalse";};
INV_Fabrikowner = INV_Fabrikowner + [ _facname ];
['cash', -(_cost)] call INV_AddInventoreItem;
["INV_Fabrikowner", INV_Fabrikowner] call ClientSaveVar;

player groupchat format[localize "STRS_inv_gotshop", player, (_cost call ISSE_str_IntToStr)];