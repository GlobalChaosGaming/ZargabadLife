
#define FontM 			"Zeppelin33"

#define FontHTML 		"Zeppelin33"

#define CT_STATIC 		0

#define CT_BUTTON		1

#define CT_EDIT			2

#define CT_SLIDER		3

#define CT_COMBO		4

#define CT_LISTBOX		5

#define CT_TOOLBOX 		6

#define CT_CHECKBOXES 		7

#define CT_PROGRESS 		8

#define CT_HTML 		9

#define CT_STATIC_SKEW 		10

#define CT_ACTIVETEXT		11

#define CT_TREE 		12

#define CT_STRUCTURED_TEXT 	13

#define CT_CONTEXT_MENU 	14

#define CT_CONTROLS_GROUP 	15

#define CT_XKEYDESC 		40

#define CT_XBUTTON 		41

#define CT_XLISTBOX 		42

#define CT_XSLIDER 		43

#define CT_XCOMBO 		44

#define CT_ANIMATED_TEXTURE	45

#define CT_OBJECT 		80

#define CT_OBJECT_ZOOM 		81

#define CT_OBJECT_CONTAINER	82

#define CT_OBJECT_CONT_ANIM	83

#define CT_LINEBREAK		98

#define CT_USER			99

#define CT_MAP 			100

#define CT_MAP_MAIN		101

#define CT_LISTNBOX 102

#define ST_LEFT			0

#define ST_RIGHT		1

#define ST_CENTER		2

#define ST_MULTI		16

#define ST_PICTURE		48

#define ST_TILE_PICTURE 144

#define ST_FRAME		64

#define ST_SHADOW		256

#define ST_NO_RECT		512

//=====================================================================================

class RscText

{

type              = CT_STATIC;
idc               = -1;
style             = ST_LEFT;
colorBackground[] = {0, 0, 0, 0};
colorText[]       = {1, 1, 1, 1};
font              = FontM;
sizeEx            = 0.02;
text              = "";

};

class RscBgRahmen

{

type              = CT_STATIC;
idc               = -1;
style             = ST_FRAME;
colorBackground[] = {1.0, 1.0, 1.0, 0.75};
colorText[]       = {1, 1, 1, 1};
font              = FontM;
SizeEX            = 0.025;
text              = "";

};

class RscBackground

{

colorBackground[] = {0, 0, 0, 0.8};
text              = "";
type              = CT_STATIC;
idc               = -1;
style             = ST_LEFT;
colorText[]       = {1, 1, 1, 1};
font              = FontM;
sizeEx            = 0.04;

};

class RscPicture

{

type              = CT_STATIC;
idc               =  -1;
style             = ST_PICTURE;
colorBackground[] = {0, 0, 0, 0};
colorText[]       = {1, 1, 1, 1};
font              = FontM;
sizeEx            = 0.02;
text              = "";

};

class RscBackgroundPicture

{

type              = CT_STATIC;
idc               =  -1;
style             = ST_TILE_PICTURE;
colorBackground[] = {0, 0, 0, 0};
colorText[]       = {1, 1, 1, 1};
font              = FontM;
text              = "images\dialog_bg.paa";
sizeEx            = 0;
};

class RscButton

{

type                      = CT_BUTTON;
idc                       = -1;
style                     = ST_CENTER;
colorText[]               = {1, 1, 1, 1};
font                      = FontHTML;
sizeEx                    = 0.0235;
soundPush[]               = {"", 0.2, 1};
soundClick[]              = {"\ca\ui\data\sound\mouse3", 0.2, 1};
soundEscape[]             = {"\ca\ui\data\sound\mouse1", 0.2, 1};
default                   = false;
text                      = "";
action                    = "";
colorActive[]             = {0, 0, 0, 0};
colorDisabled[]           = {0, 0, 0, 0.1};
colorBackground[]         = {1.0,0.1,0.1,0.3};
colorBackgroundActive[]   = {0.56,0.1,0.1,1};
colorBackgroundDisabled[] = {1,1,1,0.5};
colorFocused[]            = {0.84,1,0.55,1};
colorShadow[]             = {0, 0, 0, 0.1};
colorBorder[]             = {1, 1, 1, 0.1};
offsetX                   = 0;
offsetY                   = 0;
offsetPressedX            = 0;
offsetPressedY            = 0;
borderSize                = 0;
soundEnter[]              = {"", 0.15, 1};

};

