if(isServer)then {
  INV_itemstocks = [
    //fs
    [-1,20,20,20],
    [-1,20,20,20],
    [-1,20,20,20],
    [-1,20,20,20],

    //hunt
    [15,10,10,10,10,10,10,10],

    //boat
    -1,
    -1,

    //is
    [10,10,10,10],
    [10,10,10,10],
    [10,10,10,10],
    [10,10,10,10],

    //pub
    [-1,-1,-1,-1,-1,-1,-1],
    [-1,-1,-1,-1,-1,-1,-1],
    [-1,-1,-1,-1,-1,-1,-1],

    //pshop
    [
    	20,-1,  	//m9
    	20,-1,  	//m9sd
    	20,-1,  	//makrov
    	15,-1,  	//revolver
    	15,-1  		//g17
    ],

    //rshop
    [
    	15,-1,  	//lee
    	15,-1,-1,	//saiga (buck, slug)
    	10,-1,-1,	//aa12 (buck, slug)
    	10,-1, 		//fal
    	10,-1  		//m14
    ],

    //es
    [10,10,10,10],

    //cu
    [20,20,20,10,10],
    [20,20,20,10,10],

    //ts
    [10,10,10,10,5,5],

    //as
    [30,5,5,10,10,10],

    //mt
    [20,20,20],

    //rs
    [10,10,10,10,15,15,15],

    //gds
    [0,0,0,0],

    //os
    -1,

    //ga
    -1,
    -1,
    -1,

    //ds
    -1,
    -1,
    -1,
    -1,

    //ca
    -1,

    //cv
    -1,

    //sv
    -1,

    //td.
     -1,

    //cops
    -1,

    //copsp
    -1,

    //copsc
    -1,

    //copss
    -1,

    //copssE
    -1,

    //cs
    [-1,20,20,15,15,15,15,10,10,10,10,10,10],
    [-1,20,15,15,15,15,10,10,10,10],
    [-1,20,15,15,15,15,15,10,10,10],

   //blackmarket
    -1,

    //blackmarket_air
    -1,

    //blackmarket_veh
    -1,

    //jailbike
    -1,

    //bus
    -1,

    //horn shop
    -1,

    //chair shop
    -1,

    //terror shop
    -1,

  //terror vehicle
  -1,

    //gsb
    -1
  ];

  publicvariable "INV_itemstocks";
};

INV_itemmaxstocks = [
  //fs
  [-1,100,100,100],
  [-1,100,100,100],
  [-1,100,100,100],
  [-1,100,100,100],

  //hunt
  [50,50,50,50,50,50,50,50],

  //boat
   -1,
   -1,

  //is
  [50,50,50,50],
  [50,50,50,50],
  [50,50,50,50],
  [50,50,50,50],

  //pub
  [-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1],

  //pshop
  [
  	50,-1, //m9
  	50,-1, //m9sd
  	50,-1, //makrov
  	40,-1, //revolver
  	40,-1 	//g17
  ],

  //rshop
  [
  	40,-1, 	//enfield
  	40,-1,-1, 	//siaga
  	25,-1,-1, 	//aa12
  	25,-1,  	//fal
  	25,-1 		//m14
  ],

  //es
  [100,100,100,100],

  //cu
  [50,50,50,25,25],
  [50,50,50,25,25],

  //ts
  [20,20,20,20,10,10],

  //as
  [50,10,10,20,20,20],

  //mt
  [30,30,30],

  //rs
  [200,200,200,200,250,250,250],

  //gds
  [50,25,25,25],

  //os
  -1,

  //ga
  -1,
  -1,
  -1,

  //ds
  -1,
  -1,
  -1,
  -1,

  //ca
  -1,

  //cv
  -1,

  //sv
  -1,

  //td
 -1,

  //cops
  -1,

  //copsp
  -1,

  //copsc
  -1,

  //copss
  -1,

    //copssE
    -1,

  //cs
  [-1,30,30,25,25,25,25,15,15,15,15,15,15],
  [-1,30,25,25,25,25,15,15,15,15],
  [-1,30,25,25,25,25,25,15,15,15],

  //blackmarket
  -1,

  //blackmarket_air
  -1,

  //blackmarket_veh
  -1,

  //jailbike
  -1,

  //bus
    -1,

  //horn shop
    -1,

  //chair shop
    -1,

  //terror shop
    -1,

  //terror vehicle
  -1,

  //gsb
  -1

];

