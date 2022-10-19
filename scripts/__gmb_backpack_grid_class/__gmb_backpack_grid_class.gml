/// @function backpackGrid(name, fixed_size)
/// @pure
/// @context constructor
/// @arg {Any} name			| ID/Name of backpack
/// @arg {Bool} [fixed_size]	| Whether or not the Backpack has a max size for items. [Default: False]
///
/// @description	| Creates new Backpack Grid Instance for managing inventory and items.
function backpackGrid(_name, _fixed_size = false) constructor {
	static name = "backpack_" + string(_name);
	static contents = ds_grid_create(2, 0);
	
	/// @pure
	/// @description	| Used to get backpack name
	static toString = function () {
		return string(name);
	}
	
	/// @pure
	/// @description	| Get size/height of Backpack (Total number of unique items)
	static getSize = function () {
		return ds_grid_height(contents);
	}
	
	/// @function getItemCount(item)
	/// @arg {Any} item	| Item to get count of.
	///
	/// @description	| Get the amount of an item in the Backpack.
	///
	///			| Returns -1 if item isn't found.
	/// @return {Real}
	static getItemCount = function (_item) {
		var gridh = ds_grid_height(contents);
		var item_row = ds_grid_value_y(contents, 0, 0, 0, gridh - 1, _item);
		if(item_row == -1) return -1; // Item was not found.
		var item_count = contents[# BPCOL.AMOUNT, item_row];
		return item_count;
	}
	
	/// @function	sortItems(col, asc)
	/// @arg {Real} [col]	| Column index to sort by. [Default: 0]
	/// @arg {Bool} [asc]	| Sort by Ascending order. [Default: True]
	///
	/// @description	| Sort the items in the Backpack, both arguments are optional.
	///
	///			| Default sort is by the first column, ascending.
	static sortItems = function (col = BPCOL.NAME, asc = true) {
		ds_grid_sort(contents, col, asc);
	}
	
	/// @function addItem(item, amount)
	/// @arg {Any} item	| Item to be added to the Backpack.
	/// @arg {Real} amount	| Amount of the item to be added.
	/// @description	| Adds a single item of varying quantity to the Backpack.
	static addItem = function (_item, _amount) {
		var gridh = ds_grid_height(contents), gridw = ds_grid_height(contents);
		
		if (gridh != 0) { // If Backpack is not empty/new
			// Check if item doesn't already exist
			if(!ds_grid_value_exists(contents, 0, 0, 0, gridh - 1, _item)) {
				// Add new row to grid
				ds_grid_resize(contents, gridw, gridh + 1);
				var gridh = ds_grid_height(contents);
				ds_grid_add(contents, 0, gridh - 1, _item);
			} else {
				var item_row = ds_grid_value_y(contents, 0, 0, 0, gridh - 1, _item);
				contents[# BPCOL.AMOUNT, item_row] += _amount;
			}
		} else { // Backpack is empty/new and has no height. Previous checks are not necessary, just add the item.
			ds_grid_resize(contents, gridw, 1);
			ds_grid_add(contents, BPCOL.NAME, 0, _item);
			ds_grid_add(contents, BPCOL.AMOUNT, 0, _amount);
		}
	}
	
	/// @function				addItemsFromArray(arr)
	/// @arg {Array<Any>}	| Array to add items from.
	///
	/// @description				| Add items from an array.
	///						
	///						| 1D Arrays should be a list of items, of which 1 of each will be added.
	///						
	///						| 2D Arrays should contain an item and amount in each row to be added.
	static addItemsFromArray = function (arr) {
		var arrl = array_length(arr);
		var arrw = array_length(arr[0]);
		var gridw = ds_grid_width(contents), gridh = ds_grid_height(contents);;
		
		if(arrw > gridw) return -1; // Array has more columns than the grid, can't add items.
		else if(is_undefined(arrw)) { // Array has 1 Column, add 1 of each item.
			r = 0;
			repeat(arrl - 1) {
				addItem(arr[r], 1);
				r++;
			}
		} else { // Array is 2D (fun times ahead).
			var r = 0;
			repeat (arrl - 1) {
				addItem(arr[r][0], arr[r][1]);
			}
		}
		
	}
	
	/// @function						addItemsFromList(dslist)
	/// @arg {Id.DsList<Any>} dslist	| DS List to add items from.
	///
	/// @description						| Adds 1 of each item from a DS List.
	static addItemsFromList = function (dslist) {
		var listl = ds_list_size(dslist);
		r = 0;
		repeat(listl) {
			addItem(dslist[| r], 1);
			r++;
		}
	}
	
	/// @function				removeItem(item, amount)
	/// @arg {Any} item		| Item to be removed.
	/// @arg {Real} amount	| How many of the item to remove.
	///
	/// @description				| Removes a specific amount of an item from the Backpack.
	///						
	///						| If the item is successfully removed, returns the remaining amount of the item.
	///						
	///						| Returns -1 if the item can't be found or if the requested amount of
	///						| the item is greater than the actual number of the item in the Backpack.
	/// @return {Real}
	static removeItem = function (_item, _amount) {
		var gridh = ds_grid_height(contents), gridw = ds_grid_width(contents);
		var item_row = ds_grid_value_y(contents, 0, 0, 0, gridh - 1, _item);
		
		if(item_row != -1) { // -1 returns if item doesn't exists
			var item_amount = contents[# BPCOL.AMOUNT, item_row];
			if(item_amount < _amount) return -1;
			else {
				contents[# BPCOL.AMOUNT, item_row] -= _amount;
				if(contents[# BPCOL.AMOUNT, item_row] <= 0) { // Once quantity reaches 0, "delete" the item row entirely.
					// But because there isn't a ds_grid_delete_row() function, have to do some trickery to ensure
					// that the row gets removed.
					ds_grid_set_region(contents, 0, item_row, gridw - 1, item_row, -1); // Replace entire item row with -1.
					ds_grid_sort(contents, BPCOL.NAME, false); // Put -1 row at bottom.
					ds_grid_resize(contents, gridw, gridh - 1); // Remove last row, deleting the item.
					ds_grid_sort(contents, BPCOL.NAME, true); // Sort list back to ascending.
					return 0;
				} else {
					var item_amount = contents[# BPCOL.AMOUNT, item_row];
					return item_amount;
				}
			}
		} else return -1;
	}
}
