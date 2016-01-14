/*
[_ZEN_] Happydayz
------ ENIGMA ------
*/

Private["_target","_newmoneyvalue","_newscorevalue","_newMoney","_newScore"];

_target = _this select 0;
_newmoneyvalue = _this select 1;
_newscorevalue = _this select 2;

diag_log ["%1 Executing Exile_UpdateStats, Adding %2 Poptabs and %3 Respect",_target,_newmoneyvalue,_newscorevalue];

if (_newmoneyvalue > 0) then {

			_target setVariable ['ExileMoney', _newmoneyvalue];

			_target setVariable['PLAYER_STATS_VAR',[_newmoneyvalue,_target getVariable ['ExileScore', 0]],true];
			ExileClientPlayerMoney = _newmoneyvalue;
			(owner _target) publicVariableClient 'ExileClientPlayerMoney';

			format['setAccountMoney:%1:%2', _newmoneyvalue, (getPlayerUID _target)] call ExileServer_system_database_query_fireAndForget;
		};

if (_newscorevalue > 0) then
		{

			_target setVariable ['ExileScore', _newscorevalue];

			_target setVariable['PLAYER_STATS_VAR',[_target getVariable ['ExileMoney', 0],_newscorevalue],true];
			ExileClientPlayerScore = _newscorevalue;
			(owner _target) publicVariableClient 'ExileClientPlayerScore';

			format['setAccountScore:%1:%2', _newscorevalue, (getPlayerUID _target)] call ExileServer_system_database_query_fireAndForget;
		};
