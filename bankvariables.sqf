Startcash              = 5000;
maxcopbonus            = 2000;
maxcivbonus            = 1500;
robb_timeSperre        = 1200;
local_useBankPossible  = true;
maxinsafe              = money_limit;
BankRaubKontoverlust   = 4000;
ShopRaubKontovershop   = 0;
ShopRaubProzentVershop = 0;
rblock                 = 0;
stolencash             = 0;
Maxbankrobpercentlost  = 0.1;
bank_steuer            = 5;
zinsen_prozent         = 5;
interest_minutes       = 20;
robenable              = true;
Kontostand             = Startcash;

shopflagarray          = [shop1,shop2,shop3,shop4];
bankflagarray          = [mainbank, copbank, atm1, atm2, atm3, atm4, atmpf, atmt];
speedcamarray          = [[speed1,"W Checkpoint Rd."],[speed2,"N Checkpoint Rd."],[speed3,"SE Checkpont Rd."],[speed4,"SW Checkpoint Rd."],[speed5,"General Factory Rd."],[speed6,"Bank Rd."]];
drugsellarray          = [mdrugsell,cdrugsell,ldrugsell,hdrugsell];
TankstellenArray       = [
  (nearestobject[getpos fuelshop1,"Land_Ind_FuelStation_Feed_Ep1"]),
  (nearestobject[getpos fuelshop2,"Land_Ind_FuelStation_Feed_Ep1"]),
  (nearestobject[getpos fuelshop3,"Land_Ind_FuelStation_Feed_Ep1"]),
  (nearestobject[getpos fuelshop4,"Land_Ind_FuelStation_Feed_Ep1"]),
  fuelshop5
];

if (debug and !isServer) then {['cash', 999999] call INV_AddInventoreItem};