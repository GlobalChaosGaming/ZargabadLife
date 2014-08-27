class RscTitles {

  #define screenwidth (1 - safeZonex*2)
  #define screenheight (1 - safeZoney*2)

	class BTC_Hud
   	{
      	idd = 1000;
     	movingEnable=0;
      	duration=1e+011;
      	name = "BTC_Hud_Name";
      	onLoad = "uiNamespace setVariable [""HUD"", _this select 0];";
      	controlsBackground[] = {};
      	objects[] = {};
      	class controls
		{
			class Radar
			{
				type = CT_STATIC;
				idc = 1001;
				style = ST_PICTURE;
				x = (SafeZoneW+2*SafeZoneX) - 0.1;//safezonex + 0.1;//0.9
				y = (SafeZoneH+2*SafeZoneY) - 0.15;//safezoney + 0.1;//0.85
				w = 0.3;
				h = 0.4;
				font = "Zeppelin32";
				sizeEx = 0.03;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "\ca\ui\data\igui_radar_air_ca.paa";
			};
			class Img_Obj
			{
				type = CT_STATIC;
				idc = 1002;
				style = ST_PICTURE;
				x = (SafeZoneW+2*SafeZoneX) + 0.045;
				y = (SafeZoneH+2*SafeZoneY) + 0.045;
				w = 0.01;
				h = 0.01;
				font = "Zeppelin32";
				sizeEx = 0.04;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "=BTC=_Logistic\=BTC=_Lift\=BTC=_Obj.paa";
			};
			class Pic_Obj
			{
				type = CT_STATIC;
				idc = 1003;
				style = ST_PICTURE;
				x = (SafeZoneW+2*SafeZoneX) - 0.125;
				y = (SafeZoneH+2*SafeZoneY) - 0.23;
				w = 0.1;
				h = 0.1;
				font = "Zeppelin32";
				sizeEx = 0.03;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "";
			};
			class Arrow
			{
				type = CT_STATIC;
				idc = 1004;
				style = ST_PICTURE;
				x = (SafeZoneW+2*SafeZoneX) + 0.15;
				y = (SafeZoneH+2*SafeZoneY) - 0.15;
				w = 0.05;
				h = 0.05;
				font = "Zeppelin32";
				sizeEx = 0.03;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "";
			};
			class Type_Obj
			{
				type = CT_STATIC;
				idc = 1005;
				style = ST_LEFT;
				x = (SafeZoneW+2*SafeZoneX) - 0.03;
				y = (SafeZoneH+2*SafeZoneY) - 0.335;
				w = 0.3;
				h = 0.3;
				font = "Zeppelin32";
				sizeEx = 0.03;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "";
			};
		};
 	};

  class GCHUD_Status {
    idd = -1;
    movingEnable = 0;
    fadein       = 0;
    duration     = 1e+011;
    fadeout      = 0;
    name         = "GCHUD_Status";
    onLoad       = "uiNamespace setVariable ['GCHUD_Status',_this select 0]";
    objects[]    = {};
    controls[]   = {health, armor, cash, most_wanted, stars, wanted};
    class health {
		idc = 63307;
		type = CT_STRUCTURED_TEXT;
		style = ST_LEFT;
		colorBackground[] = { 0, 0, 0, 0 };
		x = safeZoneX+0.07;
		y = safeZoneY+.01;
		w = 0.45;
		h = 0.15;
		size = 0.05;
		text = "";
	};
    class cash {
		idc = 63309;
		type = CT_STRUCTURED_TEXT;
		style = ST_LEFT;
		colorBackground[] = { 0, 0, 0, 0 };
		x = safeZoneX+0.07;
		y = safeZoneY+.07;
		w = 0.45;
		h = 0.15;
		size = 0.05;
		text = "";
	};
    class armor {
		idc = 63308;
		type = CT_STRUCTURED_TEXT;
		style = ST_LEFT;
		colorBackground[] = { 0, 0, 0, 0 };
		x = safeZoneX+0.069;
		y = safeZoneY+.125;
		w = 0.45;
		h = 0.15;
		size = 0.05;
		text = "";
	};
    class most_wanted {
		idc = 63310;
		type = CT_STRUCTURED_TEXT;
		style = ST_LEFT;
		colorBackground[] = { 0, 0, 0, 0 };
		x = safeZoneX+0.025;
		y = safeZoneY+.18;
		w = 0.45;
		h = 0.45;
		size = 0.05;
		text = "";
	};
    class stars {
      idc = 63302;
      type = CT_STRUCTURED_TEXT;
      style = ST_CENTER;
      colorBackground[] = { 0, 0, 0, 0 };
      x = .5 * safeZoneW + safezoneX-.25;
      y = safeZoneY+0.05;
      w = 0.5;
      h = 0.05;
      size = 0.1;
      text = "";
    };

    class wanted : RscText {
      idc    = 63303;
      colorBackground[] = { 0, 0, 0, 0 };
      x      = .5 * safeZoneW + safezoneX-.25;
      y      = safeZoneY+.08;
      w      = 0.5;
      h      = 0.1;
      style  = ST_CENTER;
      text   = "";
      sizeEx = 0.04;
      font   = "EtelkaMonospaceProBold";
    };
  };

  class GCHUD_CopRadar {
    idd = -1;
    movingEnable = 0;
    fadein       = 0;
    duration     = 2;
    fadeout      = 0;
    name         = "GCHUD_CopRadar";
    onLoad       = "uiNamespace setVariable ['GCHUD_CopRadar',_this select 0]";
    objects[]    = {};
    controls[]   = {background, target, digits};
    class background : RscBackgroundPicture {
      idc = 63304;
      x = .5 * safeZoneW + safezoneX-.27;
      y = safeZoneY;
      text = "images\radar.paa";
      w = 0.5;
      h = 0.1666667;
    };
    class digits {
      idc = 63305;
      type = CT_STRUCTURED_TEXT;
      style = ST_CENTER;
      colorBackground[] = { 0, 0, 0, 0 };
      x = .5 * safeZoneW + safezoneX-.206;
      y = safeZoneY+.05;
      w = 0.45;
      h = 0.10;
      size = 0.05;
      text = "<img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/> <img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/> <img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/>";
    };
    class target {
      idc = 63306;
      type = CT_STRUCTURED_TEXT;
      style = ST_CENTER;
      colorBackground[] = { 0, 0, 0, 0 };
      x = .5 * safeZoneW + safezoneX-.250;
      y = safeZoneY+.165;
      w = 0.45;
      h = 0.20;
      size = 0.05;
      text = "";
    };

  };


  class Rtags {
    idd=64431;
    movingEnable = true;
    fadein       =  0;
    fadeout     = 0;
    duration     =  0.50;
    name="TAGS_HUD";
    controls[]={"vehicle_hud_name","vehicle_hud_speed","vehicle_hud_fuel","vehicle_hud_damage","vehicle_hud_direction", "nametag", "interact"};
    onLoad="uiNamespace setVariable ['TAGS_HUD', _this select 0]";

    class vehicle_hud_name
    {
      type = 0;
      idc = 64432;
      style = 0;
      x = 0.87;
      y = 0.725;
      w = 0.2;
      h = 0.2;
      font = "Zeppelin33Italic";
      sizeEx = 0.019;
      colorText[] = {1.0, 1.0, 1.0, 0.9};
      colorBackground[]={0,0,0,0.0};
      text = "";
    };

    class vehicle_hud_speed
    {
      type = 0;
      idc = 64433;
      style = 0;
      x = 0.87;
      y = 0.755;
      w = 0.2;
      h = 0.2;
      font = "Zeppelin33Italic";
      sizeEx = 0.019;
      colorText[] = {1.0, 1.0, 1.0, 0.9};
      colorBackground[]={0,0,0,0.0};
      text = "";
    };

    class vehicle_hud_fuel
    {
      type = 0;
      idc = 64434;
      style = 0;
      x = 0.87;
      y = 0.785;
      w = 0.2;
      h = 0.2;
      font = "Zeppelin33Italic";
      sizeEx = 0.019;
      colorText[] = {1.0, 1.0, 1.0, 0.9};
      colorBackground[]={0,0,0,0.0};
      text = "";
    };

    class vehicle_hud_damage
    {
      type = 0;
      idc = 64435;
      style = 0;
      x = 0.87;
      y = 0.815;
      w = 0.2;
      h = 0.2;
      font = "Zeppelin33Italic";
      sizeEx = 0.019;
      colorText[] = {1.0, 1.0, 1.0, 0.9};
      colorBackground[]={0,0,0,0.0};
      text = "";
    };

    class vehicle_hud_direction
    {
      type = 0;
      idc = 64436;
      style = 0;
      x = 0.87;
      y = 0.845;
      w = 0.2;
      h = 0.2;
      font = "Zeppelin33Italic";
      sizeEx = 0.019;
      colorText[] = {1.0, 1.0, 1.0, 0.9};
      colorBackground[]={0,0,0,0.0};
      text = "";
    };

    class nametag
    {
      type = 0;
      idc = 64437;
      style = 0;
      x = 0.44;
      y = 0.40;
      w = 0.3;
      h = 0.2;
      font = "Zeppelin33Italic";
      sizeEx = 0.019;
      colorText[] = {1, 1, 0, 0.8};
      colorBackground[]={0,0,0,0.0};
      text = "";
    };

    class interact
    {
      type = 0;
      idc = 64438;
      style = 0;
      x = 0.50;
      y = 0.47;
      w = 0.3;
      h = 0.2;
      font = "Zeppelin33Italic";
      sizeEx = 0.025;
      colorText[] = {0, 1, 0, 0.8};
      colorBackground[]={0,0,0,0.0};
      text = "";
    };

  };

};