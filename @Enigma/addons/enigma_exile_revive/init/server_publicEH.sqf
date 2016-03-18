diag_log format['Enigma Exile Revive: publicEH %1',time];

"ENIGMA_revivePlayer"	  addPublicVariableEventHandler{(_this select 1)call ENIGMA_server_revivePlayer};