// Shop items
_emptyshop = [];
_fs    = ["Fuelline", "kanister", "kleinesreparaturkit", "reparaturkit"];
_hunt  = ["boarpelt", "cowleather", "boar", "cow", "perch", "trout", "walleye", "bass"];
_boat  = ["PBX"];
_is    = ["medikit","fishingpole","fireworks"];
_pub   = ["beer","beer2","vodka","smirnoff","whiskey","wine"];
_pub2   = ["beer","beer2","vodka","smirnoff","whiskey","wine"];
_pub3   = ["beer","beer2","vodka","smirnoff","whiskey","wine"];

//pistol shop
_pshop = [
	"M9", "Rnd_9x19_M9",
	"M9SD", "Rnd_9x19_M9SD",
	"Makarov", "Rnd_9x18_Makarov",
	"revolver_EP1", "Rnd_45ACP",
	"G17","Rnd_9x19_glock17"
];

//rifle shop
_rshop = [
	"LeeEnfield", "x_303",
	"Saiga12K","Rnd_B_Saiga12_Pellets","Rnd_B_Saiga12_74Slug",
	"AA12_PMC","Rnd_B_AA12_Pellets","Rnd_B_AA12_74Slug",
	"FN_FAL","Rnd_762x51_FNFAL",
	"M14_EP1","Rnd_762x51_DMR"
];

_es    = ["Binocular", "NVGoggles", "GPS", "GasMask"];
_cu    = ["caralarm","bunnyhop", "nitro", "supgrade1", "supgrade2"];
_ts    = ["Ural_TK_CIV_EP1", "Ural_UN_EP1", "V3S_Open_TK_CIV_EP1", "V3S_TK_GUE_EP1", "MTVR", "MTVR_DES_EP1"];
_as    = ["TowingTractor", "AH6X_EP1", "MH6J_EP1", "An2_1_TK_CIV_EP1", "An2_2_TK_CIV_EP1", "An2_TK_EP1"];
_mt    = ["Shovel","Pickaxe","JackHammer"];
_rs    = ["Platinum","Gold","Silver","Rubies","iron","copper","steel"];
_gds   = ["Diamondring","EDiamondring","Platinumring","EPlatinumring"];
_os    = ["OilBarrel"];
_db1   = ["marijuana","cocaine","lsd"];
_db2   = ["cocaine","lsd"];
_db3   = ["heroin","marijuana"];
_dsc   = ["cocaine"];
_dsm   = ["marijuana"];
_dsl   = ["lsd"];
_dsh   = ["heroin"];
_ca    = ["MH6J_EP1","AH6J_EP1", "UH1H_TK_GUE_EP1","UH60M_EP1"];
_cv    = ["MMT_USMC", "TT650_Civ", "ATV_US_EP1", "VolhaLimo_TK_CIV_EP1", "SUV_TK_CIV_EP1"];
_sv    = ["HMMWV_M2", "HMMWV_Armored"];

_td = ["medikit"];

_copshop = [
	"LightArmor",
	"Colt1911",
	"7Rnd_45ACP_1911",
	"Binocular",
	"NVGoggles",
	"medikit",
	"handy"
];

_copshop_patrol = [
  "kleinesreparaturkit",
  "reparaturkit",
  "kanister",
  "nitro",
  "supgrade1",
  "supgrade2",
  "radar",
  "caralarm",
  "roadblock",
  "bargate",
  "SearchLight_UN_EP1",
  "Hbarrier",
  "Spikestrip"
];

_copshop_response = ["MP5A5", "30rnd_9x19_MP5", "MP5SD", "30rnd_9x19_MP5SD", "M1014", "8Rnd_B_Beneli_Pellets","8Rnd_B_Beneli_74Slug", "M16A2", "M16A4", "M16A4_ACG", "20Rnd_556x45_Stanag", "supgrade3"];

_copshop_swat = [
  "glock17_EP1",
  "15Rnd_9x19_M9",
  "M4A1",
  "M4A1_Aim",
  "G36C",
  "G36K",
  "30Rnd_556x45_Stanag",
  "SCAR_H_CQC_CCO",
  "SCAR_H_CQC_CCO_SD",
  "SCAR_H_STD_TWS_SD",
  "20rnd_762x51_B_SCAR",
  "20rnd_762x51_SB_SCAR",
  "M249_EP1",
  "200Rnd_556x45_M249"
];

_copshop_swatE = [
  "HeavyArmor",
  "SmokeShell",
  "Flashbang",
  "M2StaticMG_US_EP1",
  "vclammo",
  "M32_EP1",
  "6Rnd_Smoke_M203",
  "6Rnd_HE_M203",
  "FlareWhite_M203"
];

