_label = _this select 0;
_i = 0;

if (_label == "basicintro") then {

  intromusic_obj = "HeliHEmpty" createVehicleLocal (getpos player);
  intromusic_obj setpos [(getpos player select 0),(getpos player select 1),-1];
  
  if (iscop) then {intromusic_obj say ["copmusic",1];};
  if (isciv) then {intromusic_obj say ["civmusic",1];};

	["<img size='2' image='images\cl.paa' />", -1, (safezoneH-1.05)/2, 5, 2] call GC_dynamicText;

	["Presented by<br/> <t size='2' color='#cc0000'>Global Chaos Gaming</t>",-1,-1,3,0.5] call GC_dynamicText;

	call compile format['["Welcome %1"] spawn GC_infoText;',name player];

	["This is a role playing game!",-1,-1,2,0.5] call GC_dynamicText;

	["Civilians killing unarmed civilians without reason is called Deathmatching!<br /> <t size='1.3' color='#cc0000' shadow='1' shadowColor='#c6c6c6'>DON'T DO IT</t>",-1,-1,3,0.5] call GC_dynamicText;

	["Cops should never fire lethal rounds unless their life is in danger!",-1,-1,3,0.5] call GC_dynamicText;


	["Game guide, rules and Teamspeak Info are located on the map tabs.<br /><br />Please play by the rules and in the spirit of the game!",-1,-1,3,0.5] spawn GC_dynamicText;
	["Have Fun!"] spawn GC_infoText;

  _text = "
  Welcome to<br /> <t color='#cc0000' shadow='1' size='1.2'>Global Chaos Gaming</t>!<br />
  <img size='12' image='images\gclogo.paa'/><br />
  <t underline='true' size='2' color='#cc0000' shadow='1' shadowColor='#ffffff'>Chaos Life!</t><br/><br />
  Please read the rules found in the briefing (press M) before playing!<br/>
  <br />
  <t align='left'>
  * New Jobs!<br/>
  * New Skins!<br/>
  * New Layout!<br/>
  * New Effects!<br/>
  * New Vehicles!<br/>
  * New Weapons!<br/>
  </t>
  <br />
  <t color='#FFFF00'>Please report any players, bugs or issues on the Global Chaos website</t>

  <br /><br />
  <t underline='true' color='#cc0000'>Contact Info:</t><br/>
  -= Team Speak 3 =-<br /> ts.GlobalChaosGaming.net<br /><br />
  -= Website =- <br />GlobalChaosGaming.net<br /><br />";

  hint parseText _text;
  
  if (showChaosKeys) then {
  	sleep 5;
  	["FAQ"] execVM "settings.sqf";
  	player groupchat "PRESS M WHEN READY TO READ SERVER RULES!!!";
  };

  if (iscop) then {sleep 5;};

  deletevehicle intromusic_obj;
  intromusic_obj = objnull;
};
