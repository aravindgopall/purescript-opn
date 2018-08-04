const path = require('path');
const child_process = require('process');

exports.process = process;
exports["open"] = function(val){
	return function(){
		var cmd = "open"; //getCmd();
		child_process.spawn(cmd,val)
		.then(function (){
			return;
		});
	}	
}

exports["getCmd"] = function(){
	return "open"
}