class RscDummy : RscButton

{

x   = -1.0;
y   = -1.0;
idc = -1;
w   = 0.01;
h   = 0.01;
default = true;

};

class RscEdit

{

type = CT_EDIT;
idc = -1;
style = ST_LEFT;
font = FontHTML;
sizeEx = 0.02;
colorText[] = {1, 1, 1, 1};
colorSelection[] = {0.5, 0.5, 0.5, 1};
autocomplete = false;text = "";

};

class RscLB_C

{

style                   = ST_LEFT;
idc                     = -1;
colorSelect[]           = {0, 0, 0, 1.0};
colorSelectBackground[] = {0.7, 0.7, 0.7, 1};
colorText[]             = {1, 1, 1, 1};
colorBackground[]       = {0.8, 0.8, 0.8, 0.3};
colorScrollbar[] 	= {Dlg_Color_White,1};
font                    = FontHTML;
sizeEx                  = 0.025;
rowHeight               = 0.04;
period 			= 1.200000;
maxHistoryDelay 	= 1.000000;
autoScrollSpeed 	= -1;
autoScrollDelay 	= 5;
autoScrollRewind 	= 0;

class ScrollBar {};

};

class RscListBox: RscLB_C

{

soundSelect[] = {"", 0.1, 1};
type          = CT_LISTBOX;

};

class RscCombo: RscLB_C

{

type            = CT_COMBO;
wholeHeight     = 0.3;
soundSelect[]   = {"", 0.15, 1};
soundExpand[]   = {"", 0.15, 1};
soundCollapse[] = {"", 0.15, 1};
arrowEmpty = "\ca\ui\data\ui_arrow_combo_ca.paa";
arrowFull = "\ca\ui\data\ui_arrow_combo_active_ca.paa";

};

class RscSliderH

{

access  = ReadandWrite;
type    = CT_SLIDER;
idc     = -1;
sizeEx  = 0.025;
style   = 1024;
color[] = {0.2, 0.2, 0.2, 1};
colorActive[] = {1, 1, 1, 1};

};

class RscSliderV

{

access  = ReadandWrite;
type    = CT_SLIDER;
idc     = -1;
sizeEx  = 0.025;
style   = 0;
color[] = {0.2, 0.2, 0.2, 1};
colorActive[] = {1, 1, 1, 1};

};

class RscMapControl {
        type = 101;
        moveOnEdges = 1;
        sizeEx = 0.025;
        style = 48;
        x = 0.2;
        y = 0.2;
        w = 0.2;
        h = 0.2;
        ptsPerSquareSea = 8;
        ptsPerSquareTxt = 10;
        ptsPerSquareCLn = 10;
        ptsPerSquareExp = 10;
        ptsPerSquareCost = 10;
        ptsPerSquareFor = "6.0f";
        ptsPerSquareForEdge = "15.0f";
        ptsPerSquareRoad = "3f";
        ptsPerSquareObj = 15;
        showCountourInterval = "false";
        maxSatelliteAlpha = 0.75;
        alphaFadeStartScale = 0.15;
        alphaFadeEndScale = 0.29;
        colorLevels[] = {0.65, 0.6, 0.45, 1};
        colorSea[] = {0.46, 0.65, 0.74, 0.5};
        colorForest[] = {0.45, 0.64, 0.33, 0.5};
        colorRocks[] = {0, 0, 0, 0.3};
        colorCountlines[] = {0.85, 0.8, 0.65, 1};
        colorMainCountlines[] = {0.45, 0.4, 0.25, 1};
        colorCountlinesWater[] = {0.25, 0.4, 0.5, 0.3};
        colorMainCountlinesWater[] = {0.25, 0.4, 0.5, 0.9};
        colorPowerLines[] = {0.1, 0.1, 0.1, 1};
        colorRailWay[] = {0.8, 0.2, 0, 1};
        colorForestBorder[] = {0, 0, 0, 0};
        colorRocksBorder[] = {0, 0, 0, 0};
        colorNames[] = {0.1, 0.1, 0.1, 0.9};
        colorInactive[] = {1, 1, 1, 0.5};
        colorText[] = {0, 0, 0, 1};
        colorBackground[] = {0.8, 0.8, 0.8, 1};
        font = "EtelkaNarrowMediumPro";
        colorOutside[] = {0, 0, 0, 1};
        fontLabel = "Zeppelin32";
        sizeExLabel = 0.034;
        fontGrid = "Zeppelin32";
        sizeExGrid = 0.03;
        fontUnits = "Zeppelin32";
        sizeExUnits = 0.034;
        fontNames = "Zeppelin32";
        sizeExNames = 0.056;
        fontInfo = "Zeppelin32";
        sizeExInfo = 0.034;
        fontLevel = "Zeppelin32";
        sizeExLevel = 0.024;
        text = "\ca\ui\data\map_background2_co.paa";