_cs1 = [
  "Old_bike_TK_CIV_EP1",
  "Old_moto_TK_Civ_EP1",
  "TT650_TK_CIV_EP1",
  "ATV_CZ_EP1",
  "Skoda",
  "Volha_1_TK_CIV_EP1",
  "Lada1_TK_CIV_EP1",
  "car_hatchback",
  "VWGolf",
  "S1203_TK_CIV_EP1",
  "datsun1_civil_1_open",
  "hilux1_civil_3_open_EP1",
  "LandRover_TK_CIV_EP1"
];

_cs2 = [
  "Old_bike_TK_CIV_EP1",
  "TT650_Ins",
  "SkodaBlue",
  "Volha_2_TK_CIV_EP1",
  "Lada1",
  "Lada2_TK_CIV_EP1",
  "UAZ_Unarmed_UN_EP1",
  "datsun1_civil_2_covered",
  "hilux1_civil_1_open",
  "BAF_Offroad_D"
];

_cs3 = [
  "Old_bike_TK_CIV_EP1",
  "TT650_Gue",
  "SkodaGreen",
  "SkodaRed",
  "car_sedan",
  "Lada2",
  "UAZ_Unarmed_TK_CIV_EP1",
  "datsun1_civil_3_open",
  "hilux1_civil_2_covered",
  "LandRover_CZ_EP1"
];

_blackmarket = [
  "AK_47_M",
  "30Rnd_762x39_AK47",
  "AK74",
  "AK_107_kobra",
  "AK_107_pso",
  "30Rnd_545x39_AK",
  "Sa58P_EP1",
  "Sa58V_EP1",
  "30Rnd_762x39_SA58",
  "RPK_74",
  "75Rnd_545x39_RPK",
  "PK",
  "100Rnd_762x54_PK",
  "LightArmor",
  "vclammo"
];

_blackmarket_air = [
  "Mi17_Civilian"
];

_blackmarket_veh = [
  "Kamaz",
  "KamazOpen",
  "KamazReammo",
  "KamazRefuel",
  "KamazRepair"
];

_jailbike = [
  "Old_bike_TK_CIV_EP1"
];

_bus = [
  "Ikarus_TK_CIV_EP1",
  "Ikarus"
];

_gangshop_buy = [
  "revolver_gold_EP1",
  "Rnd_45ACP",
  "Sa61_EP1",
  "20Rnd_B_765x17_Ball",
  "UZI_EP1",
  "30Rnd_9x19_UZI",
  "UZI_SD_EP1",
  "30Rnd_9x19_UZI_SD",
  "Bizon",
  "64Rnd_9x19_Bizon",
  "bizon_silenced",
  "64Rnd_9x19_SD_Bizon",
  "Binocular",
  "NVGoggles",
  "kleinesreparaturkit",
  "reparaturkit",
  "lockpick",
  "Fuelline",
  "kanister",
  "medikit",
  "bargate",
  "BigbagfenceCorner",
  "bigbagfence",
  "bigbagfenceRound",
  "carwep"
];

_chairshop = [
	"chair",
	"chair_rug",
	"wood_chair",
	"wood_chair_rug",
	"bench",
	"bench_rug"
];

_hornshop = [
	"hornregsfx",
	"hornoldsfx",
	"hornitasfx",
	"horntrucksfx",
	"horndukessfx",
	"horncucasfx"
];

_terrorshop = [
	"medikit",
	"reparaturkit",
	"Fuelline",
	"lockpick",
      "vclammo",
      "HeavyArmor",
      "AKS_GOLD",
      "30Rnd_762x39_AK47",
	"HandGrenade_East",
      "RPG7V",
      "PG7VL",
	"vehicle_bomb",
	"suicide_bomb",
	"remote_bomb",
      "carwep"
];

_terrorveh = [
  "Pickup_PK_GUE",
  "Offroad_DSHKM_Gue",
  "Offroad_SPG9_Gue"
];

