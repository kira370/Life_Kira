/*
	File: fn_insertPlayerInfo.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Read the file name... Explains it.
*/
if(life_session_completed) exitWith {}; //Why did this get executed when the client already initialized? Fucking arma...
cutText[localize "STR_Session_QueryFail","BLACK FADED"];
0 cutFadeOut 9999999;

[4] call life_fnc_RequestAccount;
[getPlayerUID player,profileName,life_cash,player] RemoteExecCall ["DB_fnc_insertRequest",2];