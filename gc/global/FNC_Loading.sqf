GC_Cfg_Var_UsedLoadingMessages = [];

GC_ChaosArray = [
  "Iterating Chaos Array",
  "Loading ""Vroom"" Sounds",
  "Inserting Chaos Generator",
  "Downloading Weather Data",
  "Locating Misplaced Calculations",
  "Fabricating Imaginary Infrastructure",
  "Establishing Link with Internet Police",
  "Activating Anticheat System",
  "Analyzing User Scripts",
  "Script Tracker Enabled",
  "Taking off every Zig",
  "Maniuplating trend analysis vector",
  "Correlating variances",
  "Gleaning information",
  "Not actually doing anything",
  "Alphabetizing numerals",
  "Mating animals for more animals",
  "Loading hookahs",
  "Indexing grains of sand in desert",
  "Sacrificing a goat",
  "Querying non-sequential sequences",
  "Initializing polysyllabic hyperverbosity",
  "Enhancing",
  "Escalating threat level",
  "Determining mass of Higgs-Boson",
  "Generating aesthetics",
  "Printing ASCII characters to screen",
  "Reticulating splines",
  "Waking up NPCs"
];

GC_Cfg_RandomLoadingMessage = {  
    private ["_current"];
    _current = floor(random (count GC_ChaosArray));

  while {_current in GC_Cfg_Var_UsedLoadingMessages} do {
    _current = floor(random (count GC_ChaosArray));
  };

  GC_Cfg_Var_UsedLoadingMessages set [count GC_Cfg_Var_UsedLoadingMessages, _current];
  format["%1", GC_ChaosArray select _current];
};