_hmod = _this select 0;
switch (_hmod) do {
  case "hmod1": {
    if(player distance hf1 <= 5) then {
      hf1 setposasl [(getposasl hf1 select 0),(getposasl hf1 select 1),12];
      sleep 5;
      hf1 setposasl [(getposasl hf1 select 0),(getposasl hf1 select 1),17.1925];
    };
  };
  case "hmod1_1": {
    if(player distance hf1_1 <= 5) then {
      hf1_1 setposasl [(getposasl hf1_1 select 0),(getposasl hf1_1 select 1),12];
      sleep 5;
      hf1_1 setposasl [(getposasl hf1_1 select 0),(getposasl hf1_1 select 1),19];
    };
  };
  case "hmod2": {
    if(player distance hf2 <= 5) then {
      hf2 setposasl [(getposasl hf2 select 0),(getposasl hf2 select 1),12];
      sleep 5;
      hf2 setposasl [(getposasl hf2 select 0),(getposasl hf2 select 1),15.425];
    };
  };
case "hmod2_1": {
    if(player distance hf2_1 <= 5) then {
      hf2_1 setposasl [(getposasl hf2_1 select 0),(getposasl hf2_1 select 1),12];
      sleep 5;
      hf2_1 setposasl [(getposasl hf2_1 select 0),(getposasl hf2_1 select 1),17.9];
    };
  };
case "hmod2_2": {
    if(player distance hf2_2 <= 5) then {
      hf2_2 setposasl [(getposasl hf2_2 select 0),(getposasl hf2_2 select 1),12];
      sleep 5;
      hf2_2 setposasl [(getposasl hf2_2 select 0),(getposasl hf2_2 select 1),15.75];
    };
  };
  case "hmod3": {
    if(player distance hf3 <= 5) then {
      hf3 setposasl [(getposasl hf3 select 0),(getposasl hf3 select 1),12];
      sleep 5;
      hf3 setposasl [(getposasl hf3 select 0),(getposasl hf3 select 1),16.57];
    };
  };
  case "hmod3_1": {
    if(player distance hf3_1 <= 5) then {
      hf3_1 setposasl [(getposasl hf3_1 select 0),(getposasl hf3_1 select 1),12];
      sleep 5;
      hf3_1 setposasl [(getposasl hf3_1 select 0),(getposasl hf3_1 select 1),16.70];
    };
  };
  case "hmod4": {
    if(player distance hf4 <= 5) then {
      hf4 setposasl [(getposasl hf4 select 0),(getposasl hf4 select 1),12];
      sleep 5;
      hf4 setposasl [(getposasl hf4 select 0),(getposasl hf4 select 1),19.38];
    };
  };
};