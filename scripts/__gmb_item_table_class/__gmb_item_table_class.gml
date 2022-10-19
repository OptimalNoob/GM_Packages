/// @function	itemTable(_name, width = 3)
/// @arg {Real} width	| Number of columns in the item table.
///
/// @description	| Item Table Class for storing a list of all items in the game.
///			| Will be used with item_reigster() to add items to the list.
///
///			| Width determines the table column count. Each column is an item field for data.
function itemTable(_name, _width = 3) constructor {
	static width = _width;
	static name = "itemTable_" + string(_name);
	static items = ds_grid_create(width, 0);
	
	/// @description	| Get the name of the table.
	static toString = function () {
		return string(name);
	}
	
	/// @description	| Get the size of the table
	static getSize = function () {
		return ds_grid_height(items);
	}
	
	/// @description
	/// @arg {...*} var_args
	static registerItem = function () {
		// If more arguments are provided than there are columns in the item table.
		if(argument_count > width) {
			show_debug_message("Item " + string(argument[0]) + " could not be added as more item traits were provided than there were table columns");
			return -1;
		}
		
		var gridw = ds_grid_width(items), gridh = ds_grid_height(items);
		
		// Check if this is a new Grid
		if(gridh != 0){
			// Check if the item already exists, add the item if it doesn't exist, return message and -1 if it does.
			if(!ds_grid_value_exists(items, 0, 0, 0, gridh - 1, argument[0])){
				ds_grid_resize(items, gridw, gridh + 1); // Resize Grid to fit new item (add another row basically).
				var gridh = ds_grid_height(items); // Recheck the Grid height for the loop.
				r = 0;
				repeat(argument_count) { // Populate the last available row with the item data provided via the arguments.
					ds_grid_add(items, r, gridh - 1, argument[r]);
					r++;
				}
				return true;
			} else { // This runs if the item name was found in the first column of the table. (it already exists)
				show_debug_message("Item not added,\nItem: " + string(argument[0]) + " already exists");
				return -1;
			}
		} else { // If it's a new grid, skip all the initial checks and add the item.
			ds_grid_resize(items, gridw, gridh + 1); // Resize Grid to fit new item (add another row basically).
			var gridh = ds_grid_height(items); // Recheck the Grid height for the loop.
			r = 0;
			repeat(argument_count) { // Populate the last available row with the item data provided via the arguments.
				ds_grid_add(items, r, gridh - 1, argument[r]);
				r++;
			}
			return true;
		}
	}
	
	/// @arg {Array<Any>} arr	| Array to import items from.
	static registerItemsFromArray = function (arr) {
		var arrl = array_length(arr);
		var arrw = array_length(arr[0]);
		var gridw = ds_grid_width(items), gridh = ds_grid_height(items);
		
		if(arrw > gridw || is_undefined(arrw)) return -1; // Array has more columns than the table or is 1D, cannot add items.
		else {
			r = 0;
			repeat(arrl) {
				ds_grid_resize(items, gridw, gridh + 1)
				gridh = ds_grid_height(items);
				xx = 0;
				repeat(arrw) {
					items[# xx, gridh] = arr[r][xx];
					xx++;
				}
				r++;
			}
		}
	}
	
}