/*
Enigma_RevivePlyr.sqf
[_ZEN_] Happydayz
© 2016 Enigma Team
*/

private ["_target","_targetname", "_bodypos1", "_bodypos2", "_bodypos3", "_healPlace", "_action", "_bodypos", "_animstate", "_primaryw", "_timer", "_Anims", "_defibpos", "_defibangle", "_posh", "_posi", "_dy", "_dx", "_dir", "_position", "_lootHolder", "_targetsbleedoutcountdown", "_secondsRemaining"];

_target = _this select 0;
_targetname = name _target;
_bodypos1    = [0.75,0.15,0];
_bodypos2    = [-0.75,0.1,0];
_bodypos3 	= [0,0.08,0];
_healPlace = "_bodypos1";
_action = "medicStartRightSide"; 
_bodypos = _bodypos1;	
_animstate = animationState _target;
_primaryw = primaryWeapon player;
_timer = 6; 
_Anims = ["ainvpknlmstpsnonwrfldnon_ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldr_medic0s","ainvpknlmstpsnonwrfldnon_medic0s","ainvpknlmstpsnonwrfldr_medic0","ainvpknlmstpsnonwrfldnon_medic0","ainvpknlmstpsnonwrfldr_medic1","ainvpknlmstpsnonwrfldnon_medic1","ainvpknlmstpsnonwrfldr_medic2","ainvpknlmstpsnonwrfldnon_medic2","ainvpknlmstpsnonwrfldr_medic3","ainvpknlmstpsnonwrfldnon_medic3","ainvpknlmstpsnonwrfldr_medic4","ainvpknlmstpsnonwrfldnon_medic4","ainvpknlmstpsnonwrfldr_medic5","ainvpknlmstpsnonwrfldnon_medic5"];
_defibpos = [0.4,0.9,0];
_defibangle = 30;

if !(isPlayer _target) exitWith {systemChat Format ["Theres no pulse..."]};

if (_target getVariable "EnigmaRevivePermitted") then 
{

	if (magazines player find "Exile_Item_Defibrillator" >= 0) then 
	{


		if ((player distance (_target modelToWorld _bodypos2))<((_target modelToWorld _bodypos1) distance player)) then 
		{ 
			_healPlace = "_bodypos2"; 
			_action = "medicStart"; 
			_bodypos = _bodypos2;	
			_defibpos = [0,0.9,0];
			_defibangle = 180;
		}; 
	 
		player attachTo [_target, _bodypos]; 

		_posh = player modelToWorld [0,0,0]; 
		_posi = _target modelToWorld _bodypos3; 
		_dy 	= (_posh select 1) - (_posi select 1); 
		_dx 	= (_posh select 0) - (_posi select 0); 
		_dir = getDir player; 
		player setDir (270 - (_dy atan2 _dx) - direction _target);	

		sleep 0.001; 

		player removeMagazine "Exile_Item_Defibrillator";
		_position = _target modelToWorld _defibpos;
		_lootHolder = createVehicle ["LootWeaponHolder", _position, [], 0, "CAN_COLLIDE"];
		_lootHolder setPosATL _position;
		_lootHolder addItemCargoGlobal ["Exile_Item_Defibrillator",1];
		_lootHolder setDir ((getDir _target) + _defibangle); 


		if (_primaryw == "") then 
		{ 

		_target switchMove "AinjPpneMstpSnonWrflDnon";
		sleep 0.2;
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
	
		} 
		else 
		{
			if (currentWeapon player != _primaryw) then 
			{
				player selectWeapon _primaryw;
				sleep 2;
			};
		
			player playActionNow _action;
			_timer = 15;
			waitUntil { animationState player in _Anims };
		};

		sleep _timer;
		detach player;

		if (_primaryw == "") then 
		{ 
			player switchmove ""; 
		} 
		else 
		{
			player switchAction "medicStart"; 
			player playActionNow "medicStop";
		};

		if (_target getVariable["REVIVE", true]) then 
		{ 
			_targetsbleedoutcountdown = _target getVariable "BleedoutCountDownEnd";
			_secondsRemaining = _targetsbleedoutcountdown - time; 
			if (_secondsRemaining >= 17) then
			{
				_target setVariable["antidupe", -1, true]; 
   				ENIGMA_revivePlayer = [_target,player,1];
   		    	publicVariableServer "ENIGMA_revivePlayer";
			} 
			else 
			{		
				systemChat Format ["RIP %1! They are too far gone!",_targetname];
			};
		} 
		else 
		{		
			systemChat Format ["RIP %1! They suffered a fatal injury!",_targetname];
		};
	}; 
}
else
{		
	systemChat Format ["RIP %1! They suffered a fatal injury!",_targetname];
};