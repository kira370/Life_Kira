/*
	File: fn_queryAccountRequest.sqf
	Auteur: J. `Kira` D.

	Description:
	flemme

	PARAMETRES:
	1. STRING(UID)

	RETURNS:
	NONE

	CALL:
	[STRING] call KIRA_fnc_queryAccountRequest
*/
private["_tab"];
_uid = param[0,"",[""]];
_total = [];
_cpt = 0;
_accNormal = format["SELECT nam_account,numcompte,bankacc,dflt,first FROM banque WHERE playerid='%1' AND ((offshore ='0' AND entreprise='0') OR epargne ='1');",_uid];
_accResult = [_accNormal,2,true] call DB_fnc_asyncCall;
diag_log format["%1",_accResult];
_cpt = _cpt + count _accResult;
_total pushBack _accResult;

_accEntreprise = format["SELECT nam_account,numcompte,bankacc,dflt,first FROM banque WHERE playerid='%1' AND entreprise='1';",_uid];
_AccResultEnt = [_accEntreprise,2,true] call DB_fnc_asyncCall;
_total pushBack _AccResultEnt;
_cpt = _cpt + count _AccResultEnt;
diag_log format["%1",_AccResultEnt];

_accOffShore = format["SELECT nam_account,numcompte,bankacc,dflt,first FROM banque WHERE playerid='%1' AND offshore ='1';",_uid];
_accResultOff = [_accOffShore,2,true] call DB_fnc_asyncCall;
_total pushBack _accResultOff;
_cpt = _cpt + count _accResultOff;
diag_log format["%1",_accResultOff];
_ret = [_total,_cpt];
_ret;