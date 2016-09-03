private["_respawnDelay","_layer","_descriptions"];

_respawnDelay = _this;
oldgroup = group player;

if (player getVariable["REVIVE", true]) then
{

	_descriptions =
	[
	"KNOCKED OUT",
	"CRITICALLY WOUNDED",
	"BLEEDING OUT",
	"ON DEATHS DOOR"
	];

	player setVariable ['EnigmaRevivePermitted', true, true];
}
else
{
	_descriptions =
	[
		"WRECKED",
		"REKT",
		"STOMPED",
		"WASTED",
		"SCREWED",
		"TOASTED",
		"REST IN PIECES",
		"TERMINATED",
		"KILLED",
		"EXILED",
		"ANNIHILATED",
		"HAMMERED",
		"NEUTRALIZED",
		"DUMPED",
		"ZAPPED",
		"SLAIN",
		"FRIED",
		"WIPED OUT",
		"VANQUISHED",
		"BUSTED",
		"PULVERIZED",
		"SMASHED",
		"SHREDDED",
		"CRUSHED"
	];
};

// SPLASH
[100] call BIS_fnc_bloodEffect;

// Fade to gray instantly
//ExileClientPostProcessingColorCorrections ppEffectAdjust [1, 1.1, -0.05, [0.4, 0.2, 0.3, -0.1], [0.79, 0.72, 0.62, 0], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];
ExileClientPostProcessingColorCorrections ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [0.39, 0.32, 0.25, 0], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];
ExileClientPostProcessingColorCorrections ppEffectCommit 0;

// Fade to red slowy
//ExileClientPostProcessingColorCorrections ppEffectAdjust [1, 1.1, -0.05, [0.4, 0.2, 0.3, -0.1], [0.3, 0.05, 0, 0], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];
ExileClientPostProcessingColorCorrections ppEffectAdjust [1, 1, 0, [0.4, 0.2, 0.3, 0], [0.3, 0.05, 0, 0], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];
ExileClientPostProcessingColorCorrections ppEffectCommit _respawnDelay;

// Enable blur
ExileClientPostProcessingBackgroundBlur ppEffectAdjust [0];
ExileClientPostProcessingBackgroundBlur ppEffectCommit 0;
ExileClientPostProcessingBackgroundBlur ppEffectEnable true;
ExileClientPostProcessingBackgroundBlur ppEffectAdjust [2];
ExileClientPostProcessingBackgroundBlur ppEffectCommit _respawnDelay;

// Our count down
ExileClientBleedOutHeartbeatPlaying = false;
ExileClientBleedOutCountDownDuration = _respawnDelay;
ExileClientBleedOutCountDownEnd = time + _respawnDelay;
player setVariable ["BleedoutCountDownEnd", ExileClientBleedOutCountDownEnd, true];
// BIS count down GUI
_layer = "BIS_fnc_respawnCounter" call bis_fnc_rscLayer;
_layer cutText ["", "plain"];

missionnamespace setvariable ["RscRespawnCounter_description", format ["<t size='2' align='center'>%1</t>",selectRandom _descriptions]];
missionnamespace setvariable ["RscRespawnCounter_colorID", 0];
missionnamespace setvariable ["RscRespawnCounter_Custom", _respawnDelay];

_layer cutRsc ["RscRespawnCounter", "plain"];

// Force enable chat
showChat true;

"Start bleeding out..." call ExileClient_util_log;

// Bleed to death (every 2 seconds)
if(ExileClientBleedOutThread isEqualTo -1)then
{
	ExileClientBleedOutThread = [2, ExileClient_object_player_thread_bleedToDeath, [], true] call ExileClient_system_thread_addtask;
};


true
