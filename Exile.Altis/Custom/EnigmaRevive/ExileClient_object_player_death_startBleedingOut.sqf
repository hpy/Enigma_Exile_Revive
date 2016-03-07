/**
 * ExileClient_object_player_death_startBleedingOut
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_respawnDelay","_layer","_descriptions"];
_respawnDelay = _this;

/////////////////////////////////added by happydayz/////////////////////////////////////
oldgroup = group player;
if (player getVariable["REVIVE", true]) then {

_descriptions =
[
	"KNOCKED OUT",
	"CRITICALLY WOUNDED",
	"BLEEDING OUT",
	"ON DEATHS DOOR"
	];

player setVariable ['EnigmaRevivePermitted', true, true]; //adds action to be revived

[100] call BIS_fnc_bloodEffect;
ExileClientPostProcessingColorCorrections ppEffectAdjust [1, 1.1, -0.05, [0.4, 0.2, 0.3, -0.1], [0.79, 0.72, 0.62, 0], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];
ExileClientPostProcessingColorCorrections ppEffectCommit 0;
ExileClientPostProcessingColorCorrections ppEffectAdjust [1, 1.1, -0.05, [0.4, 0.2, 0.3, -0.1], [0.3, 0.05, 0, 0], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];
ExileClientPostProcessingColorCorrections ppEffectCommit _respawnDelay; 
ExileClientPostProcessingBackgroundBlur ppEffectAdjust [0];
ExileClientPostProcessingBackgroundBlur ppEffectCommit 0;
ExileClientPostProcessingBackgroundBlur ppEffectEnable true;
ExileClientPostProcessingBackgroundBlur ppEffectAdjust [2];
ExileClientPostProcessingBackgroundBlur ppEffectCommit _respawnDelay;
ExileClientBleedOutHeartbeatPlaying = false; 
ExileClientBleedOutCountDownDuration = _respawnDelay;
ExileClientBleedOutCountDownEnd = time + _respawnDelay;

player setVariable ["BleedoutCountDownEnd", ExileClientBleedOutCountDownEnd, true]; 

_layer = "BIS_fnc_respawnCounter" call bis_fnc_rscLayer;
_layer cutText ["", "plain"];

missionnamespace setvariable ["RscRespawnCounter_description", format ["<t size='2' align='center'>%1</t>",selectRandom _descriptions]];
missionnamespace setvariable ["RscRespawnCounter_colorID", 0];
missionnamespace setvariable ["RscRespawnCounter_Custom", _respawnDelay];
_layer cutRsc ["RscRespawnCounter", "plain"];
showChat true;
"Start bleeding out..." call ExileClient_util_log;
if(ExileClientBleedOutThread isEqualTo -1)then
{
	ExileClientBleedOutThread = [2, ExileClient_object_player_thread_bleedToDeath, [], true] call ExileClient_system_thread_addtask;
};
} else {
////////////////////////////////////////////////////////////////////////////////////////



[100] call BIS_fnc_bloodEffect;
ExileClientPostProcessingColorCorrections ppEffectAdjust [1, 1.1, -0.05, [0.4, 0.2, 0.3, -0.1], [0.79, 0.72, 0.62, 0], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];
ExileClientPostProcessingColorCorrections ppEffectCommit 0;
ExileClientPostProcessingColorCorrections ppEffectAdjust [1, 1.1, -0.05, [0.4, 0.2, 0.3, -0.1], [0.3, 0.05, 0, 0], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];
ExileClientPostProcessingColorCorrections ppEffectCommit _respawnDelay; 
ExileClientPostProcessingBackgroundBlur ppEffectAdjust [0];
ExileClientPostProcessingBackgroundBlur ppEffectCommit 0;
ExileClientPostProcessingBackgroundBlur ppEffectEnable true;
ExileClientPostProcessingBackgroundBlur ppEffectAdjust [2];
ExileClientPostProcessingBackgroundBlur ppEffectCommit _respawnDelay;
ExileClientBleedOutHeartbeatPlaying = false; 
ExileClientBleedOutCountDownDuration = _respawnDelay;
ExileClientBleedOutCountDownEnd = time + _respawnDelay;
_layer = "BIS_fnc_respawnCounter" call bis_fnc_rscLayer;
_layer cutText ["", "plain"];
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
missionnamespace setvariable ["RscRespawnCounter_description", format ["<t size='2' align='center'>%1</t>",selectRandom _descriptions]];
missionnamespace setvariable ["RscRespawnCounter_colorID", 0];
missionnamespace setvariable ["RscRespawnCounter_Custom", _respawnDelay];
_layer cutRsc ["RscRespawnCounter", "plain"];
showChat true;
"Start bleeding out..." call ExileClient_util_log;
if(ExileClientBleedOutThread isEqualTo -1)then
{
	ExileClientBleedOutThread = [2, ExileClient_object_player_thread_bleedToDeath, [], true] call ExileClient_system_thread_addtask;
};
	};
true