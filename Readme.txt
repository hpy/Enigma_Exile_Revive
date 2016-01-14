changelog

13/01/16 -- prevent duping of gear by revived player.
14/01/16 -- prevent accessing gear on player being revived (stops duping).



------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------HOW TO UPGRADE TO ENIGMA EXILE REVIVE V0.65--------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------

- Replace server pbo. Replace Enigma Revive folder in mission file. New Line for cfgcustomcode:

//////////////////////////////////////////////////////////////////////////////////////////////////////				
		
		class CfgExileCustomCode {
		
		ExileClient_object_player_death_startBleedingOut = "custom\EnigmaRevive\ExileClient_object_player_death_startBleedingOut.sqf"; //Happys Revive
		ExileClient_object_player_event_onInventoryOpened = "custom\EnigmaRevive\ExileClient_object_player_event_onInventoryOpened.sqf"; //Happys Revive AntiDupe ---NEW with v0.65
		};	
			
//////////////////////////////////////////////////////////////////////////////////////////////////////		




------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------HOW TO INSTALL ENIGMA EXILE REVIVE V0.65---------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------


First add the startup paramaters @Enigma_Exile to your server!

Copy the @Enigma_Exile Folder to your Server Root!



Open up your mission file and add the init.sqf line to your init.sqf file (Must be executed by both server and client!)!

Copy the Entire Custom folder into the root of your mission file!




Now open your mission file --- config.cpp


Locate the lines:

//////////////////////////////////////////////////////////////////////////////////////////////////////

			class Identify: ExileAbstractAction
			{
				title = "Identify Body";
				condition = "!(alive ExileClientInteractionObject)";
				action = "_this call ExileClient_object_player_identifyBody";
			};

//////////////////////////////////////////////////////////////////////////////////////////////////////			
			
			
			
Replace that whole section with this:



//////////////////////////////////////////////////////////////////////////////////////////////////////	

			class Identify: ExileAbstractAction
			{
				title = "Identify Body";
				condition = "!(alive ExileClientInteractionObject)";
				action = "_this call ExileClient_object_player_identifyBody";
			};
			
			//////////////Added by [_ZEN_]happydayz/////////////////
			
			class Revive: ExileAbstractAction
			{
				title = "Perform CPR";
				condition = "(!(alive ExileClientInteractionObject) && (ExileClientInteractionObject getVariable ['EnigmaRevivePermitted', true]) && (magazines player find 'Exile_Item_Defibrillator' >= 0))";
				action = "_this spawn Enigma_RevivePlyr";
			};			
			
//////////////////////////////////////////////////////////////////////////////////////////////////////				
			
			
			
			
			
			
			
			Next go to:

//////////////////////////////////////////////////////////////////////////////////////////////////////				
			
			
			class CfgExileCustomCode {};

//////////////////////////////////////////////////////////////////////////////////////////////////////				


and modify it to read:



//////////////////////////////////////////////////////////////////////////////////////////////////////				
		
		class CfgExileCustomCode {
		
		ExileClient_object_player_death_startBleedingOut = "custom\EnigmaRevive\ExileClient_object_player_death_startBleedingOut.sqf"; //Happys Revive
		ExileClient_object_player_event_onInventoryOpened = "custom\EnigmaRevive\ExileClient_object_player_event_onInventoryOpened.sqf"; //Happys Revive AntiDupe ---NEW with v0.65
		};	
			
//////////////////////////////////////////////////////////////////////////////////////////////////////				
		
					
					
					
					
					
					
			
Next you will either want to enable the Defibrilator to be purchased at the trader or add it to loot! I did both but just show how to add to trader here.


Go to:

//////////////////////////////////////////////////////////////////////////////////////////////////////				

	class FirstAid
	{
		name = "FirstAid";
		icon = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\itemacc_ca.paa";
		items[] = 
		{
			"Exile_Item_InstaDoc",
			"Exile_Item_Bandage",
			"Exile_Item_Vishpirin"

			// Not available in 0.9.4!
			//"Exile_Item_Defibrillator"
		};
	};

//////////////////////////////////////////////////////////////////////////////////////////////////////				


change it to:

//////////////////////////////////////////////////////////////////////////////////////////////////////				

	class FirstAid
	{
		name = "FirstAid";
		icon = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\itemacc_ca.paa";
		items[] = 
		{
			"Exile_Item_InstaDoc",
			"Exile_Item_Bandage",
			"Exile_Item_Vishpirin",

			// Used in Enigma Revive!
			"Exile_Item_Defibrillator"
		};
	};
	
//////////////////////////////////////////////////////////////////////////////////////////////////////				









	Next:

//////////////////////////////////////////////////////////////////////////////////////////////////////				

	//class Exile_Item_Defibrillator				{ quality = 1; price = 7500; };

//////////////////////////////////////////////////////////////////////////////////////////////////////				

	change to:

//////////////////////////////////////////////////////////////////////////////////////////////////////				
	
	class Exile_Item_Defibrillator				{ quality = 1; price = 7500; };

//////////////////////////////////////////////////////////////////////////////////////////////////////				



Players will only get the scroll option to defib the dead player whilst they are bleeding out, and if they are holding a defib! It will show up with the identify body scroll option!



There are a few settings you can modify inside the custom\EnigmaRevive\init.sqf






Note: this includes my add respect/poptabs server function for those who are running it already!

