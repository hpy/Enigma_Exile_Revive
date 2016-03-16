/*
Exile_RevivePlayer.sqf
[_ZEN_] Happydayz
© 2016 Enigma Team
*/

private["_handguntype","_handgunammo","_player","_playerID","_playerPos","_reviveused","_reviverownerID","_bambiPlayerID","_playerPos","_data","_extDB2Message","_revivername","_msg","_reviveused","_ind","_playerID","_sessionID","_requestingPlayer", "_requestingPlayerUID", "_items", "_dir", "_location", "_type", "_weapon", "_attachments", "_currWeap", "_itemSlot", "_itemqtys", "_goggles", "_headgear", "_vest", "_backpack", "_uniform", "_weapons", "_magazinesAmmo", "_itemsplayer", "_weaponsplayer", "_group", "_primaryWeapon", "_secondaryWeapon", "_attachment", "_equipped", "_wMags", "_requestingPlayerGroup", "_droppedWeapons", "_bambiPlayer", "_ownerID", "_reviver"];

_requestingPlayer = _this select 0;
_ownerID = owner _requestingPlayer;
_reviver = _this select 1;
_reviverownerID = owner _reviver;
_sessionID = _requestingPlayer getVariable ["ExileSessionID",""];
_reviversessionID = _reviver getVariable ["ExileSessionID",""];
_name = name _requestingPlayer;
_revivername = name _reviver;
_clanID = (_accountData select 4);
_clanName = (_accountData select 5);
_playerID = _requestingPlayer getVariable["ExileDatabaseID", -1];

if (isNull _requestingPlayer) exitWith{ diag_log "EnigmaRevive - No requesting player"};

if (_requestingPlayer distance _reviver > 5) exitWith{ diag_log "EnigmaRevive - Too far from target"};

