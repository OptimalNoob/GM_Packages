///@func backpack_grid(name, w, fixed_size)
///@pure
///@context constructor
///@arg {Any} name			| ID/Name of backpack
///@arg {Real} w			| Width of Backpack Grid (columns for data)
///@arg {Bool} fixed_size	| Whether or not the Backpack has a max size for items. [Default: False]
///
///@desc	| Creates new Backpack Grid Instance for managing inventory and items.
function backpack_grid(_name, _w, _fixed_size = false) constructor {
	static name = "backpack_" + string(_name);
	static contents = ds_grid_create(_w, 0);
	
	///@pure
	///@desc	| Used to get backpack name
	static toString = function () {
		return string(name);
	}
	
	///@pure
	///@desc	| Get size/height of Backpack
	static getSize = function () {
		return ds_grid_height(contents);
	}
	
	
}