///@func flagHandler()
///
///@desc	| Flag Handler
function flagHandler () constructor {
	static flags = ds_grid_create(2, 0);
	
	///@arg {Real} fid		| Flag ID to register.
	///@arg {Real} [sval]	| Starting Value [Default: 0]
	///
	///@desc				| Registers a flag in the flag table.
	static registerFlag = function (fid, sval = 0) {		
		var gridh = ds_grid_height(self.flags);
		
		var flag_exists = ds_grid_value_y(self.flags, FCOL.ID, 0, FCOL.ID, gridh - 1, fid);
		if(flag_exists == -1) { // Item doesn't exist yet, add the item.
			ds_grid_resize(self.flags, 2, gridh + 1);
			gridh = ds_grid_height(self.flags);
			ds_grid_add(self.flags, FCOL.ID, gridh - 1, fid);
			ds_grid_add(self.flags, FCOL.VAL, gridh - 1, sval);
		} else { // Item already exists, do not add item, do not pass go, do not collect $200.
			show_debug_message("You've been naughty, flag: " + string(fid) + ", already exists!");
			return -1;
		}
	}
	
	///@arg {Real} fid		| Flag ID to get the value of.
	///
	///@desc				| Get the current value of the specified flag.
	///
	///						| Returns Undefined if flag is not found.
	///@return {Real}
	static getFlagValue = function (fid) {
		var gridh = ds_grid_height(self.flags);
		var flag_row = ds_grid_value_y(self.flags, FCOL.ID, 0, FCOL.ID, gridh - 1, fid);
		if(flag_row != -1) { // Flag was found, return the value
			return self.flags[# FCOL.VAL, flag_row];
		} else { // Flag was not found, return message.
			show_debug_message("Flag: " + string(fid) + ", does not exist!");
			return undefined;
		}
	}
	
	///@arg {Real} fid		| Flag ID to set the value of.
	///@arg {Real} val		| Value to set the flag to.
	///
	///@desc				| Set the value of the specified flag.
	///
	///						| Returns Undefined if flag is not found.
	static setFlagValue = function (fid, val) {
		var gridh = ds_grid_height(self.flags);
		var flag_row = ds_grid_value_y(self.flags, FCOL.ID, 0, FCOL.ID, gridh - 1, fid);
		if(flag_row != -1) { // Flag was found, return the value
			self.flags[# FCOL.VAL, flag_row] = val;
		} else { // Flag was not found, return message.
			show_debug_message("Flag: " + string(fid) + ", does not exist!");
			return undefined;
		}
	}
	
	///@arg {Real} fid			| Flag ID to increment.
	///@arg {Real} [val]		| Value to increment flag by. [Default: 1]
	///
	///@desc					| Increments a flag by a specific value.
	///
	///							| Returns Undefined if flag is not found.
	static incrementFlag = function (fid, val = 1) {
		var gridh = ds_grid_height(self.flags);
		var flag_row = ds_grid_value_y(self.flags, FCOL.ID, 0, FCOL.ID, gridh - 1, fid);
		if(flag_row != -1) { // Flag was found, return the value
			self.flags[# FCOL.VAL, flag_row] += val;
		} else { // Flag was not found, return message.
			show_debug_message("Flag: " + string(fid) + ", does not exist!");
			return undefined;
		}
	}
	
	///@desc	| Get total number of flags stored.
	///@returns {Real}
	static getFlagCount = function () {
		return ds_grid_height(self.flags);
	}
	
}

enum FCOL {
	ID,		//0
	VAL		//1
}