if (!local _requestingPlayer) then {
	_requestingPlayerUID = getPlayerUID _requestingPlayer;
	if (!isNil "_requestingPlayerUID" && !alive _requestingPlayer) then {

		_accountData = format["getAccountStats:%1", _requestingPlayerUID] call ExileServer_system_database_query_selectSingle;

			if (_requestingPlayer == _reviver) exitWith {
				Diag_log format ["Enigma Revive - Attempted hack revive by %1",_requestingPlayer];
				};

				_ind = ((count ReviveChk_cache) - 1);

				{
    		if (_playerID in _x) then {
        _reviveused = _x select 1;
        _ind = _forEachIndex;
    			};
				} forEach ReviveChk_cache;

					if (isNil "_reviveused") then {_reviveused = 0;}; //if not found in array then they havent used a revive this life so set to 0!

//							if ((_requestingPlayer getVariable["REVIVE", false])||(_reviveused > MaxRevivesAllowed)) exitWith{ //somewhere on first revive im setting variable to false... WHERE!?!?!?!?!
							if (_reviveused == MaxRevivesAllowed) exitWith{
  EnigmaReviveFail = [_requestingPlayer, _revivername];
	_ownerID publicVariableClient "EnigmaReviveFail";

	_msgarray = [];
	_msgarray = [
	"You put the probes in the wrong place!",
	"You didnt let the defib charge for long enough!",
	"You forgot to lubricate the probes! You smell sizzling flesh! Oops!"
	];

	_randommsg = _msgarray call BIS_fnc_selectRandom;

	_msg = format ["%1 You killed %2!",_randommsg,_name];

	EnigmaReviveMSG = [_msg]; //make the _reviver kill the player! hehehehe
	_reviverownerID publicVariableClient "EnigmaReviveMSG";

};


		if (_requestingPlayer getVariable["REVIVE", true]) then {

				_location = getPosATL _requestingPlayer;
				_dir = getDir _requestingPlayer;
				_requestingPlayerGroup = _requestingPlayer getVariable["GROUP", ""];
				_goggles = goggles _requestingPlayer;
				_headgear = headgear _requestingPlayer;
				_vest = vest _requestingPlayer;
				_backpack = backpack _requestingPlayer;
				_uniform = uniform _requestingPlayer;
				_items = assignedItems _requestingPlayer;
			_magazinesAmmo = magazinesAmmo _requestingPlayer;


			_handgunammo = _requestingPlayer ammo handgunWeapon _requestingPlayer; //counts rounds in magazine inside handgun

					_handguntype = handgunWeapon _requestingPlayer;

_primaryWeapon = "";
_secondaryWeapon = "";

				_itemsplayer = [getItemCargo(uniformContainer _requestingPlayer), getItemCargo(vestContainer _requestingPlayer), getItemCargo(backpackContainer _requestingPlayer)];
				_weaponsplayer = [getWeaponCargo(uniformContainer _requestingPlayer), getWeaponCargo(vestContainer _requestingPlayer), getWeaponCargo(backpackContainer _requestingPlayer)];
				_weapons = [currentWeapon _requestingPlayer, (weaponsItems _requestingPlayer), [_primaryWeapon, _secondaryWeapon, handgunWeapon _requestingPlayer]];
				hideObjectGlobal _requestingPlayer;
				_group = grpNull;
				_group = createGroup independent;
				_bambiPlayer = _group createUnit["Exile_Unit_Player", _location, [], 0, "CAN_COLLIDE"];
				_bambiPlayer allowDammage false;
				_bambiPlayer disableAI "FSM";
				_bambiPlayer disableAI "MOVE";
				_bambiPlayer disableAI "AUTOTARGET";
				_bambiPlayer disableAI "TARGET";
				_bambiPlayer disableAI "CHECKVISIBLE";

				if !((typeName _clanID) isEqualTo "SCALAR") then
				{_clanID = -1;
				_clanName = "";};

				_bambiPlayer setFatigue FatiguewhenRevived;
				_bambiPlayer setDamage DamageWhenRevived;
				_bambiPlayer setDir _dir;
				_bambiPlayer setPosATL _location;

				if (_uniform != "") then {_bambiPlayer addUniform _uniform;};
				if (_backpack != "") then {_bambiPlayer addBackpack _backpack;};
				if (_goggles != "") then {_bambiPlayer addGoggles _goggles;};
				if (_headgear != "") then {_bambiPlayer addHeadgear _headgear;};
				if (_vest != "") then {_bambiPlayer addVest _vest;};


				if (count _weapons >= 2) then {

					_equipped = _weapons select 2;
					{
						_weapon = _x select 0;
						_type = getNumber(configfile >> "cfgweapons" >> _weapon >> "type");

						_attachments = [];
						for "_a" from 1 to 3 do {
							_attachment = _x select _a;
							if (_attachment != "") then {
								_attachments pushBack _attachment;
							};
						};
						_wMags = (count _x) == 5;


						if (_weapon in _equipped) then {
							_equipped = _equipped - [_weapon];

							if (_wMags) then { _bambiPlayer addMagazine(_x select 4);};

							if (_weapon != "") then { _bambiPlayer addWeapon _weapon;};

							switch _type do {
								case 1: { removeAllPrimaryWeaponItems _bambiPlayer; { _bambiPlayer addPrimaryWeaponItem _x }forEach _attachments;};
								case 2:	{ removeAllHandgunItems _bambiPlayer; { _bambiPlayer addHandgunItem _x }forEach _attachments;};
								case 4:	{ { _bambiPlayer addSecondaryWeaponItem _x }forEach _attachments;};};
						} else {{_bambiPlayer addItem _x;}forEach _attachments;

							if (_wMags) then {_bambiPlayer addMagazine(_x select 4);};};} forEach (_weapons select 1);

					_currWeap = (_weapons select 0);

				};

				{if (_x in ["Binocular","Rangefinder","Laserdesignator","Laserdesignator_02","Laserdesignator_03"]) then {_bambiPlayer addWeapon _x;} else {_bambiPlayer linkItem _x;};}forEach _items;

				{_itemSlot = _forEachIndex;
					_itemqtys = _x select 1;
					{for "_i" from 1 to (_itemqtys select _forEachIndex) do {
						switch _itemSlot do {
						case 0: { _bambiPlayer addItemToUniform _x };
						case 1: { _bambiPlayer addItemToVest _x };
						case 2: { _bambiPlayer addItemToBackpack _x };
						};
					};

					}forEach (_x select 0);
				}forEach _itemsplayer;

				{_itemSlot = _forEachIndex;
					_itemqtys = _x select 1;
					{for "_i" from 1 to (_itemqtys select _forEachIndex) do {
						switch _itemSlot do {
						case 0: { _bambiPlayer addItemToUniform _x };
						case 1: { _bambiPlayer addItemToVest _x };
						case 2: { _bambiPlayer addItemToBackpack _x };
						};
					};
				}forEach (_x select 0);
				}forEach _weaponsplayer;
				{_bambiPlayer addMagazine _x;}forEach _magazinesAmmo;

_bambiPlayer addMagazine [_handguntype, _handgunammo]; //fix handgun losing its ammo! puts mag back into inventory ---Not working... something removes the mag after 10 seconds or so... guessing exile load up!



_bambiPlayer setName _name;

if (GR8HumanityInstalled) then {
_bambiPlayer setVariable ["ExileMoney", (_accountData select 0)];
_bambiPlayer setVariable ["ExileScore", (_accountData select 1)];
_bambiPlayer setVariable ["ExileHumanity", (_accountData select 2)];
_bambiPlayer setVariable ["ExileKills", (_accountData select 3)];
_bambiPlayer setVariable ["ExileDeaths", (_accountData select 4)];
} else {
_bambiPlayer setVariable ["ExileMoney", (_accountData select 0)];
_bambiPlayer setVariable ["ExileScore", (_accountData select 1)];
_bambiPlayer setVariable ["ExileKills", (_accountData select 2)];
_bambiPlayer setVariable ["ExileDeaths", (_accountData select 3)];
};

_bambiPlayer setVariable ["ExileClanID", _clanID];
_bambiPlayer setVariable ["ExileClanName", _clanName];
_bambiPlayer setVariable ["ExileHunger", 50]; //ur hungry
_bambiPlayer setVariable ["ExileThirst", 50]; //ur thirsty
_bambiPlayer setVariable ["ExileTemperature", 36]; //ur cold and clammy from death!
_bambiPlayer setVariable ["ExileWetness", 0];
_bambiPlayer setVariable ["ExileAlcohol", 0.1]; //ur a little woozy 
_bambiPlayer setVariable ["ExileName", _name]; 
_bambiPlayer setVariable ["ExileOwnerUID", getPlayerUID _requestingPlayer]; 
_bambiPlayer setVariable ["ExileIsBambi", true];
_bambiPlayer setVariable ["ExileXM8IsOnline", false, true];

//diag_log format ["Bambiplayer = %1 --- _sessionID = %2",_bambiPlayer,_sessionID];


private["_player","_playerID","_playerPos","_data","_extDB2Message"];
_player = _bambiPlayer;
_playerID = format["createPlayer:%1:%2", _player getVariable ["ExileOwnerUID", "SomethingWentWrong"], _player getVariable ["ExileName", "SomethingWentWrong"]] call ExileServer_system_database_query_insertSingle;
_player setVariable ["ExileDatabaseID", _playerID];


_playerPos = getPosATL _player;
_data =
[
	_player getVariable ["ExileName",""],
	damage _player,
	_player getVariable ["ExileHunger", 100],
	_player getVariable ["ExileThirst", 100],
	_player getVariable ["ExileAlcohol", 0],
	getOxygenRemaining _player,
	getBleedingRemaining _player,
	_player call ExileClient_util_player_getHitPointMap,
	getDir _player,
	_playerPos select 0,
	_playerPos select 1,
	_playerPos select 2,
	assignedItems _player,
	backpack _player,
	(getItemCargo backpackContainer _player) call ExileClient_util_cargo_getMap,
	(backpackContainer _player) call ExileClient_util_cargo_getMagazineMap,
	(getWeaponCargo backpackContainer _player) call ExileClient_util_cargo_getMap,
	currentWeapon _player,
	goggles _player,
	handgunItems _player,
	handgunWeapon _player,
	headgear _player,
	binocular _player,
	_player call ExileClient_util_inventory_getLoadedMagazinesMap,
	primaryWeapon _player,
	primaryWeaponItems _player,
	secondaryWeapon _player,
	secondaryWeaponItems _player,
	uniform _player,
	(getItemCargo uniformContainer _player) call ExileClient_util_cargo_getMap,
	(uniformContainer _player) call ExileClient_util_cargo_getMagazineMap,
	(getWeaponCargo uniformContainer _player) call ExileClient_util_cargo_getMap,
	vest _player,
	(getItemCargo vestContainer _player) call ExileClient_util_cargo_getMap,
	(vestContainer _player) call ExileClient_util_cargo_getMagazineMap,
	(getWeaponCargo vestContainer _player) call ExileClient_util_cargo_getMap,
	_player getVariable ["ExileTemperature", 0],
	_player getVariable ["ExileWetness", 0],
	_playerID
];
_extDB2Message = ["updatePlayer", _data] call ExileServer_util_extDB2_createMessage;
_extDB2Message call ExileServer_system_database_query_fireAndForget;

 _player setVariable ["REVIVE", true, true];
 _bambiPlayer setVariable ["REVIVE", true, true];

												_ind = ((count ReviveChk_cache) - 1);

																{
																    if (_bambiPlayerID in _x) then {
    																    _reviveused = _x select 1;
    																    _ind = _forEachIndex;
  																				  };
																} forEach ReviveChk_cache;

											_reviveused = _reviveused + 1;
 												ReviveChk_cache set [_ind, [_playerID, _reviveused]]; //add this revive to total number of player revives!

 								//just in case the array check fails (they are fickle beasts sometimes when servers are under load!)
 									if (_reviveused > MaxRevivesAllowed) then {
 												_bambiPlayer setVariable ["REVIVE", false, true];
 											};



									_msg = format ["%1 has been stabilised! You have been rewarded 100 Respect!",_name];

									EnigmaReviveMSG = [_msg]; //sends message to reviver!
									_reviverownerID publicVariableClient "EnigmaReviveMSG";

									
if (GR8HumanityInstalled) then {

_newScore = _requestingPlayer getVariable ["ExileHumanity", 0];
_newScore = _newScore;
_requestingPlayer setVariable ["ExileHumanity", _newScore];
format["setAccountHumanity:%1:%2", _newScore, getPlayerUID _requestingPlayer] call ExileServer_system_database_query_fireAndForget;

[
	_sessionID,
	"loadPlayerResponse",
	[
		(netId _player),
		str (_player getVariable ["ExileMoney", 0]),
		str (_player getVariable ["ExileScore", 0]),
		str (_player getVariable ["ExileHumanity", 0]),		
		(_player getVariable ["ExileKills", 0]),
		(_player getVariable ["ExileDeaths", 0]),
		(_player getVariable ["ExileHunger", 100]),
		(_player getVariable ["ExileThirst", 100]),
		(_player getVariable ["ExileAlcohol", 0]),
		(_player getVariable ["ExileClanName", ""]),
		(_player getVariable ["ExileTemperature", 0]),
		(_player getVariable ["ExileWetness", 0])
	]
]
call ExileServer_system_network_send_to;
[_sessionID, _player] call ExileServer_system_session_update;


} else {


_newScore = _requestingPlayer getVariable ["ExileScore", 0];
_newScore = _newScore + 100;
_requestingPlayer setVariable ["ExileScore", _newScore];
format["setAccountScore:%1:%2", _newScore, getPlayerUID _requestingPlayer] call ExileServer_system_database_query_fireAndForget;

[
	_sessionID,
	"loadPlayerResponse",
	[
		(netId _player),
		str (_player getVariable ["ExileMoney", 0]),
		str (_player getVariable ["ExileScore", 0]),
		(_player getVariable ["ExileKills", 0]),
		(_player getVariable ["ExileDeaths", 0]),
		(_player getVariable ["ExileHunger", 100]),
		(_player getVariable ["ExileThirst", 100]),
		(_player getVariable ["ExileAlcohol", 0]),
		(_player getVariable ["ExileClanName", ""]),
		(_player getVariable ["ExileTemperature", 0]),
		(_player getVariable ["ExileWetness", 0])
	]
]
call ExileServer_system_network_send_to;
[_sessionID, _player] call ExileServer_system_session_update;

};							
		

_player addMPEventHandler ["MPKilled", {_this call ExileServer_object_player_event_onMpKilled}];


_requestingPlayer setposatl [0,0,0]; //reports of body duping still

_corpseGroup = createGroup independent; //test to prevent dead body still being in players group under certain circumstances
[_requestingPlayer] joinSilent _corpseGroup;
deleteVehicle _requestingPlayer;

  EnigmaRevive = [];
	_ownerID publicVariableClient "EnigmaRevive";

_player allowDamage true;		//test to fix players having god mode against AI after revive	
				
			};

	};
};
