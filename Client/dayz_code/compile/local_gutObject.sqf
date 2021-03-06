private["_animalbody","_qty","_rawfoodtype","_ehLoc"];
_animalbody = _this select 0;
_qty = _this select 1;
_rawfoodtype =   getText (configFile >> "CfgSurvival" >> "Meat" >> typeOf _animalbody >> "rawfoodtype");

if (local _animalbody) then {
	for "_x" from 1 to _qty do {
		_animalbody addMagazine _rawfoodtype;
	};
		
	[time, _animalbody] spawn { 
		private ["_timer", "_body"]; 
		_timer = _this select 0; 
		_body = _this select 1; 
		while {(count magazines _body >0) and (time - _timer < 300) } do { 
			_curTime = time;
			waitUntil {time - _curTime >= 5};
		}; 
		//["dayzHideBody",_body] call broadcastRpcCallAll;
		dayzHideBody = _body;
		hideBody _body; // local player
		publicVariable "dayzHideBody"; // remote player
		_curTime = time;
		waitUntil {time - _curTime >= 5};
		deleteVehicle _body;
		true;
	};
	
} else {
	_ehLoc = "client";
	if (isServer) then { _ehLoc = "server"; };
	diag_log format["gutObject EH on %1 item not local ! Type: %2",_ehLoc,str(_animalbody)];
};