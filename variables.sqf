//the server deosnt have to load 1/2 this shit NYI

INV_smscost          = 1;
add_civmoney         = 400;
add_copmoney         = 600;
add_workplace        = 500;
add_checkpoint       = 1500;
CopWaffenAvailable   = 0;
CopIsInPrison        = false;
CopInPrisonTime      = 300;
shooting_self        = 0;
srHinbewegen         = 0;
deadcam              = 0;
isstunned            = false;
hatGanggebietErobert = false;
Antwort              = 0;
CivTimeInPrison      = 0;
CopLog               = [];
MayorSteuern         = 0;
MayorBekommtSteuern  = 35;
chiefSteuern         = 0;
chiefBekommtSteuern  = 35;
eigene_zeit          = time;
money_limit          = 100000;
bank_limit           = 999999;
wantedbonus          = 30000;
StunActiveTime       = 0;
StunTimePerHit       = 15;
MaxStunTime          = 30;
demerits             = 0;
keyblock             = false;
maxboars             = 35;
maxcows              = 5;
maxmanitime          = 10800;
powerrestorecost     = 10000;
impoundpay           = 75;
impoundpay2          = 3000;
noholster            = false;
MGcost               = 10000;
PKcost               = 10000;
SQUADcost            = 20000;
maxinfai             = 16;
firestrikes          = 3;
totalstrikes         = 3;
facworkercost        = 100;
maxfacworkers        = 15;
firingcaptive        = false;
pickingup            = false;
lockpickchance       = 10;
planting             = false;
drugstockinc         = 900;
druguse_minutes      = 2;

//========robbing variables===========
bankrobdelay	    = 120;
stolenfromtime        = 300;
stolenfromtimeractive = false; // dont change


//===============MOTD==================
motdwaittime = 120;

//===============Cop Patrol==================
pmissionactive   = false;
patrolwaittime   = false;
patrolmoneyperkm = 1; // 1 would be equal to $3,000 for 1KM


//=========government convoy=============
govconvoybonus      = 10000;
govconvoythiefbonus = 15000;
moneyintruck        = true; //dont change

//===== Gas station robbing


if(debug)then{drugstockinc = 6;druguserate = 20};

//==============================PETROL/OIL=========================================
petroluse       = 1;
maxpetroluse    = 300;
minPetrolPrice  = 25;
oildemand       = 0.25;
oilsellpricedec = 30;
oilbaseprice    = 750;

//==============================MINING=============================================
shoveldur  = 20;
shovelmax  = 2;
pickaxedur = 50;
pickaxemax = 3;
hammerdur  = 100;
hammermax  = 4;
working    = false;

//===============================GANGS=============================================
gangcreatecost = 25000;
gangdel_minutes  = 5;
gangsarray     = [];
gangmember     = false;
gangleader     = false;
gangareas      = [gangarea1,gangarea2,gangarea3];

//=================================================================================
//CityLocationArray = [[militarybase, 200]];
respawnarray      = [respawn1,respawn2,respawn3,respawn4,respawn5,respawn6,respawn7,respawn8,respawn9,respawn10,respawn11,respawn12];

//=========== cop patrol array ==========
coppatrolarray = [
  getmarkerpos "patrolpoint1",
  getmarkerpos "patrolpoint2",
  getmarkerpos "patrolpoint3",
  getmarkerpos "patrolpoint4",
  getmarkerpos "patrolpoint5",
  getmarkerpos "patrolpoint6",
  getmarkerpos "patrolpoint7",
  getmarkerpos "patrolpoint8",
  getmarkerpos "patrolpoint9",
  getmarkerpos "patrolpoint10",
  getmarkerpos "patrolpoint11",
  getmarkerpos "patrolpoint12",
  getmarkerpos "patrolpoint13",
  getmarkerpos "patrolpoint14",
  getmarkerpos "patrolpoint15",
  getmarkerpos "patrolpoint16",
  getmarkerpos "patrolpoint17",
  getmarkerpos "patrolpoint18",
  getmarkerpos "patrolpoint19",
  getmarkerpos "patrolpoint20",
  getmarkerpos "patrolpoint21",
  getmarkerpos "patrolpoint22",
  getmarkerpos "patrolpoint23",
  getmarkerpos "patrolpoint24",
  getmarkerpos "patrolpoint25"
];

