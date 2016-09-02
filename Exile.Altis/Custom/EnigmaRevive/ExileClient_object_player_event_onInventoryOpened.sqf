/**
 * ExileClient_object_player_event_onInventoryOpened
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

_cancelEvent = false;
_container = _this select 1;

try 
{
	if (ExileIsPlayingRussianRoulette) then 
	{
		throw true;
	};

	if (ExileClientIsHandcuffed) then 
	{
		throw true;
	};

	if (ExileClientActionDelayShown) then 
	{
		throw true;
	};

	// Dont double-place walls while in construction mode
	if (ExileClientIsInConstructionMode) then 
	{
		throw true;
	};

	// Cannot access locked vehicles
	if ((locked _container) isEqualTo 2) then
	{
		throw true;
	};

	// Cannot access locked containers
	if (_container getVariable ["ExileIsLocked", 1] isEqualTo -1) then 
	{
		throw true;
	};
	// Cannot access in progress revive player inventories
	if ((_container getVariable["antidupe", 1]) isEqualTo -1) then 
	{
		throw true;
	};

	ExileClientInventoryOpened = true;
	ExileClientCurrentInventoryContainer = _container;
}
catch 
{
	_cancelEvent = _exception;
};

_cancelEvent