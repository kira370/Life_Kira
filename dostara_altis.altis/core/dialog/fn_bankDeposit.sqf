/*
	File: fn_bankDeposit.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Figure it out.
*/
private["_value","_dftfound","_plafond"];
_value = parseNumber(ctrlText 2702);

//Series of stupid checks
if(_value > 999999) exitWith {hint localize "STR_ATM_GreaterThan";};
if(_value < 0) exitWith {};
if(!([str(_value)] call life_fnc_isnumeric)) exitWith {hint localize "STR_ATM_notnumeric"};
if(_value > life_cash) exitWith {hint localize "STR_ATM_NotEnoughCash"};

_ac = missionNamespace getVariable ["accountBanque",[]];
{
	_tab = _x;
	_dft = _x select 3;
	_first = _x select 4;
	_type = [(_x select 1)] call life_fnc_typeCompte;
	if(_dft)exitWith{
		/*
			1. Epargne
			2. Courant
			3. Offshore
			4. Entreprise
			5. Organisme
		*/
		switch (_type) do {
			case 1 : {
				_plafond = [0] call life_fnc_plafond;
			};
			case 2 : {
				if(_first)then{
					_plafond = [1] call life_fnc_plafond;
				};
			};
			case 3 : {
				if(_first)then{
					_plafond = [2] call life_fnc_plafond;
				};
			};
		};
	};
}foreach _ac;

_valTot = life_atmcash + _value;
if(!(isNil "_plafond") && (_valTot > _plafond))exitWith{hint "Vous allez depasser le plafond de ce compte, impossible de deposer de l'argent."};

life_cash = life_cash - _value;
life_atmcash = life_atmcash + _value;
hint format[localize "STR_ATM_DepositMSG",[_value] call life_fnc_numberText];
call SOCK_fnc_updateBanque;
[] call life_fnc_atmMenu;
[6] call SOCK_fnc_updatePartial;