        class Task {
                icon = "\ca\ui\data\ui_taskstate_current_CA.paa";
                iconCreated = "\ca\ui\data\ui_taskstate_new_CA.paa";
                iconCanceled = "#(argb,8,8,3)color(0,0,0,0)";
                iconDone = "\ca\ui\data\ui_taskstate_done_CA.paa";
                iconFailed = "\ca\ui\data\ui_taskstate_failed_CA.paa";
                color[] = {0.863, 0.584, 0.0, 1};
                colorCreated[] = {0.95, 0.95, 0.95, 1};
                colorCanceled[] = {0.606, 0.606, 0.606, 1};
                colorDone[] = {0.424, 0.651, 0.247, 1};
                colorFailed[] = {0.706, 0.0745, 0.0196, 1};
                size = 27;
                importance = 1;
                coefMin = 1;
                coefMax = 1;
        };

        class CustomMark {
                icon = "\ca\ui\data\map_waypoint_ca.paa";
                color[] = {0.6471, 0.6706, 0.6235, 1.0};
                size = 18;
                importance = 1;
                coefMin = 1;
                coefMax = 1;
        };

        class Legend {
                x = "SafeZoneX";
                y = "SafeZoneY";
                w = 0.34;
                h = 0.152;
                font = "Zeppelin32";
                sizeEx = 0.03921;
                colorBackground[] = {0.906, 0.901, 0.88, 0};
                color[] = {0, 0, 0, 1};
        };

        class Bunker {
                icon = "\ca\ui\data\map_bunker_ca.paa";
                size = 14;
                color[] = {0, 0, 1, 1};
                importance = 1.5 * 14 * 0.05;
                coefMin = 0.25;
                coefMax = 4;
        };

        class Bush {
                icon = "\ca\ui\data\map_bush_ca.paa";
                color[] = {0.55, 0.64, 0.43, 1};
                size = 14;
                importance = 0.2 * 14 * 0.05;
                coefMin = 0.25;
                coefMax = 4;
        };

        class BusStop {
                icon = "\ca\ui\data\map_busstop_ca.paa";
                color[] = {0, 0, 1, 1};
                size = 12;
                importance = 1 * 10 * 0.05;
                coefMin = 0.25;
                coefMax = 4;
        };

        class Command {
                icon = "\ca\ui\data\map_waypoint_ca.paa";
                color[] = {0, 0.9, 0, 1};
                size = 18;
                importance = 1;
                coefMin = 1;
                coefMax = 1;
        };

        class Cross {
                icon = "\ca\ui\data\map_cross_ca.paa";
                size = 16;
                color[] = {0, 0.9, 0, 1};
                importance = 0.7 * 16 * 0.05;
                coefMin = 0.25;
                coefMax = 4;
        };

        class Fortress {
                icon = "\ca\ui\data\map_bunker_ca.paa";
                size = 16;
                color[] = {0, 0.9, 0, 1};
                importance = 2 * 16 * 0.05;
                coefMin = 0.25;
                coefMax = 4;
        };

        class Fuelstation {
                icon = "\ca\ui\data\map_fuelstation_ca.paa";
                size = 16;
                color[] = {0, 0.9, 0, 1};
                importance = 2 * 16 * 0.05;
                coefMin = 0.75;
                coefMax = 4;
        };

        class Fountain {
                icon = "\ca\ui\data\map_fountain_ca.paa";
                color[] = {0.2, 0.45, 0.7, 1};
                size = 11;
                importance = 1 * 12 * 0.05;
                coefMin = 0.25;
                coefMax = 4;
        };

        class Hospital {
                icon = "\ca\ui\data\map_hospital_ca.paa";
                color[] = {0.78, 0, 0.05, 1};
                size = 16;
                importance = 2 * 16 * 0.05;
                coefMin = 0.5;
                coefMax = 4;
        };

