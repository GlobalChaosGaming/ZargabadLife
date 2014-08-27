if (count _this == 4) exitWith
{
	closedialog 0;
	_bagShopDialog = createDialog "bagShop";
	switch INV_Tragfaehigkeit do
	{
		case 70:
		{
			ctrlEnable [50, false];
		};
		case 90:
		{
			ctrlEnable [50, false];
			ctrlEnable [60, false];
		};
		case 120:
		{
			ctrlEnable [50, false];
			ctrlEnable [60, false];
			ctrlEnable [70, false];
		};
	};
};

_bagType = _this select 0;

switch _bagType do
{
	case 1:
	{
		if("cash" call INV_GetItemAmount >= 10000) then
		{
			ctrlEnable [50, false];
			player groupChat "You can now hold 70kg!";
			["cash", -10000] call INV_AddInventoreItem;
			INV_Tragfaehigkeit = 70;
		}
		else
		{
			player groupChat "You do not have enough money!";
		};
	};
	case 2:
	{
		if("boarpelt" call INV_GetItemAmount >= 5) then
		{
			ctrlEnable [50, false];
			ctrlEnable [60, false];
			player groupChat "You can now hold 90kg!";
			["boarpelt", -5] call INV_AddInventoreItem;
			INV_Tragfaehigkeit = 90;
		}
		else
		{
			player groupChat "You do not have enough boar pelt!";
		};
	};
	case 3:
	{
		if("cowleather" call INV_GetItemAmount >= 5) then
		{
			ctrlEnable [50, false];
			ctrlEnable [60, false];
			ctrlEnable [70, false];
			player groupChat "You can now hold 120kg!";
			["cowleather", -5] call INV_AddInventoreItem;
			INV_Tragfaehigkeit = 120;
		}
		else
		{
			player groupChat "You do not have enough cow leather!";
		};
	};
};