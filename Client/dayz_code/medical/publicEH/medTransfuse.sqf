// animHealed.sqf
private["_array","_unit","_medic","_display","_control","_lowBlood"];
disableserialization;
_array = _this; //_this select 0;
_unit = _array select 0;
_medic = _array select 1;

_rndInfection = (random 15);
_TransfusionInfection = (_rndInfection < 1);

if (_unit == player) then {
	r_player_blood = r_player_bloodTotal;
	r_player_lowblood = 	false;	
	10 fadeSound 1;
    if ((!r_player_tearGasOn) and (player distance (nearestObject [player,"SmokeShellTear"]) > 35) and (!r_player_tranq)) then {
	"dynamicBlur" ppEffectAdjust [0]; "dynamicBlur" ppEffectCommit 5;
	"colorCorrections" ppEffectAdjust [1, 1, 0, [1, 1, 1, 0.0], [1, 1, 1, 1],  [1, 1, 1, 1]];"colorCorrections" ppEffectCommit 5;
	};
    r_player_clear = true;
	if (_TransfusionInfection) then {
		r_player_infected = true;
		player setVariable["USEC_infected",true,true]; 
	};
	
	//Ensure Control is visible
	_display = uiNamespace getVariable 'DAYZ_GUI_display';
	_control = 	_display displayCtrl 1300;
	_control ctrlShow true;
	
	player setVariable["USEC_BloodQty",r_player_bloodTotal,true];
};
if (isServer) then {
	_unit setVariable["medForceUpdate",true];
};
