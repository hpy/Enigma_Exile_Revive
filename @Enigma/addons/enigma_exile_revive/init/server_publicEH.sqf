diag_log format['Enigma Exile Revive: publicEH %1',time];

"ENIGMA_UpdateStats"		addPublicVariableEventHandler{(_this select 1)call ENIGMA_server_handle_UpdateStats};
"ENIGMA_revivePlayer"	  addPublicVariableEventHandler{(_this select 1)call ENIGMA_server_revivePlayer};