["keyring", 1] call INV_SetItemAmount;
["handy", 1] call INV_SetItemAmount;

if (iscop) then {
  RadioTextMsg_1 = "Put your hands up!";
  RadioTextMsg_2 = "Pull over and stay in your vehicle!";
  RadioTextMsg_3 = "Drop your weapon and put your hands on your head!";
  RadioTextMsg_4 = "Your free to go, have a nice day";
} else {
  RadioTextMsg_1 = "Put your hands up now!";
  RadioTextMsg_2 = "Step away from the vehicle!";
  RadioTextMsg_3 = "Do it now or your dead!";
  RadioTextMsg_4 = "Dont shoot i give up!";
};

RadioTextArt_1 = "direct";
RadioTextArt_2 = "direct";
RadioTextArt_3 = "direct";
RadioTextArt_4 = "direct";

publicarbeiterarctionarray= [];

for [{_i=1}, {_i <= civscount}, {_i=_i+1}] do {
call compile format ['
  kopfcash_civ%1      = 0;
  civ%1_wanted        = 0;
  civ%1_reason        = [];
  civ%1_arrest        = 0;
  civ%1_markerjammed  = 0;
', _i];
};

GC_Wanted = [[0,0,[],0]];

isdead            = 0;
local_arrest      = 0;
extradeadtime     = 0;
respawntimeinc    = 10;
killedplayerinc   = 15;
respawnzeit       = 3;
DeadWaitSec       = respawnzeit;
DeadTimeMax       = 60;
deadtimebonus     = 0;
deadtimes         = 0;
suicidepenalty    = 60;
CopsKilled        = 0;
CivsKilled        = 0;
SelfKilled        = 0;
CivsBusted 	  = 0;
BailPaid 	  = 0;
RewardsCollected  = 0;
GesetzAnzahl      = 10;
GesetzArray       = ["Press M to read server laws and rules.", "", "", "", "","", "", "", ""];
chaos = false;
PlayerUID = [];

if (debug) then {
  suicidepenalty = 0;
  respawntimeinc = 0;
  killedplayerinc = 0;
};

isMayor       = false;
WahlArray     = [];
MayorNumber   = -1;
MayorExtraPay = 3000;

for [{_i=0}, {_i < playercount}, {_i=_i+1}] do {WahlArray = WahlArray + [ [] ];};

ischief                 = false;
WahlArrayc               = [];
chiefNumber             = -1;
chiefExtraPay           = 5000;

for [{_i=0}, {_i < playercount}, {_i=_i+1}] do {WahlArrayc = WahlArrayc + [ [] ];};

deadcam_target_array = [
  [17205.75,99198.17,-49454.65],
  [114238.47,12719.49,3040.26],
  [114238.47,12719.49,3040.28],
  [9396.48,-87407.76,-3495.99],
  [9396.48,-87407.76,-3495.72],
  [-85499.48,17145.94,-3497.86],
  [-81437.91,41177.12,-3500.26],
  [-68592.92,68496.92,-3504.91],
  [63894.18,99059.27,-3504.91],
  [57781.25,102312.13,-3505.24],
  [18155.12,112290.52,-3505.59],
  [114056.91,13559.94,-3506.64],
  [114056.91,13559.94,-3506.63],
  [12082.11,112377.59,-3507.94],
  [12082.11,112377.59,-3508.13],
  [12082.11,112377.59,-3507.88],
  [71475.13,94441.38,-3511.65],
  [79131.48,88521.11,-3512.17],
  [90116.62,77668.10,-3514.78],
  [93979.69,72896.55,-3515.45],
  [23989.44,112118.31,-3515.51],
  [111421.41,-10631.93,-3515.78],
  [111421.41,-10631.93,-3515.45],
  [111421.41,-10631.93,-3515.62],
  [-85207.23,22475.24,-3515.77],
  [-85269.09,22481.34,761.18],
  [-52542.68,-60176.11,-15820.92],
  [66335.50,-71098.57,-15831.98],
  [112733.68,9274.25,-15848.19],
  [112733.68,9274.25,-15848.03],
  [112733.68,9274.25,-15848.01],
  [112733.68,9274.25,-15848.28],
  [15793.38,-87445.16,-1975.57],
  [15793.38,-87445.16,-1975.58],
  [-85045.43,23679.19,-1976.55],
  [-2976.49,110953.34,-1977.04],
  [-2976.49,110953.34,-1976.94],
  [25975.48,-86795.57,-1977.29],
  [25975.48,-86795.57,-1977.28],
  [30152.87,-86219.98,-1977.49],
  [114191.58,8919.13,-1977.75],
  [114186.95,8335.76,-1978.02],
  [13212.45,-87514.59,-1978.28],
  [13212.45,-87514.59,-1978.39],
  [13328.19,-76559.05,-45508.50]
];

deadcam_position_array = [
  [6573.78,2365.67,19.16],
  [6563.33,2409.16,3.60],
  [6598.98,2409.17,3.60],
  [6615.21,2406.75,2.60],
  [6616.97,2469.89,3.60],
  [6619.17,2455.47,4.36],
  [6650.88,2457.08,5.60],
  [6719.63,2400.90,6.92],
  [6712.46,2403.60,7.08],
  [6712.08,2419.00,8.08],
  [6727.18,2457.75,20.08],
  [6724.96,2465.48,15.08],
  [6764.31,2465.91,7.08],
  [6771.92,2463.60,20.08],
  [6771.38,2538.25,21.08],
  [6771.13,2550.88,22.08],
  [6769.29,2568.52,23.08],
  [6793.91,2598.42,24.08],
  [6825.21,2646.20,25.08],
  [6839.44,2658.20,25.08],
  [6869.00,2658.38,25.08],
  [6909.94,2668.50,25.35],
  [6942.29,2667.94,25.33],
  [6846.04,2627.05,20.37],
  [6827.04,2538.54,18.41],
  [6742.96,2468.32,18.69],
  [6769.18,2697.18,15.22],
  [6792.32,2615.79,10.43],
  [6679.88,2556.44,6.43],
  [6560.67,2516.16,6.43],
  [6588.56,2525.49,6.43],
  [6551.50,2521.79,6.43],
  [6606.49,2523.45,1.69],
  [6606.37,2476.85,1.69],
  [6602.42,2474.65,1.69],
  [6578.19,2474.97,1.69],
  [6574.55,2488.17,1.69],
  [6574.79,2497.03,1.69],
  [6573.99,2491.74,5.46],
  [6574.33,2490.64,4.93],
  [6574.66,2458.02,4.93],
  [6597.66,2457.95,4.93],
  [6599.95,2459.04,5.23],
  [6599.66,2459.05,18.31],
  [6575.55,2451.36,19.46]
];

atmscriptrunning          = 0;
shopactivescript          = false;
deadcam_wechsel_dauer     = 5;
deadcam_kameraposition    = round(random (count deadcam_position_array - 1));
prostitute_cost           = 1500;
prostitutemoneyprosekunde = 300;
maxprostitute             = 6;
copprostituteallowed      = 1;
localprostitute           = 0;
localprostitutecounter    = 0;
doingSomething            = false;
unholstering              = false;
busses                    = ["Ikarus_TK_CIV_EP1", "Ikarus"];
busRouteActive            = false;
busRouteWaiting           = false;
takingFlag                = false;
speedbomb_minspeed        = 1;
speedbomb_maxspeed        = 100;
speedbomb_mindur          = 10;
speedbomb_maxdur          = 300;
zeitbombe_mintime         = 1;
zeitbombe_maxtime         = 10;
//HideoutLocationArray      = CityLocationArray;
publichideoutarray        = [];
hideoutcost               = 20000;
marker_innerhalb          = 5;
marker_CopDistance        = 50; //controls distance cops need to be to make civ dots appear outside of towns.
CivMarkerUngenau          = 20;
copmarker_on              = 1;
despawnarray              = [["EvMoney", 300], ["Suitcase", 300]];
workplacearray            = [[workplace1, 80], [workplace2, 80], [workplace3, 60]];
checkpointarray           = [[copgate2, 50], [copgate3, 50], [copgate4, 50], [copgate5, 50]];
huntingarray              = [["boarhunting", 300]];
nonlethalweapons          = ["Binocular", "NVGoggles", "ItemMap", "ItemCompass", "ItemRadio", "ItemWatch", "ItemGPS"];
prostitutearray           = workplacearray;
timeinworkplace           = 0;
wpcapacity                = 10;
INV_hasitemshop           = 0;
INV_haswepshop            = 0;
BuildingsOwnerArray       = [];
prevWhistles              = [-60, -60, -60, -60, -60, -60];

if(isciv) then {
  BuyAbleBuildingsArray = [
    ["wp1", "Workplace 1", workplace_getjobflag_1, 1000, 100, "wp", "WpAblage_1"],
    ["wp2", "Workplace 2", workplace_getjobflag_2, 2000, 200, "wp", "WpAblage_2"],
    ["wp3", "Workplace 3", workplace_getjobflag_3, 3000, 300, "wp", "WpAblage_3"]
  ];
};


civprostitutearray = ["Hooker1","Hooker2","Hooker3","Hooker4","Hooker5"];

robbable = [
  fuelshop1,
  fuelshop2,
  bagshop,
  shop1,
  shop2,
  shop3,
  shop4,
  lottoshop,
  shop1export,
  shop2export,
  shop3export,
  shop4export,
  miningt,
  tuning1,
  tuning2,
  RingShop,
  equipshop,
  resourcesell,
  pub1,
  pub2,
  pub3,
  delivery1,
  taxi1,
  oilsell1,
  hornnpc
];

// Define Rapel Variables
gcrsrope1 = "none";
gcrsrope2 = "none";
gcrsrope3 = "none";
gcrsrope4 = "none";
gcrsrope5 = "none";
gcrsrope6 = "none";
gcrsrope7 = "none";
gcrsrope8 = "none";
gcrsrope9 = "none";
gcrsrope10 = "none";
gcrsrope11 = "none";
gcrsrope12 = "none";
gcrsrope13 = "none";
gcrsrope14 = "none";
gcrsrope15 = "none";
gcrsrepelvehicle = "none";
gcrsropedeployed = "false";
gcrsdeployropeactionid = 0;
gcrsdropropeactionid = 0;
gcrsplayerrepelactionid = 0;
gcrsplayerveh = "none";
gcrspilotvehicle = "none";
gcrsrapelvehiclearray = ["MH6J_EP1", "UH1H_TK_GUE_EP1", "UH1Y", "UH60M_EP1"];
gcrsrapelheloarray = [];
gcrsplayerveharray = [];

playing_lotto = 0;
LottoArray =[
	["lotto1", 	"Cheap ticket",	1,	10000, 3],
	["lotto2", 	"Normal ticket",2,	20000, 3],
	["lotto3", 	"Super ticket",	3,  30000, 3],
	["lotto4",	"Chaos ticket",	4, 50000, 3]
];

LottoFlags = [[lottoshop,["lotto1", "lotto2", "lotto3", "lotto4"]]];

idleAnims = ["UnaErcPoslechVelitele1", "UnaErcPoslechVelitele2", "UnaErcPoslechVelitele3", "UnaErcPoslechVelitele4"];
sitAnims = ["sitUnarm_R_relaxing"];
sitNPCs = [shop1export, shop2export, shop3export, shop4export, ringshop, shop1, resourcesell, bagshop, equipshop, carshop3, chairnpc];

playerWeapons     = [];
playerMagazines   = [];
weaponsloaded     = false;
CopStartGear_Mags = [
  "7Rnd_45ACP_1911",
  "7Rnd_45ACP_1911",
  "7Rnd_45ACP_1911",
  "7Rnd_45ACP_1911",
  "7Rnd_45ACP_1911",
  "7Rnd_45ACP_1911",
  "7Rnd_45ACP_1911",
  "7Rnd_45ACP_1911"
];


CopStartGear_Weap = ["ItemGPS","NVGoggles","Binocular","Colt1911"]; //keep the default stun gun last
stunfxammo = "F_40mm_Red";
stunammo = ["B_45ACP_Ball","B_9x19_Ball","B_12Gauge_74Slug","F_40mm_White"];
stunmags = ["7Rnd_45ACP_1911","15Rnd_9x19_M9","8Rnd_B_Beneli_74Slug","6Rnd_FlareWhite_M203"];
teargas = ["SmokeShell", "G_40mm_Smoke"];
flashbangs = ["GrenadeHand", "G_40mm_HE"];

iactionarr = [];

unholsterPistol = -1;
holsterPistol = -1;
saveWeaponPistol = ["",false,false];

{
	_queue = (_x select 8);
	_list  = _x select 5;
	call compile format['%1workers = 0;', _queue];
	{ call compile format['%1avail = 0; %1prod = 0; %1eta = 0; %1pend = 0;', _x]; } forEach _list;
} foreach INV_ItemFabriken;

handleDamage_handle = 0 spawn {};
radio_handle = 0 spawn {};

armor_big = [
	"B_545x39_SD",
	"B_545x39_Ball",
	"B_762x39_Ball",
	"B_556x45_Ball",
	"B_556x45_SD",
	"B_762x51_noTracer",
	"B_556x45_Ball_SD",
	"B_762x51_Ball",
	"B_127x99_Ball_noTracer",
	"B_12Gauge_74Slug",
	"B_762x54_Ball",
	"B_762x54_noTracer",
	"B_127x108_Ball",
	"B_9x39_SP5",
	"B_127x107_Ball",
	"B_145x115_AP",
	"B_762x51_3RndBurst",
	"B_127x99_Ball",
	"B_77x56_Ball",
	"B_19mm_HE",
	"B_86x70_Ball_noTracer",
	"B_303_Ball",
	"B_127x108_APHE",
	"G_40mm_HE",
	"G_30mm_HE"
];

armor_small = [
	"B_765x17_Ball",
	"B_9x18_Ball",
	"B_9x18_SD",
	"B_45ACP_Ball",
	"B_12Gauge_Pellets",
	"B_9x19_Ball",
	"B_9x19_SD"
];

refuel_action_a1 = 0; refuel_action_f1 = 0; refuel_action_v1 = 0;
factory_action_a2 = 0; factory_action_a3 = 0; factory_action_f2 = 0;
factory_busy_array = []; for [{_i=0}, {_i < (count INV_ItemFabriken)},{_i=_i+1}] do {factory_busy_array = factory_busy_array + [0]};
licenses_purchased_array = []; for [{_i=0}, {_i < (count INV_Lizenzen)},{_i=_i+1}] do {licenses_purchased_array = licenses_purchased_array + [0]};

chairaction = -1;
bombplanted = false;
raidarray = []; //checkpoint names
copraidarray = []; //cop names
not_raiding = true;
OutOFBoundsTicks = 0;

npcposASLs = [
	[copbasic, [4851.02,4592.83,38.4109]],
	[copbasicbox, [4849.3,4592.3,38.4117]],
	[coppatrol, [4842.61,4600.04,38.415]],
	[coppatrolbox, [4842.48,4598.58,38.4151]],
	[copcriminalbox, [4835.43,4608.69,38.4183]],
	[copcriminal, [4835.67,4609.79,38.4183]],
	[copbank, [4854.04,4603.63,38.1870]],
	[copswat, [4931.46,4613.93,39.1783]],
	[copswatbox, [4929.67,4613.66,39.1681]],
	[copswatE, [4937.89,4615.52,39.1583]],
	[copswatI, [4931.58,4625.26,38.9725]],
	[pistolshop, [3760.38,3783.42,35.3938]],
	[pistolbox, [3761.43,3784.37,35.3943]],
	[shop1, [4276.9,4241.94,16.9628]],
	[equipshop, [4171.1,4119.88,16.9776]],
	[equipbox, [4171.8,4121.39,16.9692]],
	[carshop1, [4315.72,4149.47,17.705]],
	[licenseflag6, [3758.52,4281.57,17.5082]],
	[licenseflag2, [3750.63,4289.15,17.5082]],
	[licenseflag5, [3744.43,4294.67,17.5082]],
	[licenseflag7, [3755.85,4287,15]],
	[taxi1, [4187.18,3912.75,17.3693]],
	[resourcesell, [4314.33,3947.73,18.2763]],
	[ItemFabrik_1, [4022.02,3568.76,25.5026]],
	[bmshop, [5046.23,-1.37954,85.0358]],
	[fuelshop1, [3889.39,4212.03,15.8785]],
	[fuelshop2, [3718.69,2792.09,11.731]],
	[fuelshop3, [3861.01,5983.08,30.5954]],
	[fuelshop4, [5019.02,1916.13,33.1661]],
	[shop2export, [4350.63,4353.98,16.592]],
	[OilSell1, [2975.71,4825.27,27.323]],
	[carshop2, [4090.08,3638.15,25.2584]],
	[tuning1, [3910.79,4208.95,15.9995]],
	[tuning2, [4355.97,3877.01,17.9657]],
	[RingShop, [4031.11,4236.01,16.1647]],
	[ringfactory, [4159.59,4671.54,16.4127]],
	[tdoc, [3704.16,4043.94,16.9787]],
	[Diamond_1, [4549.12,4040.11,18.6096]],
	[pub1, [4065.41,3697.95,21.6933]],
	[travelagent, [4243.67,4106.35,17.2927]],
	[lottoshop, [3982.65,4059.88,16.9898]],
	[hopsprocess, [4831.95,6124.73,29.5478]],
	[pub2, [4249.02,4080.43,17.8562]],
	[pub3, [3802.64,4316.96,15.6]],
	[miningt, [4211.32,4281.8,17.0139]],
	[delivery1, [4010.86,4109.29,16.6743]],
	[safe1, [4001.75,4052.8,19.150]],
	[safe2, [4010.21,4053.33,19.150]],
	[safe3, [4021.45,4052.67,19.150]],
	[mainbank, [4015.79,4054.94,16.9687]],
	[hornnpc, [2702.94,5110.1,38.0594]],
     [airfactory, [3410.69,6854.7,26.575]]
];

INV_StorageSperre = false;
wipewanted = true;
kickedout = false;
private_storage = [];
last_terror_time = 0;

oldSlot = nil;

siren_is_on = false;
cop_is_driving = false;
action_code0 = -1;
action_code1 = -1;
action_code2 = -1;
siren_action_veh = 0;

SKILL_FISHING = 0;
SKILL_HUNTING = 0;
SKILL_GATHERING = 0;
SKILL_MINING = 0;
SKILL_MANUFACTURING = 0;
SKILL_LOCKPICKING = 0;
SKILL_ROBBERY = 0;
SKILL_PROSTITUTION = 0;
SKILL_EXPORT = 0;
GC_Skills = ["SKILL_FISHING","SKILL_HUNTING","SKILL_GATHERING","SKILL_MINING","SKILL_MANUFACTURING","SKILL_LOCKPICKING","SKILL_ROBBERY","SKILL_PROSTITUTION","SKILL_EXPORT"];