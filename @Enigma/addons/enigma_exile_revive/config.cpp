
class CfgPatches 
{
	class enigma_exile_revive {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		author[]= {"Happydayz_EngimaTeam"}; 	
	};
};
class CfgFunctions 
{
	class EnigmaRevive
	{
		class main 
		{
			file = "\enigma_exile_revive\init";
			class init
			{
				preInit = 1;
			};
			class postinit
			{
				postInit = 1;
			};
		};
	};
};