INV_ItemShops = [
  [fuelshop1,"Gas Station 1",dummyobj,dummyobj,_fs,_fs,true, "shopdialogs.sqf"],
  [fuelshop2,"Gas Station 2",dummyobj,dummyobj,_fs,_fs,true, "shopdialogs.sqf"],
  [fuelshop3,"Gas Station 3",dummyobj,dummyobj,_fs,_fs,true, "shopdialogs.sqf"],
  [fuelshop4,"Gas Station 4",dummyobj,dummyobj,_fs,_fs,true, "shopdialogs.sqf"],
  [huntshop1,"Butcher",dummyobj,dummyobj,_hunt,_hunt,true, "shopdialogs.sqf"],
  [boatshop1,"Boat Shop 1",dummyobj,[boatspawn1],_boat,_boat,true, "shopdialogs.sqf"],
  [boatshop2,"Boat Shop 2",dummyobj,[boatspawn2],_boat,_boat,true, "shopdialogs.sqf"],
  [shop1,"Item Shop 1",dummyobj,dummyobj,_is,_is,true, "shopdialogs.sqf"],
  [shop2,"Item Shop 2",dummyobj,dummyobj,_is,_is,true, "shopdialogs.sqf"],
  [shop3,"Item Shop 3",dummyobj,dummyobj,_is,_is,true, "shopdialogs.sqf"],
  [shop4,"Item Shop 4",dummyobj,dummyobj,_is,_is,true, "shopdialogs.sqf"],
  [pub1,"Romans Pub",dummyobj,dummyobj,_pub,_pub,true, "shopdialogs.sqf"],
  [pub2,"Mash's Pub",dummyobj,dummyobj,_pub2,_pub2,true, "shopdialogs.sqf"],
  [pub3,"Zargeros Pub",dummyobj,dummyobj,_pub3,_pub3,true, "shopdialogs.sqf"],
  [pistolshop,"Pistol Shop",pistolbox,dummyobj,_pshop,_pshop,true, "shopdialogs.sqf"],
  [rifleshop,"Rifle & Shotgun Shop",riflebox,dummyobj,_rshop,_rshop,true, "shopdialogs.sqf"],
  [equipshop,"Equipment Shop",equipbox,dummyobj,_es,_es,true, "shopdialogs.sqf"],
  [tuning1,"Car Tuning North",dummyobj,dummyobj,_cu,_cu,true, "shopdialogs.sqf"],
  [tuning2,"Car Tuning South",dummyobj,dummyobj,_cu,_cu,true, "shopdialogs.sqf"],
  [truckshop,"Truck Shop",dummyobj,[truckspawn_0, truckspawn_1, truckspawn_2, truckspawn_3],_ts,_ts,true, "shopdialogs.sqf"],
  [airshop,"Air Shop",dummyobj,[asairspawn_0, asairspawn_1, asairspawn_2, asairspawn_3],_as,_as,true, "shopdialogs.sqf"],
  [miningt,"Mining equipment",dummyobj,dummyobj,_mt,_mt,true, "shopdialogs.sqf"],
  [resourcesell,"Sell Resources",dummyobj,dummyobj,_rs,_rs,true, "shopdialogs.sqf"],
  [RingShop,"Ring Shop", dummyobj,dummyobj,_gds,_gds,true, "shopdialogs.sqf"],
  [OilSell1,"Oil Dealer", dummyobj,dummyobj, _emptyshop,_os,true, "shopdialogs.sqf"],
  [gangarea1,"Gang Shop",gangbox1,dummyobj,_gangshop_buy,_gangshop_buy,false, "shopdialogs.sqf"],
  [gangarea2,"Gang Shop",gangbox2,dummyobj,_gangshop_buy,_gangshop_buy,false, "shopdialogs.sqf"],
  [gangarea3,"Gang Shop",gangbox3,dummyobj,_gangshop_buy,_gangshop_buy,false, "shopdialogs.sqf"],
  [cdrugsell,"Sell Cocaine",dummyobj,dummyobj,_emptyshop,_dsc,true, "shopdialogs.sqf"],
  [mdrugsell,"Sell marijuana",dummyobj,dummyobj,_emptyshop,_dsm,true, "shopdialogs.sqf"],
  [ldrugsell,"Sell LSD",dummyobj,dummyobj,_emptyshop,_dsl,true, "shopdialogs.sqf"],
  [hdrugsell,"Sell Heroin",dummyobj,dummyobj,_emptyshop,_dsh,true, "shopdialogs.sqf"],
  [copair,"Police Air-Vehicle Shop",dummyobj, [cairspawn_0],_ca,_ca,true, "shopdialogs.sqf"],
  [copcar,"Police vehicle Shop",dummyobj, [ccarspawn_0, ccarspawn_1, ccarspawn_2, ccarspawn_3],_cv,_cv,true, "shopdialogs.sqf"],
  [swatcar,"Swat Vehicle Shop",dummyobj, [scarspawn],_sv,_sv,true, "shopdialogs.sqf"],
  [tdoc,"Doctor",dummyobj,dummyobj,_td,_td,false, "shopdialogs.sqf"],
  [copbasic,"Police Shop",copbasicbox,dummyobj, _copshop,_copshop,false, "shopdialogs.sqf"],
  [coppatrol,"Patrol-Officer",coppatrolbox,dummyobj,_copshop_patrol,_copshop_patrol,true, "shopdialogs.sqf"],
  [copcriminal,"Criminal Response-Officer",copcriminalbox,dummyobj,_copshop_response,_copshop_response,true, "shopdialogs.sqf"],
  [copswat,"Swat Weapons Officer",copswatbox,dummyobj,_copshop_swat,_copshop_swat,true, "shopdialogs.sqf"],
  [copswatE,"Swat Equipment Officer",copswatEbox,dummyobj,_copshop_swatE,_copshop_swatE,true, "shopdialogs.sqf"],
  [carshop1,"Car Shop 1",dummyobj,[carspawn1_0,carspawn1_1,carspawn1_2,carspawn1_3,carspawn1_4,carspawn1_5],_cs1,_cs1,true, "shopdialogs.sqf"],
  [carshop2,"Car Shop 2",dummyobj,[carspawn2_0,carspawn2_1,carspawn2_2,carspawn2_3,carspawn2_4,carspawn2_5],_cs2,_cs2,true, "shopdialogs.sqf"],
  [carshop3,"Car Shop 3",dummyobj,[carspawn3_0,carspawn3_1,carspawn3_2,carspawn3_3],_cs3,_cs3,true, "shopdialogs.sqf"],
  [bmshop,"BlackMarket Gun Shop",bmgunbox,dummyobj,_blackmarket,_blackmarket,true, "shopdialogs.sqf"],
  [bmshopair,"BlackMarket Air-Vehicle Shop",dummyobj,[bmairspawn],_blackmarket_air,_blackmarket_air,true, "shopdialogs.sqf"],
  [bmshopveh,"BlackMarket Vehicle Shop",dummyobj,[bmvehspawn_0, bmvehspawn_1, bmvehspawn_2, bmvehspawn_3],_blackmarket_veh,_blackmarket_veh,true, "shopdialogs.sqf"],
  [jailbike,"Jail Bike Shop",dummyobj,[jailbikespawn_0,jailbikespawn_1],_jailbike,_jailbike,true, "shopdialogs.sqf"],
  [busshop,"Bus Station Shop",dummyobj,[busspawn_0, busspawn_1, busspawn_2, busspawn_3],_bus,_bus,true, "shopdialogs.sqf"],
  [hornnpc,"Horn Shop",dummyobj,dummyobj,_hornshop,_hornshop,true, "shopdialogs.sqf"],
  [chairnpc,"Chair Shop",dummyobj,dummyobj,_chairshop,_chairshop,true, "shopdialogs.sqf"],
  [terrornpc,"Terror Shop",terrorbox,dummyobj,_terrorshop,_terrorshop,true, "shopdialogs.sqf"],
  [terrorveh,"Terror Vehicle Shop",dummyobj,[terrorvehspawn],_terrorveh,_terrorveh,true, "shopdialogs.sqf"],
  [bagshop,"Bag Shop",dummyobj,dummyobj,dummyobj,dummyobj,true, "bagshop.sqf"],
  [lottoshop,"Lottery",dummyobj,dummyobj,dummyobj,dummyobj,true, "lottodialog.sqf"],
  [shop1export,"Market Export 1",dummyobj,dummyobj,dummyobj,dummyobj,true, "shopdialogs.sqf"],
  [shop2export,"Market Export 2",dummyobj,dummyobj,dummyobj,dummyobj,true, "shopdialogs.sqf"],
  [shop3export,"Market Export 3",dummyobj,dummyobj,dummyobj,dummyobj,true, "shopdialogs.sqf"],
  [shop4export,"Market Export 4",dummyobj,dummyobj,dummyobj,dummyobj,true, "shopdialogs.sqf"],
  [taxi1,"Taxi Missions",dummyobj,dummyobj,dummyobj,dummyobj,true, "gc\client\GC_InformScrollUsage.sqf"],
  [delivery1,"Post Office",dummyobj,dummyobj,dummyobj,dummyobj,true, "gc\client\GC_InformScrollUsage.sqf"]
];

shopusearray = [];
{shopusearray = shopusearray + [(_x select 0)];} foreach INV_ItemShops;