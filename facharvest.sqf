_weaponfactory = [
	"M9","Rnd_9x19_M9",
	"M9SD","Rnd_9x19_M9SD",
	"Makarov","Rnd_9x18_Makarov",
	"revolver_EP1","Rnd_45ACP",
	"LeeEnfield","x_303",
	"M14_EP1","Rnd_762x51_DMR",
	"AA12_PMC","Rnd_B_AA12_Pellets","Rnd_B_AA12_74Slug",
	"Saiga12K","Rnd_B_Saiga12_74Slug","Rnd_B_Saiga12_Pellets",
	"FN_FAL","FN_FAL_ANPVS4","Rnd_762x51_FNFAL",
	"m8_compact_pmc","m8_carbine_pmc","Rnd_556x45_G36",
	"NVGoggles"
];

_vehiclefactory = [
	"Old_moto_TK_Civ_EP1",
	"TT650_TK_CIV_EP1",
	"TT650_Ins",
	"TT650_Gue",
	"ATV_CZ_EP1",
	"Skoda",
	"SkodaBlue",
	"SkodaGreen",
	"SkodaRed",
	"Volha_1_TK_CIV_EP1",
	"Volha_2_TK_CIV_EP1",
	"car_sedan",
	"Lada1_TK_CIV_EP1",
	"Lada2_TK_CIV_EP1",
	"Lada1",
	"Lada2",
	"car_hatchback",
	"S1203_TK_CIV_EP1",
	"datsun1_civil_1_open",
	"datsun1_civil_2_covered",
	"datsun1_civil_3_open",
	"hilux1_civil_3_open_EP1",
	"hilux1_civil_1_open",
	"hilux1_civil_2_covered",
	"UAZ_Unarmed_TK_CIV_EP1",
	"UAZ_Unarmed_UN_EP1",
	"VWGolf",
	"LandRover_TK_CIV_EP1",
	"BAF_Offroad_D",
	"LandRover_CZ_EP1",
	"Ural_TK_CIV_EP1",
	"Ural_UN_EP1",
	"V3S_Open_TK_CIV_EP1",
	"V3S_TK_GUE_EP1",
	"MTVR",
	"MTVR_DES_EP1"
];

_airfac = [
    "TowingTractor",
	"Mi17_Civilian",
	"An2_1_TK_CIV_EP1",
	"An2_2_TK_CIV_EP1",
	"An2_TK_EP1",
	"AH6X_EP1"
];

_itemfactory = [
	"Binocular",
	"NVGoggles",
	"GPS",
	"reparaturkit",
	"kleinesreparaturkit",
	"kanister",
	"lockpick",
	"medikit",
	"fishingpole",
	"Shovel",
	"Pickaxe",
	"JackHammer",
	"caralarm",
	"bunnyhop",
	"fireworks",
	"GasMask",
	"nitro",
	"supgrade1",
	"supgrade2"
];

//_bmfactory = ["GAZ_Vodnik", "Ural_ZU23_TK_EP1", "T34_TK_EP1"];

_alcoholfactory = ["beer","beer2","vodka","smirnoff","whiskey","wine","wine2"];

_ringfactory = ["Diamondring","EDiamondring","Platinumring","EPlatinumring"];

_furnace = ["steel"];

weaponqueue 	= [];
vehiclequeue  	= [];
itemqueue 	= [];
//bmvehiclequeue	= [];
alcoholfactoryqueue  = [];
diamondqueue = [];
furnacequeue = [];
airqueue = [];
INV_ItemFabriken = [
	[Vehiclefactory,"factory1","Vehicle Factory",dummyobj,vfacspawn_0,_vehiclefactory,50000,"Fabrikablage1", "vehiclequeue"],
	[ItemFabrik_1,"factory3","General Factory",igunbox,dummyobj,_itemfactory,50000,"Fabrikablage3", "itemqueue"],
  [weaponfactory,"factory4","Weapon Factory",wfgunbox,dummyobj,_weaponfactory,70000,"Fabrikablage4", "weaponqueue"],
  [airfactory,"factory5","Air Factory",dummyobj,airfacspawn,_airfac,75000,"Fabrikablage5", "airqueue"],
	//[bmfactory,"factory6","Black Market Vehicle Factory",dummyobj,bmfacspawn,_bmfactory,200000,"Fabrikablage6", "bmvehiclequeue"],
	//[alcoholfactory,"factory7","Alcohol Factory",dummyobj,dummyobj,_alcoholfactory,10000,"Fabrikablage7", "alcoholfactoryqueue"],
	[ringfactory,"factory9","Ring Factory",dummyobj,dummyobj,_ringfactory,25000,"Fabrikablage9","diamondqueue"],
	[Furnace,"factory10","Furnace",dummyobj,dummyobj,_furnace,25000,"Fabrikablage10","furnacequeue"]
];

INV_Fabrikowner = [];

INV_FarmItemArray = [
	[[["fishingwhale",400]],"Whale",2,1,["Ship"]],
	[[["fishingbass",400]],"bass",7,4,["Ship"]],
	[[["fishingblowfish",200]],"blowfish",15,8,["Ship"]],
	[[["fishingherring",200]],"herring",15,8,["Ship"]],
	[[["fishingmackerel",200]],"mackerel",15,8,["Ship"]],
	[[["cocafield",30]],"Unprocessed_cocaine",15,4,["Man"]],
	[[["marifield",30]],"Unprocessed_marijuana",15,7,["Man"]],
	[[["lsdfield",30]],"Unprocessed_lsd",15,4,["Man"]],
	[[["heroinfield",30]],"Unprocessed_heroin",15,4,["Man"]],
	[[["farmarea1",70]],"getreide",20,10,["tractor"]],
	[[["farmarea2",70]],"getreide",20,10,["tractor"]],
	[[["farmarea3",70]],"getreide",20,10,["tractor"]],
	[[["grapefield",30]],"Grapes",15,6,["Man"]],
	[[["hopsfield",30]],"Hops",15,6,["Man"]],
	[[["barleyfield",30]],"Barley",15,6,["Man"]],
	[[["ryefield",30]],"Rye",15,6,["Man"]]
];

Miningarray = [
	[["OilArea1",15],"Oil",12],
	[["OilArea2",15],"Oil",12],
	[["OilArea3",15],"Oil",12],
	[["IronArea",15],"iron",12],
	[["CopperArea",15],"copper",12],
	[["GlassArea",30],"glass",12],
	[["GoldArea",15],"Gold",12],
	[["DiamondArea",15],"Diamond rock",15],
	[["SilverArea",15],"Silver",15],
	[["RubiesArea",15],"Rubies",15],
	[["PlatinumArea",15],"Platinum",10],
	[["SiliconArea",30],"silicon",12],
	[["BlackPowderArea",30],"black powder",12],
	[["WoodArea",30],"wood",12],
	[["CoalArea",30],"coal",12]
];

fishingarray = [
	[["bassarea",30], "bass",12],
	[["percharea",30], "perch",12],
	[["walleyearea",30], "walleye",12],
	[["troutarea",30], "trout",12]
];