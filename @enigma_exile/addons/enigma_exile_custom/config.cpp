
class CfgPatches 
{
	class enigma_exile_custom {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		author[]= {"Happydayz_EngimaTeam"}; 	
	};
};
class CfgFunctions 
{
	class EnigmaTeam 
	{
		class main 
		{
			file = "\enigma_exile_custom\init";
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

