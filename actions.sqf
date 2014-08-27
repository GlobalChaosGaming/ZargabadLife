 _role = player;
//====================================== HQ BOMB ======================================================
action1 =	_role addaction ["Defuse bomb","noscript.sqf",'if(planting)exitwith{};planting=true;player playmove "AinvPknlMstpSlayWrflDnon_medic";sleep 4;waituntil {animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};planting=false;if(!alive player)exitwith{};bombactive=false;publicvariable "bombactive";"hint ""The bomb has been defused!"";server globalchat ""The bomb has been defused!"";playsound ""fanfare"";" call broadcast;',1,false,true,"","player distance HQ <= 5 and iscop and bombactive and !planting"];
action2 =	_role addaction ["Plant bomb","noscript.sqf",'if(planting)exitwith{};planting=true;publicvariable "planting";player playmove "AinvPknlMstpSlayWrflDnon_medic";sleep 4;waituntil {animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};planting=false;publicvariable "planting";if(!alive player)exitwith{};bombactive=true;publicvariable "bombactive";',1,false,true,"","player distance HQ <= 5 and !bombactive and !planting and isciv"];
//==================================== GANG MENU ======================================================
action3 =	_role addaction ["Gang Menu","maindialogs.sqf",["gangmenu"],1,false,true,"","player distance rathaus <= 3 and isciv"];
//====================================== BANK ROB =====================================================
action4 =	_role addaction ["Rob safe","bankrob.sqf", ["ausrauben", safe1],1,false,true,"","player distance safe1 <= 1.90 and isciv"];
action5 =	_role addaction ["Rob safe","bankrob.sqf", ["ausrauben", safe2],1,false,true,"","player distance safe2 <= 1.90 and isciv"];
action6 =	_role addaction ["Rob safe","bankrob.sqf", ["ausrauben", safe3],1,false,true,"","player distance safe3 <= 1.90 and isciv"];
//==================================== HOLSTER PISTOL =================================================
//_role addaction ["Holster Pistol","noscript.sqf",'["animation", "holsterpistol"] execVM "holsterscript.sqf";',1,false,true,"",'(player hasweapon "m9" or player hasweapon "Colt1911" or player hasweapon "revolver_EP1" or player hasweapon "Makarov") and !noholster'];
//==================================== HOLSTER RIFLE ==================================================
//action7 = 	_role addaction ["Holster Rifle","\noscript.sqf",[""],1,false,true,"",'player distance workplacejob_deliveryflag3 <= 4'];
//===================================== ASSASSINATION =================================================
action8 = 	_role addaction ["Get assassination job","assassination.sqf",["getajob_assassin"],1,false,true,"","player distance assassin <= 3 and isciv"];
action9 =   _role addaction ["Escort VIP", "noscript.sqf", "[VIPtarget] join (group player); player groupchat ""escort the VIP to the police base before he is assassinated!"";",1,false,true,"","player distance VIPtarget < 5 and iscop"];
//========================================= HUNTING ===================================================
action10 =  _role addaction ["Harvest Boar","harvestAnimal.sqf","boar",1,true,true,"",'_w = (nearestobjects [player, ["wildboar"],  3] select 0) getvariable "inuse"; isnil "_w" and player distance (nearestobjects [ player, ["wildboar"],  3] select 0) < 5 and !alive (nearestobjects [player, ["wildboar"],  3] select 0)'];
action11 =  _role addaction ["Harvest Cow","harvestAnimal.sqf","cow",1,true,true,"",'_w = (nearestobjects [player, ["Cow01"],  3] select 0) getvariable "inuse"; isnil "_w" and player distance (nearestobjects [player, ["Cow01"],  3] select 0) < 5 and !alive (nearestobjects [player, ["Cow01"],  3] select 0)'];
action12 = 	_role addaction [localize "STRS_workplacemission_addaction_searchjob","search.sqf",["getajob_search"],1,false,true,"","(((player distance workplace_getjobflag_1 <= 5) or (player distance workplace_getjobflag_2 <= 5) or (player distance workplace_getjobflag_3 <= 5)) and isciv and alreadygotaworkplacejob != 2)"];
//=================================== COP RECRUITMENT =================================================
action13 = _role addaction [format["Restore Kord MG ($%1)", MGcost],"recruitai.sqf","MG1",1,false,true,"","_gunner = gunner MG1; player distance recruitai <= 5 and (!alive _gunner or isnull _gunner or !alive MG1)"];
action14 = _role addaction [format["Restore Kord MG ($%1)", MGcost],"recruitai.sqf","MG2",1,false,true,"","_gunner = gunner MG2; player distance recruitai <= 5 and (!alive _gunner or isnull _gunner or !alive MG2)"];
action15 = _role addaction [format["Restore Kord MG ($%1)", MGcost],"recruitai.sqf","MG3",1,false,true,"","_gunner = gunner MG3; player distance recruitai <= 5 and (!alive _gunner or isnull _gunner or !alive MG3)"];
action16 = _role addaction [format["Restore Kord MG ($%1)", MGcost],"recruitai.sqf","MG4",1,false,true,"","_gunner = gunner MG4; player distance recruitai <= 5 and (!alive _gunner or isnull _gunner or !alive MG4)"];
action17 = _role addaction [format["Restore PK NEST ($%1)", PKcost],"recruitai.sqf","PK1",1,false,true,"","_gunner = gunner PK1; player distance recruitai <= 5 and (!alive _gunner or isnull _gunner or !alive PK1)"];
action18 = _role addaction [format["Restore PK NEST ($%1)", PKcost],"recruitai.sqf","PK2",1,false,true,"","_gunner = gunner PK2; player distance recruitai <= 5 and (!alive _gunner or isnull _gunner or !alive PK2)"];
action19 = _role addaction [format["Restore PK NEST ($%1)", PKcost],"recruitai.sqf","PK3",1,false,true,"","_gunner = gunner PK3; player distance recruitai <= 5 and (!alive _gunner or isnull _gunner or !alive PK3)"];
action20 = _role addaction [format["Restore PK NEST ($%1)", PKcost],"recruitai.sqf","PK4",1,false,true,"","_gunner = gunner PK4; player distance recruitai <= 5 and (!alive _gunner or isnull _gunner or !alive PK4)"];
//_role addaction [format["Recruit Squad ($%1)", SQUADcost],"recruitai.sqf","SQUAD",1,false,true,"","player distance recruitai <= 5"];
//===================================== IMPOUND AREA ==================================================
action21 = _role addaction ["Impound Lot","maindialogs.sqf",["impound"],1,false,true,"","player distance impoundbuy <= 5"];
action22 = _role addaction ["Impound Lot","maindialogs.sqf",["impound"],1,false,true,"","player distance copcar <= 5"];
//======================= HELO IMPOUND =======================
action39 = _role addaction ["Helo Impound Lot","maindialogs.sqf",["impound2"],1,false,true,"","player distance impoundbuy2 <= 5"];
action40 = _role addaction ["Helo Impound Lot","maindialogs.sqf",["impound2"],1,false,true,"","player distance copair <= 5"];
//================================== COP DELETE EVIDENCE ================================================
action23 = _role addaction ["Take evidence","noscript.sqf",'player groupchat "evidence removed."; {deletevehicle _x} foreach (nearestobjects [player, ["weaponholder"], 3])',1,true,true,"",'_weps = (nearestobjects [player, ["weaponholder"], 3] select 0); player distance _weps < 5 and iscop and !isStunned;'];
action38 = _role addaction ["Disarm bomb","noscript.sqf",'player playmove "AinvPknlMstpSlayWrflDnon_medic";sleep 4;waituntil {sleep 0.1; animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};player groupchat "Bomb disarmed and disposed of."; {deletevehicle _x} foreach (nearestobjects [player, ["SatPhone","Explosive"], 3])',1,true,true,"",'_weps = (nearestobjects [player, ["SatPhone","Explosive"], 3] select 0); player distance _weps < 5 and iscop and !isStunned;'];
//================================== COP PROSTITUTE ACTIONS =============================================
action24 = _role addaction ["Who is your pimp?","noscript.sqf",'player groupchat format["this prostitute works for %1.", leader (nearestobjects [player, civprostitutearray,  3] select 0)]',1,true,true,"",'_slave = (nearestobjects [player, civprostitutearray, 3] select 0); !(_slave in playerarray) and player distance _slave < 5 and (leader _slave) in playerarray and iscop'];
action25 = _role addaction ["Set prostitute free","noscript.sqf",'_slave = (nearestobjects [player, civprostitutearray,  3] select 0); _civ = leader _slave; deletevehicle _slave; (format ["[""Prostitute"", %1] spawn Isse_AddCrimeLogEntry; if(!(""being a pimp"" in %1_reason))then{%1_reason = %1_reason + [""being a pimp""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 20000;", _civ]) call broadcast;player groupchat "the prostitute has been freed!";',1,true,true,"",'_slave = (nearestobjects [player, civprostitutearray, 3] select 0); !(_slave in playerarray) and player distance _slave < 5 and (leader _slave) in playerarray and iscop'];
//==================================== OBJECT ACTIONS =================================================
action89 = _role addaction ["Remove Searchlight","noscript.sqf",'if (((call INV_GetOwnWeight) + ("SearchLight_UN_EP1" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["SearchLight_UN_EP1"], 3] select 0);["SearchLight_UN_EP1", 1] call INV_AddInventoreItem;player groupchat "you picked up a searchlight";',1,true,true,"",'_light = (nearestobjects [player, ["SearchLight_UN_EP1"],  3] select 0); !(_light in speedcamarray) and player distance _light < 5 and iscop'];
action26 = _role addaction ["Remove Roadblock","noscript.sqf",'if (((call INV_GetOwnWeight) + ("roadblock" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["Land_CncBlock_Stripes"],  3] select 0);["roadblock", 1] call INV_AddInventoreItem;player groupchat "you picked up a roadblock";',1,true,true,"",'player distance (nearestobjects [player, ["Land_CncBlock_Stripes"],  3] select 0) < 5 and iscop'];
action27 = _role addaction ["Remove Bargate","noscript.sqf",'if (((call INV_GetOwnWeight) + ("Bargate" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["ZavoraAnim"],  10] select 0);["Bargate", 1] call INV_AddInventoreItem;player groupchat "you picked up a bargate";',1,true,true,"",'player distance (nearestobjects [player, ["ZavoraAnim"],  10] select 0) < 7 and iscop'];
action28 = _role addaction ["Remove Road Cone","noscript.sqf",'if (((call INV_GetOwnWeight) + ("roadcone" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["Land_coneLight"],  3] select 0);["roadcone", 1] call INV_AddInventoreItem;player groupchat "you picked up a road cone";',1,true,true,"",'player distance (nearestobjects [player, ["Land_coneLight"],  3] select 0) < 5 and iscop'];
action92 = _role addaction ["Remove KORD Static","noscript.sqf",'if (((call INV_GetOwnWeight) + ("KORD_high" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["KORD_high"],  3] select 0);["KORD_high", 1] call INV_AddInventoreItem;player groupchat "you picked up a KORD Static";',1,true,true,"",'player distance (nearestobjects [player, ["KORD_high"],  3] select 0) < 5'];
action91 = _role addaction ["Remove M2 Static","noscript.sqf",'if (((call INV_GetOwnWeight) + ("M2StaticMG_US_EP1" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["M2StaticMG_US_EP1"],  3] select 0);["M2StaticMG_US_EP1", 1] call INV_AddInventoreItem;player groupchat "you picked up a M2 Static";',1,true,true,"",'player distance (nearestobjects [player, ["M2StaticMG_US_EP1"],  3] select 0) < 5 and iscop'];
action29 = _role addaction ["Open/close gate","noscript.sqf",'_gate = (nearestobjects [player, ["ZavoraAnim"],  10] select 0); if(_gate animationPhase "bargate" == 1)then{_gate animate ["bargate", 0]}else{_gate animate ["bargate", 1]};',1,true,true,"",'player distance (nearestobjects [player, ["ZavoraAnim"],  10] select 0) < 7 and iscop'];
action30 = _role addaction ["Open/close gate","noscript.sqf",'_gate = (nearestobjects [player, ["ZavoraAnim"],  10] select 0); if(_gate animationPhase "bargate" == 1)then{_gate animate ["bargate", 0]}else{_gate animate ["bargate", 1]};',1,true,true,"",'player distance (nearestobjects [player, ["ZavoraAnim"],  10] select 0) < 7 and isciv'];
action31 = _role addaction ["Remove Big bag fence (corner)","noscript.sqf",'if (((call INV_GetOwnWeight) + ("BigbagfenceCorner" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["Land_fort_bagfence_corner"],  3] select 0);["BigbagfenceCorner", 1] call INV_AddInventoreItem;player groupchat "you picked up a sandbag wall (corner)";',1,true,true,"",'player distance (nearestobjects [player, ["Land_fort_bagfence_corner"],  3] select 0) < 5'];
action43 = _role addaction ["Remove Hbarrier","noscript.sqf",'if (((call INV_GetOwnWeight) + ("Hbarrier" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["Land_HBarrier5"],  3] select 0);["Hbarrier", 1] call INV_AddInventoreItem;player groupchat "you picked up a HBarrier";',1,true,true,"",'player distance (nearestobjects [player, ["Land_HBarrier5"],  3] select 0) < 5 and iscop'];
action32 = _role addaction ["Remove Big bag fence","noscript.sqf",'if (((call INV_GetOwnWeight) + ("bigbagfence" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["Land_fort_bagfence_long"],  3] select 0);["bigbagfence", 1] call INV_AddInventoreItem;player groupchat "you picked up a sandbag wall";',1,true,true,"",'player distance (nearestobjects [player, ["Land_fort_bagfence_long"],  3] select 0) < 5 and player distance terrornpc > 30'];
action33 = _role addaction ["Remove Big bag fence (round)","noscript.sqf",'if (((call INV_GetOwnWeight) + ("bigbagfenceRound" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["Land_fort_bagfence_round"],  3] select 0);["bigbagfenceRound", 1] call INV_AddInventoreItem;player groupchat "you picked up a sandbag wall (round)";',1,true,true,"",'player distance (nearestobjects [player, ["Land_fort_bagfence_round"],  3] select 0) < 5 and player distance terrornpc > 30'];
//action34 = _role addaction ["Remove Bunker (small)","noscript.sqf",'if (((call INV_GetOwnWeight) + ("bunkersmall" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["Land_fortified_nest_small"],  3] select 0);["bunkersmall", 1] call INV_AddInventoreItem;player groupchat "you picked up a bunker (small)";',1,true,true,"",'player distance (nearestobjects [player, ["Land_fortified_nest_small"],  3] select 0) < 5'];
action35 = _role addaction ["Remove Danger Sign","noscript.sqf",'if (((call INV_GetOwnWeight) + ("danger" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["Sign_Danger"],  3] select 0);["danger", 1] call INV_AddInventoreItem;player groupchat "you picked up a danger sign";',1,true,true,"",'player distance (nearestobjects [player, ["Sign_danger"],  3] select 0) < 5'];
action36 = _role addaction ["Remove Factory","noscript.sqf",'if (((call INV_GetOwnWeight) + ("factory" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["Land_A_GeneralStore_01a"],  3] select 0);["factory", 1] call INV_AddInventoreItem;player groupchat "you picked up a factory";',1,true,true,"",'player distance (nearestobjects [player, ["Land_A_GeneralStore_01a"],  3] select 0) < 5 and isciv'];
action37 = _role addaction ["Remove Office Building","noscript.sqf",'if (((call INV_GetOwnWeight) + ("officebuilding" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["land_A_Office01"],  3] select 0);["officebuilding", 1] call INV_AddInventoreItem;player groupchat "you picked up a officebuilding";',1,true,true,"",'player distance (nearestobjects [player, ["Land_A_office01"],  3] select 0) < 5 and isciv'];
//action38 = _role addaction ["Remove Barrack","noscript.sqf",'if (((call INV_GetOwnWeight) + ("barrack" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [player, ["land_Barrack2"],  3] select 0);["barrack", 1] call INV_AddInventoreItem;player groupchat "you picked up a barrack";',1,true,true,"",'player distance (nearestobjects [player, ["Land_Barrack2"],  3] select 0) < 5 and isciv'];
//==================================== REPAIR POWER ===================================================
action41 = _role addaction [format["Restore Power 1 ($%1)", powerrestorecost],"noscript.sqf",'_cash = "cash" call INV_GetItemAmount; if(_cash < powerrestorecost)exitwith{player groupchat "you do not have enough money"};["cash", -(powerrestorecost)] call INV_AddInventoreItem; "power1 setdamage 0" call broadcast',1,false,true,"","player distance power1 <= 7 and !alive power1 and iscop"];
action42 = _role addaction [format["Restore Power 2 ($%1)", powerrestorecost],"noscript.sqf",'_cash = "cash" call INV_GetItemAmount; if(_cash < powerrestorecost)exitwith{player groupchat "you do not have enough money"};["cash", -(powerrestorecost)] call INV_AddInventoreItem; "power2 setdamage 0" call broadcast',1,false,true,"","player distance power2 <= 7 and !alive power2 and iscop"];
action45 = _role addaction ["Turn off intro music","noscript.sqf",'deletevehicle intromusic_obj; intromusic_obj=objnull;',1,true,true,"",'(!(isnull intromusic_obj) and (player distance copbasesign <= 10 or player distance intromusic_obj <= 20))'];
//===================================== CONVOY CASH ===================================================
stealConvoy = _role addaction ["Steal police payroll","noscript.sqf",'convoyhascash=false; publicvariable "convoyhascash"; _cash = (playersNumber west)*10000; if(_cash < 100000) then {_cash = 100000}; ["cash", _cash] call INV_AddInventoreItem; player groupchat format["You stole $%1!", _cash];',1,false,true,"","_driver = driver convoytruck; player distance convoytruck <= 7 and convoyhascash and isciv and (!alive _driver or isnull _driver)"];
//===================================== BUY HIDEOUT ===================================================
//_role addaction [format["Buy Hideout ($%1)", hideoutcost],"noscript.sqf",'if("cash" call INV_GetItemAmount < hideoutcost)exitwith{player groupchat "not enough money"};["cash", -hideoutcost] call INV_AddInventoreItem;["hideout", 1] call INV_AddInventoreItem;player groupchat format["you bought a hideout for $%1", hideoutcost];',1,false,true,"","player distance rathaus <= 3 and isciv"];
//===================================== BUY INSURANCE ===================================================
action47 = _role addaction [format["Buy bank insurance ($%1)", ("bankversicherung" call INV_getitemBuyCost)],"noscript.sqf",'if("cash" call INV_GetItemAmount < ("bankversicherung" call INV_getitemBuyCost))exitwith{player groupchat "not enough money"};doingSomething = true;["cash", -("bankversicherung" call INV_getitemBuyCost)] call INV_AddInventoreItem;["bankversicherung", 1] call INV_AddInventoreItem;player groupchat format["you bought bank insurance for $%1", ("bankversicherung" call INV_getitemBuyCost)];doingSomething = false;',1,false,true,"","(player distance mainbank <= 3) and !doingSomething"];
//======================================= CRIMELOG ====================================================
action48 = _role addaction ["Crime Log","maindialogs.sqf",["coplog"],1,false,true,"","player distance rathaus <= 3"];
//======================================== PROSTITUTES =================================================
action49 = _role addaction [format ["Buy prostitute ($%1)", prostitute_cost],"prostitute.sqf", ["Prostitute"],1,false,true,"","player distance prostituteflag <= 5 and isciv"];
//==================================== PRIVATE STORAGE ================================================
action50 = _role addaction ["Private storage (saved)","storage.sqf",["private_storage", "save"],1,false,true,"","player distance storage < 3.4"];
action34 = _role addaction ["Private storage (saved)","storage.sqf",["private_storage", "save"],1,false,true,"","player distance storage_2 < 3.4"];
//========================================= BAIL ======================================================
action51 = _role addaction ["Pay bail","maindialogs.sqf", ["bail"],1,false,true,"","player distance bailflag <= 5 and isciv"];
//===================================== ITEM PROCESS ==================================================
action52 = _role addaction ["Refine diamond rocks into rings","itemprocess.sqf",["Diamond rock", "Diamondring", 12, "diamond"],1,false,true,"","player distance Diamond_1 <= 5 and isciv"];
action53 = _role addaction ["Process Oil","itemprocess.sqf",["Oil", "OilBarrel", 10, "oil"],1,false,true,"","player distance Oil_1 <= 5 and isciv"];
action54 = _role addaction ["Process Wheat","itemprocess.sqf",["getreide", "Bread", 2, "Baker"],1,false,true,"","player distance Bakery_1 <= 5 and isciv"];
//ga1
action55 = _role addaction ["Process LSD","itemprocess.sqf",["Unprocessed_LSD", "lsd", 5, "lsd ga1"],1,false,true,"","_control = gangarea1 getvariable ""control"";!isnil ""_control"" and player distance gangshop1 <= 5 and (_control == (call INV_mygang))"];
action56 = _role addaction ["Process Cocaine","itemprocess.sqf",["Unprocessed_Cocaine", "cocaine", 5, "cocaine ga1"],1,false,true,"","_control = gangarea1 getvariable ""control"";!isnil ""_control"" and player distance gangshop1 <= 5 and (_control == (call INV_mygang))"];
//ga2
action57 = _role addaction ["Process LSD","itemprocess.sqf",["Unprocessed_LSD", "lsd", 5, "lsd ga2"],1,false,true,"","_control = gangarea2 getvariable ""control"";!isnil ""_control"" and player distance gangshop2 <= 5 and (_control == (call INV_mygang))"];
action58 = _role addaction ["Process Heroin","itemprocess.sqf",["Unprocessed_Heroin", "heroin", 5, "heroin ga2"],1,false,true,"","_control = gangarea2 getvariable ""control"";!isnil ""_control"" and player distance gangshop2 <= 5 and (_control == (call INV_mygang))"];
//ga3
action59 = _role addaction ["Process Heroin","itemprocess.sqf",["Unprocessed_Heroin", "heroin", 5, "heroin ga3"],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance gangshop3 <= 5 and (_control == (call INV_mygang))"];
action60 = _role addaction ["Process Marijuana","itemprocess.sqf",["Unprocessed_Marijuana", "marijuana", 5, "marijuana ga3"],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance gangshop3 <= 5 and (_control == (call INV_mygang))"];
//alcohol
processGrapes = _role addaction ["Ferment Grapes into Wine","itemprocess.sqf",["Grapes", "wine", 3, ""],1,false,true,"","!isCop and player distance grapeprocess <= 5"];
processHops = _role addaction ["Brew Hops into Beer","itemprocess.sqf",["Hops", "beer2", 3, ""],1,false,true,"","!isCop and player distance hopsprocess <= 5"];
processBarley = _role addaction ["Distill Barley into Vodka","itemprocess.sqf",["Barley", "vodka", 3, ""],1,false,true,"","!isCop and player distance barleyprocess <= 5"];
processRye = _role addaction ["Distill Rye into Whiskey","itemprocess.sqf",["Rye", "whiskey", 3, ""],1,false,true,"","!isCop and player distance ryeprocess <= 5"];
//======================================= WORKPLACE ====================================================
action61 = _role addaction ["Get Delivery Job","delivery.sqf", ["getajob_delivery"],1,false,true,"","(player distance delivery1 <= 5) and isciv"];
action62 = _role addaction ["Cancel Delivery Job","delivery.sqf", ["cancel"],1,false,true,"","(player distance delivery1 <= 5) and isciv and alreadygotaworkplacejob == 1"];
action63 = _role addaction ["Get Taxi Job","taxi.sqf", ["getajob_taxi"],1,false,true,"","(player distance taxi1 <= 7) and isciv"];
action64 = _role addaction ["Finish Taxi Job","taxi.sqf", ["canceljob_taxi"],1,false,true,"","(player distance taxi1 <= 5 ) and isciv and workplacejob_taxi_active"];
action65 = _role addaction [format [localize "STRS_addAction_buy_shop", (BuyAbleBuildingsArray select 0) select 1, (BuyAbleBuildingsArray select 0) select 3],"buyshop.sqf", ["immobilie", 0],1,false,true,"","player distance ((BuyAbleBuildingsArray select 0) select 2) <= 5 and !(((BuyAbleBuildingsArray select 0) select 0) in BuildingsOwnerArray)"];
action66 = _role addaction [format [localize "STRS_addAction_buy_shop", (BuyAbleBuildingsArray select 1) select 1, (BuyAbleBuildingsArray select 1) select 3],"buyshop.sqf", ["immobilie", 1],1,false,true,"","player distance ((BuyAbleBuildingsArray select 1) select 2) <= 5 and !(((BuyAbleBuildingsArray select 1) select 0) in BuildingsOwnerArray)"];
action67 = _role addaction [format [localize "STRS_addAction_buy_shop", (BuyAbleBuildingsArray select 2) select 1, (BuyAbleBuildingsArray select 2) select 3],"buyshop.sqf", ["immobilie", 2],1,false,true,"","player distance ((BuyAbleBuildingsArray select 2) select 2) <= 5 and !(((BuyAbleBuildingsArray select 2) select 0) in BuildingsOwnerArray)"];
//====================================== VEHICLE ACTIONS ================================================
action68 = _role addaction [localize "STRS_addaction_trunk_see","noscript.sqf",'_vcl = (nearestobjects [player, ["Air", "Ship", "LandVehicle","Tank"], 4] select 0);_str = format["%1_storage", _vcl];[_str] execVM "vehiclecheck.sqf";',1,true,true,"",'_vcl = (nearestobjects [player, ["Air", "Ship", "LandVehicle","Tank"], 4] select 0);player distance _vcl < 5 and !(_vcl in INV_VehicleArray) and _vcl in INV_ServerVclArray and iscop'];
action69 = _role addaction [localize "STRS_addaction_trunk_check","noscript.sqf",'_vcl = (nearestobjects [player, ["Air", "Ship", "LandVehicle","Tank"], 4] select 0);_str = format["%1_storage", _vcl];if([_vcl,_str] call INV_RemoveIllegalStorage)then{call compile format["publicvariable ""%1"";", _str]};',1,true,true,"",'_vcl = (nearestobjects [player, ["Air", "Ship", "LandVehicle","Tank"], 4] select 0);player distance _vcl < 5 and !(_vcl in INV_VehicleArray) and _vcl in INV_ServerVclArray and iscop'];
action70 = _role addaction ["Impound vehicle","noscript.sqf",'_vcl = (nearestobjects [player, ["LandVehicle","Tank"], 4] select 0);  [_vcl, "impound"] execVM "impound.sqf";',1,true,true,"",'_vcl = (nearestobjects [player, ["LandVehicle","Tank"], 4] select 0);player distance _vcl < 5 and _vcl in INV_ServerVclArray and iscop'];
action71 = _role addaction ["Pull out","noscript.sqf",'(nearestobjects [player, ["Air", "Ship", "LandVehicle","Tank"], 4] select 0) execVM "pullout.sqf";',1,true,true,"",'_vcl = (nearestobjects [player, ["Air", "Ship", "LandVehicle","Tank"], 4] select 0);player distance _vcl < 5 and count (crew _vcl) > 0 and _vcl in INV_ServerVclArray and (call INV_isArmed)'];
action72 = _role addaction [localize "STRS_addAction_vehicleinfo","noscript.sqf",'(nearestobjects [player, ["Air", "Ship", "LandVehicle","Tank"], 4] select 0) execVM "vehinfo.sqf";',1,true,true,"",'_vcl = (nearestobjects [player, ["Air", "Ship", "LandVehicle","Tank"], 4] select 0);player distance _vcl < 5 and _vcl in INV_ServerVclArray'];
action44 = _role addaction ["Impound aircraft","noscript.sqf",'_vcl = (nearestobjects [player, ["Air"], 4] select 0); [_vcl, "impound2"] execVM "impound2.sqf";',1,true,true,"",'_vcl = (nearestobjects [player, ["Air"], 4] select 0);player distance _vcl < 5 and _vcl in INV_ServerVclArray and iscop'];
//======================================== GANG FLAGS ===================================================
action73 = _role addaction ["Neutralise flag","gangflags.sqf",[gangarea1, "neutralise"],1,false,true,"",'_control = gangarea1 getvariable "control";if(isnil "_control")then{_control = ""};player distance gangarea1 <= 8 and _control != (call INV_mygang) and _control != "" and gangmember and !takingFlag'];
action74 = _role addaction ["Neutralise flag","gangflags.sqf",[gangarea2, "neutralise"],1,false,true,"",'_control = gangarea2 getvariable "control";if(isnil "_control")then{_control = ""};player distance gangarea2 <= 8 and _control != (call INV_mygang) and _control != "" and gangmember and !takingFlag'];
action75 = _role addaction ["Neutralise flag","gangflags.sqf",[gangarea3, "neutralise"],1,false,true,"",'_control = gangarea3 getvariable "control";if(isnil "_control")then{_control = ""};player distance gangarea3 <= 8 and _control != (call INV_mygang) and _control != "" and gangmember and !takingFlag'];
action76 = _role addaction ["Capture flag","gangflags.sqf",[gangarea1, "capture"],1,false,true,"",'_control = gangarea1 getvariable "control";player distance gangarea1 <= 10 and isnil "_control" and gangmember and !takingFlag'];
action77 = _role addaction ["Capture flag","gangflags.sqf",[gangarea2, "capture"],1,false,true,"",'_control = gangarea2 getvariable "control";player distance gangarea2 <= 10 and isnil "_control" and gangmember and !takingFlag'];
action78 = _role addaction ["Capture flag","gangflags.sqf",[gangarea3, "capture"],1,false,true,"",'_control = gangarea3 getvariable "control";player distance gangarea3 <= 10 and isnil "_control" and gangmember and !takingFlag'];

//======================================== SHOP EXPORT ==================================================
_num1  = (shop1 call INV_getshopnum);
_num2  = (shop2 call INV_getshopnum);
_num3  = (shop3 call INV_getshopnum);
_num4  = (shop4 call INV_getshopnum);
action79 = _role addaction [format["%1", shop1export call INV_getItemShopName],"shopdialogs.sqf",[_num1],1,false,true,"","player distance shop1export <= 3"];
action80 = _role addaction [format["%1", shop2export call INV_getItemShopName],"shopdialogs.sqf",[_num2],1,false,true,"","player distance shop2export <= 3"];
action81 = _role addaction [format["%1", shop3export call INV_getItemShopName],"shopdialogs.sqf",[_num3],1,false,true,"","player distance shop3export <= 3"];
action82 = _role addaction [format["%1", shop4export call INV_getItemShopName],"shopdialogs.sqf",[_num4],1,false,true,"","player distance shop4export <= 3"];

//======================================= GANG GUNSHOPS ==================================================
_num1  = (gangarea1 call INV_getshopnum);
_num2  = (gangarea2 call INV_getshopnum);
_num3  = (gangarea3 call INV_getshopnum);
action83 = _role addaction [format["%1", gangarea1 call INV_getItemShopName],"shopdialogs.sqf",[_num1],1,false,true,"","_control = gangarea1 getvariable ""control"";!isnil ""_control"" and player distance gangshop1 <= 5 and (_control == (call INV_mygang))"];
action84 = _role addaction [format["%1", gangarea2 call INV_getItemShopName],"shopdialogs.sqf",[_num2],1,false,true,"","_control = gangarea2 getvariable ""control"";!isnil ""_control"" and player distance gangshop2 <= 5 and (_control == (call INV_mygang))"];
action85 = _role addaction [format["%1", gangarea3 call INV_getItemShopName],"shopdialogs.sqf",[_num3],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance gangshop3 <= 5 and (_control == (call INV_mygang))"];

//====================================== DRUG TRAFFICKING ===============================================
//_num1  = (gangarea1 call INV_getshopnum);
//_num2  = (gangarea2 call INV_getshopnum);
//_num3  = (gangarea3 call INV_getshopnum);
//_role addaction ["Drug Trafficking","shopdialogs.sqf",[_num1],1,false,true,"","_control = gangarea1 getvariable ""control"";!isnil ""_control"" and player distance gangarea1 <= 5 and isciv"];
//_role addaction ["Drug Trafficking","shopdialogs.sqf",[_num2],1,false,true,"","_control = gangarea2 getvariable ""control"";!isnil ""_control"" and player distance gangarea2 <= 5 and isciv"];
//_role addaction ["Drug Trafficking","shopdialogs.sqf",[_num3],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance gangarea3 <= 5 and isciv"];
//===================================== Store Robbing===============================================
{
  call compile format["rob%1 = _role addaction [""Rob Store"",""robthestations.sqf"",[%1],1,false,true,"""",""isciv and INV_isArmed and (%1money >= 5000) and (player distance %1 <= 3)""];", _x];
} forEach robbable;
//========================   unflip vehicle     ================================
action86 = _role addaction ["Unflip vehicle","unflipvehicle.sqf",["unflip"],1,false,true,"",'_vcl = (nearestobjects [player, ["Air", "Ship", "LandVehicle","Tank"], 4] select 0);player distance _vcl < 5 and _vcl in INV_VehicleArray'];
//=========================    Cop Patrol actions   ==============================
action87 = _role addaction["Get patrol mission","coppatrol.sqf",["start"],1,false,true,"","iscop and player distance copbank <= 4 and !pmissionactive and !patrolwaittime"];
action88 = _role addaction["Cancel patrol mission","coppatrol.sqf",["end"],1,false,true,"","iscop and pmissionactive and player distance copbank <= 4"];
//========================   HOSTAGE  ================================================
action89 = _role addaction ["Take hostage mission","hostage.sqf",["getajob_hostage"],1,false,true,"","player distance hostage <= 3 and isciv"];
action90 = _role addaction ["Take hostage", "noscript.sqf", "[hostage1] join (group player); player groupchat ""Keep the hostage close or you will fail!"";",1,false,true,"","player distance hostage1 < 5 and isciv"];
//=======================   Road Gates ==============================================
action94 = _role addaction ["Raise gates","gates.sqf",[2, "raise"],1,false,true,"","iscop and player distance copgate2 <= 4"];
action95 = _role addaction ["Lower gates","gates.sqf",[2, "lower"],1,false,true,"","iscop and player distance copgate2 <= 4"];
action96 = _role addaction ["Raise gates","gates.sqf",[3, "raise"],1,false,true,"","iscop and player distance copgate3 <= 4"];
action97 = _role addaction ["Lower gates","gates.sqf",[3, "lower"],1,false,true,"","iscop and player distance copgate3 <= 4"];
action98 = _role addaction ["Raise gates","gates.sqf",[4, "raise"],1,false,true,"","iscop and player distance copgate4 <= 4"];
action99 = _role addaction ["Lower gates","gates.sqf",[4, "lower"],1,false,true,"","iscop and player distance copgate4 <= 4"];
action100 = _role addaction ["Raise gates","gates.sqf",[5, "raise"],1,false,true,"","iscop and player distance copgate5 <= 4"];
action101 = _role addaction ["Lower gates","gates.sqf",[5, "lower"],1,false,true,"","iscop and player distance copgate5 <= 4"];
action103 = _role addaction ["Remove spike strip", "deletestrip1.sqf",[],1,false,true,"","iscop and player distance cop1Fort_Razorwire <= 4"];
action104 = _role addaction ["Remove spike strip", "deletestrip2.sqf",[],1,false,true,"","iscop and player distance cop2Fort_Razorwire <= 4"];
action105 = _role addaction ["Remove spike strip", "deletestrip3.sqf",[],1,false,true,"","iscop and player distance cop3Fort_Razorwire <= 4"];
action106 = _role addaction ["Remove spike strip", "deletestrip4.sqf",[],1,false,true,"","iscop and player distance cop4Fort_Razorwire <= 4"];
action107 = _role addaction ["Remove spike strip", "deletestrip5.sqf",[],1,false,true,"","iscop and player distance cop5Fort_Razorwire <= 4"];
action108 = _role addaction ["Remove spike strip", "deletestrip6.sqf",[],1,false,true,"","iscop and player distance cop6Fort_Razorwire <= 4"];
action109 = _role addaction ["Remove spike strip", "deletestrip7.sqf",[],1,false,true,"","iscop and player distance cop7Fort_Razorwire <= 4"];
action110 = _role addaction ["Remove spike strip", "deletestrip8.sqf",[],1,false,true,"","iscop and player distance cop8Fort_Razorwire <= 4"];
action111 = _role addaction ["Remove spike strip", "deletestrip9.sqf",[],1,false,true,"","iscop and player distance cop9Fort_Razorwire <= 4"];
action112 = _role addaction ["Remove spike strip", "deletestrip10.sqf",[],1,false,true,"","iscop and player distance cop10Fort_Razorwire <= 4"];
action113 = _role addaction ["Remove spike strip", "deletestrip11.sqf",[],1,false,true,"","iscop and player distance cop10Fort_Razorwire <= 4"];
action114 = _role addaction ["Remove spike strip", "deletestrip12.sqf",[],1,false,true,"","iscop and player distance cop10Fort_Razorwire <= 4"];
action115 = _role addaction ["Remove spike strip", "deletestrip13.sqf",[],1,false,true,"","iscop and player distance cop10Fort_Razorwire <= 4"];
action116 = _role addaction ["Remove spike strip", "deletestrip14.sqf",[],1,false,true,"","iscop and player distance cop10Fort_Razorwire <= 4"];
action117 = _role addaction ["Remove spike strip", "deletestrip15.sqf",[],1,false,true,"","iscop and player distance cop10Fort_Razorwire <= 4"];
action118 = _role addaction ["Remove spike strip", "deletestrip16.sqf",[],1,false,true,"","iscop and player distance cop10Fort_Razorwire <= 4"];
action119 = _role addaction ["Remove spike strip", "deletestrip17.sqf",[],1,false,true,"","iscop and player distance cop10Fort_Razorwire <= 4"];
action120 = _role addaction ["Remove spike strip", "deletestrip18.sqf",[],1,false,true,"","iscop and player distance cop10Fort_Razorwire <= 4"];
action121 = _role addaction ["Remove spike strip", "deletestrip19.sqf",[],1,false,true,"","iscop and player distance cop10Fort_Razorwire <= 4"];
action122 = _role addaction ["Remove spike strip", "deletestrip20.sqf",[],1,false,true,"","iscop and player distance cop10Fort_Razorwire <= 4"];
action123 = _role addaction ["Lower gates","gates.sqf",[2, "lower"],1,false,true,"","isciv and player distance copgate2 <= 4"];
action124 = _role addaction ["Lower gates","gates.sqf",[3, "lower"],1,false,true,"","isciv and player distance copgate3 <= 4"];
action125 = _role addaction ["Lower gates","gates.sqf",[4, "lower"],1,false,true,"","isciv and player distance copgate4 <= 4"];
action126 = _role addaction ["Lower gates","gates.sqf",[5, "lower"],1,false,true,"","isciv and player distance copgate5 <= 4"];
//======================= workplace radios =======================
action_radio1 = _role addaction ["Turn on Radio","gc\client\GC_Music.sqf", [radio1,0], 1, false, true, "", '_track = radio1 getvariable "track"; player distance radio1 <= 2 and isnil "_track"'];
action_radio2 = _role addaction ["Turn on Radio","gc\client\GC_Music.sqf", [radio2,0], 1, false, true, "", '_track = radio2 getvariable "track"; player distance radio2 <= 2 and isnil "_track"'];
action_radio3 = _role addaction ["Turn on Radio","gc\client\GC_Music.sqf", [radio3,0], 1, false, true, "", '_track = radio3 getvariable "track"; player distance radio3 <= 2 and isnil "_track"'];
//======================= bag shop =======================
action125 = _role addaction ["Trade for Bags","bagshop.sqf", [], 1, false, true, "", "player distance bagshop <= 5"];
action126 = _role addaction ["Chop Shop","gc\client\GC_Chopshop.sqf", [], 1, false, true, "", "player distance chopshop <= 5"];
//======================= Houses =======================
action127 = _role addaction ["Keypad","codepad\CodePad.sqf",[h1pin,{["hmod1"] execvm "opengate.sqf"},{ctrlSetText [999,"Wrong code!"];sleep 1;ctrlSetText [999,""];}],1,false,true,"","player distance hf1 <= 3"];
action128 = _role addaction ["Keypad","codepad\CodePad.sqf",[h1_1pin,{["hmod1_1"] execvm "opengate.sqf"},{ctrlSetText [999,"Wrong code!"];sleep 1;ctrlSetText [999,""];}],1,false,true,"","player distance hf1_1 <= 3"];
action129 = _role addaction ["Keypad","codepad\CodePad.sqf",[h2pin,{["hmod2"] execvm "opengate.sqf"},{ctrlSetText [999,"Wrong code!"];sleep 1;ctrlSetText [999,""];}],1,false,true,"","player distance hf2 <= 3"];
action130 = _role addaction ["Keypad","codepad\CodePad.sqf",[h2_1pin,{["hmod2_1"] execvm "opengate.sqf"},{ctrlSetText [999,"Wrong code!"];sleep 1;ctrlSetText [999,""];}],1,false,true,"","player distance hf2_1 <= 3"];
action131 = _role addaction ["Keypad","codepad\CodePad.sqf",[h2_2pin,{["hmod2_2"] execvm "opengate.sqf"},{ctrlSetText [999,"Wrong code!"];sleep 1;ctrlSetText [999,""];}],1,false,true,"","player distance hf2_2 <= 3"];
action132 = _role addaction ["Keypad","codepad\CodePad.sqf",[h3pin,{["hmod3"] execvm "opengate.sqf"},{ctrlSetText [999,"Wrong code!"];sleep 1;ctrlSetText [999,""];}],1,false,true,"","player distance hf3 <= 3"];
action133 = _role addaction ["Keypad","codepad\CodePad.sqf",[h3_1pin,{["hmod3_1"] execvm "opengate.sqf"},{ctrlSetText [999,"Wrong code!"];sleep 1;ctrlSetText [999,""];}],1,false,true,"","player distance hf3_1 <= 3"];
action134 = _role addaction ["Keypad","codepad\CodePad.sqf",[h4pin,{["hmod4"] execvm "opengate.sqf"},{ctrlSetText [999,"Wrong code!"];sleep 1;ctrlSetText [999,""];}],1,false,true,"","player distance hf4 <= 3"];

// wait 5 then reset busy flags in case they were stuck
if (doingSomething or (shopactivescript or INV_StorageSperre)) then {
  sleep 5;
  doingSomething = false;
  shopactivescript = false;
  INV_StorageSperre = false;
};
