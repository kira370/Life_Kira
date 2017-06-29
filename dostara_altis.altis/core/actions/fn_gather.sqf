/*
	File: fn_gather.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Main functionality for gathering.
*/
if(isNil "life_action_gathering") then {life_action_gathering = false;};
private["_gather","_itemWeight","_diff","_itemName","_val","_resourceZones","_zone"];
_resourceZones = ["apple_1","apple_2","apple_3","apple_4","peaches_1","peaches_2","peaches_3","peaches_4","heroin_1","cocaine_1","weed_1","opium_1","wine_1","wine_2","Ress_Sable_2","Ress_Sable_1","Ress_Sel_1",
				  "Ress_Bois_1","Ress_Bois_2","Ress_Bois_3","Ress_Bois_4"];
_zone = "";
//Find out what zone we're near
{
	if(player distance (getMarkerPos _x) < 30) exitWith {_zone = _x;};
} forEach _resourceZones;

if(_zone == "") exitWith {
	life_action_inUse = false;
};
//Get the resource that will be gathered from the zone name...
switch(true) do {
	case (_zone in ["apple_1","apple_2","apple_3","apple_4"]): {_gather = "apple"; _val = 3;};
	case (_zone in ["peaches_1","peaches_2","peaches_3","peaches_4"]): {_gather = "peach"; _val = 3;};
	case (_zone in ["heroin_1"]): {_gather = "heroinu"; _val = 1;};
	case (_zone in ["wine_1","wine_2"]): {_gather = "vinu"; _val = 3;};
	case (_zone in ["cocaine_1"]): {_gather = "cocaine"; _val = 1;};
	case (_zone in ["weed_1"]): {_gather = "cannabis"; _val = 1;};
	case (_zone in ["opium_1"]): {_gather = "opiumn"; _val = 1;};
	case (_zone in ["Ress_Bois_1","Ress_Bois_2","Ress_Bois_3","Ress_Bois_4"]): {_gather = "Bois"; _val = floor(random(4));};
	case (_zone in ["Ress_Sable_2","Ress_Sable_1"]): {_gather = "sand"; _val = floor(random(5));};
	case (_zone in ["Ress_Sel_1"]): {_gather = "salt_f"; _val = floor(random(3));};
	default {""};
};
//gather check??
if(vehicle player != player) exitWith {};
if(_val == 0) exitWith{hint "Votre recolte est pas bonne, vous avez jeter ce que vous avez recolté.";};
_diff = [_gather,_val,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
if(_diff == 0) exitWith {hint localize "STR_NOTF_InvFull"};
life_action_inUse = true;
for "_i" from 0 to 2 do
{
	player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
	waitUntil{animationState player != "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";};
	sleep 2.5;
};

if(([true,_gather,_diff] call life_fnc_handleInv)) then
{
	_itemName = [([_gather,0] call life_fnc_varHandle)] call life_fnc_varToStr;
	titleText[format[localize "STR_NOTF_Gather_Success",_itemName,_diff],"PLAIN"];
};

life_action_inUse = false;