        class Chapel {
                icon = "\ca\ui\data\map_chapel_ca.paa";
                color[] = {0, 0, 1, 1};
                size = 16;
                importance = 1 * 16 * 0.05;
                coefMin = 0.9;
                coefMax = 4;
        };

        class Church {
                icon = "\ca\ui\data\map_church_ca.paa";
                size = 16;
                color[] = {0, 0.9, 0, 1};
                importance = 2 * 16 * 0.05;
                coefMin = 0.9;
                coefMax = 4;
        };

        class Lighthouse {
                icon = "\ca\ui\data\map_lighthouse_ca.paa";
                size = 14;
                color[] = {0, 0.9, 0, 1};
                importance = 3 * 16 * 0.05;
                coefMin = 0.9;
                coefMax = 4;
        };

        class Quay {
                icon = "\ca\ui\data\map_quay_ca.paa";
                size = 16;
                color[] = {0, 0.9, 0, 1};
                importance = 2 * 16 * 0.05;
                coefMin = 0.5;
                coefMax = 4;
        };

        class Rock {
                icon = "\ca\ui\data\map_rock_ca.paa";
                color[] = {0.1, 0.1, 0.1, 0.8};
                size = 12;
                importance = 0.5 * 12 * 0.05;
                coefMin = 0.25;
                coefMax = 4;
        };

        class Ruin {
                icon = "\ca\ui\data\map_ruin_ca.paa";
                size = 16;
                color[] = {0, 0.9, 0, 1};
                importance = 1.2 * 16 * 0.05;
                coefMin = 1;
                coefMax = 4;
        };

        class SmallTree {
                icon = "\ca\ui\data\map_smalltree_ca.paa";
                color[] = {0.45, 0.64, 0.33, 0.4};
                size = 12;
                importance = 0.6 * 12 * 0.05;
                coefMin = 0.25;
                coefMax = 4;
        };

        class Stack {
                icon = "\ca\ui\data\map_stack_ca.paa";
                size = 20;
                color[] = {0, 0.9, 0, 1};
                importance = 2 * 16 * 0.05;
                coefMin = 0.9;
                coefMax = 4;
        };

        class Tree {
                icon = "\ca\ui\data\map_tree_ca.paa";
                color[] = {0.45, 0.64, 0.33, 0.4};
                size = 12;
                importance = 0.9 * 16 * 0.05;
                coefMin = 0.25;
                coefMax = 4;
        };

        class Tourism {
                icon = "\ca\ui\data\map_tourism_ca.paa";
                size = 16;
                color[] = {0.78, 0, 0.05, 1};
                importance = 1 * 16 * 0.05;
                coefMin = 0.7;
                coefMax = 4;
        };

        class Transmitter {
                icon = "\ca\ui\data\map_transmitter_ca.paa";
                color[] = {0, 0.9, 0, 1};
                size = 20;
                importance = 2 * 16 * 0.05;
                coefMin = 0.9;
                coefMax = 4;
        };

        class ViewTower {
                icon = "\ca\ui\data\map_viewtower_ca.paa";
                color[] = {0, 0.9, 0, 1};
                size = 16;
                importance = 2.5 * 16 * 0.05;
                coefMin = 0.5;
                coefMax = 4;
        };

        class Watertower {
                icon = "\ca\ui\data\map_watertower_ca.paa";
                color[] = {0.2, 0.45, 0.7, 1};
                size = 20;
                importance = 1.2 * 16 * 0.05;
                coefMin = 0.9;
                coefMax = 4;
        };

        class Waypoint {
                icon = "\ca\ui\data\map_waypoint_ca.paa";
                color[] = {0, 0, 1, 1};
                size = 14;
                importance = 2.5 * 16 * 0.05;
                coefMin = 0.5;
                coefMax = 4;
        };

        class WaypointCompleted {
                icon = "\ca\ui\data\map_waypoint_completed_ca.paa";
                color[] = {0, 0, 1, 1};
                size = 14;
                importance = 2.5 * 16 * 0.05;
                coefMin = 0.5;
                coefMax = 4;
        };

        class ActiveMarker {
                icon = "";
                color[] = {0, 0, 1, 1};
                size = 14;
                importance = 2.5 * 16 * 0.05;
                coefMin = 0.5;
                coefMax = 4;
        };
};