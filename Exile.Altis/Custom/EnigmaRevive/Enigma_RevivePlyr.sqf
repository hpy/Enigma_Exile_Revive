/*
Enigma_RevivePlyr.sqf
[_ZEN_] Enigma (Happydayz)
*/

private["_target","_targetname","_updatestats"];
_target = _this select 0;
_targetname = name _target;


if !(isPlayer _target) exitWith {systemChat Format ["Theres no pulse..."]};

if (_target getVariable "EnigmaRevivePermitted") then {

	if (magazines player find "Exile_Item_Defibrillator" >= 0) then {

	_target switchMove "AinjPpneMstpSnonWrflDnon";
	sleep 0.2;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 6;
	player switchmove ""; //incase get stuck in animation

		if (_target getVariable["REVIVE", true]) then { 
		_target setVariable["antidupe", -1, true]; //targetted player inventory is now locked out from accessing!
       ENIGMA_revivePlayer = [_target,player,1];
       publicVariableServer "ENIGMA_revivePlayer";
		} else {		
		systemChat Format ["RIP %1! They suffered a fatal injury!",_targetname];
		};
	};
} else {		
		systemChat Format ["RIP %1! They suffered a fatal injury!",_targetname];
		};