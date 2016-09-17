# Enigma-Exile-Revive-System
Exile Revive System


------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------HOW TO INSTALL ENIGMA EXILE REVIVE V0.80---------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------


ATTENTION!!!!

IF YOU USE DMS MISSION SYSTEM DO THE FOLLOWING!!!!

In DMS config.sqf ensure that the following is set:

DMS_ai_offload_Only_DMS_AI   = true;
The AI that was being spawned are being taken over by DMS and this will NOT WORK IF YOU HAVE IT SET TO FALSE!!!!! (which it is by default!)


First add the startup paramaters @Enigma to your server!

Copy the @Enigma Folder to your Server Root!


An alternative method is to open the @Enigma\addons folder and transfer any file ending with .pbo into your @ExileServer\addons\ folder where it will be loaded up automatically.


Open up your mission file and if you have an existing init.sqf then merge the execVM line into your init.sqf file (Must be executed by both server and client!)!
Otherwise simply copy the init.sqf into your mission file!

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
		
					
					
					
					
					
					
			
Next you will either want to enable the Defibrilator to be purchased at the trader!


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
			"Exile_Item_Vishpirin",
			"Exile_Item_Heatpack"

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
			"Exile_Item_Heatpack",
			"Exile_Item_Defibrillator"
		};
	};
	
//////////////////////////////////////////////////////////////////////////////////////////////////////				






	Next:

//////////////////////////////////////////////////////////////////////////////////////////////////////				

	class Exile_Item_InstaDoc                       { quality = 1; price = 1250; };
	class Exile_Item_Vishpirin						{ quality = 1; price = 300; };
	class Exile_Item_Bandage	                    { quality = 1; price = 100; };
	class Exile_Item_Heatpack	                    { quality = 1; price = 50; };

	//class Exile_Item_Defibrillator				{ quality = 1; price = 7500; };

//////////////////////////////////////////////////////////////////////////////////////////////////////				

	change to:

//////////////////////////////////////////////////////////////////////////////////////////////////////				
	
	class Exile_Item_InstaDoc                       { quality = 1; price = 1250; };
	class Exile_Item_Vishpirin						{ quality = 1; price = 300; };
	class Exile_Item_Bandage	                    { quality = 1; price = 100; };
	class Exile_Item_Heatpack	                    { quality = 1; price = 50; };

	class Exile_Item_Defibrillator				{ quality = 1; price = 7500; };

//////////////////////////////////////////////////////////////////////////////////////////////////////				



Players will only get the scroll option to defib the dead player whilst the target player is bleeding out, and if they (the player) are holding a defib! 
It will show up with the identify body scroll option as "Perform CPR".



There are a few settings you can modify inside the custom\EnigmaRevive\init.sqf




Note: this includes my add respect/poptabs server function for those who are running it already!

