/// @function				backpackMap(_name)
/// @arg {Any} _name		| Main ID of the Backpack. 
///
/// @description			| Creates a Backpack instance that uses a
///						| DS Map datastructure for managing the inventory.
///
///						| *Used for backpacks with stackable items.
function backpackMap(_name) constructor {
	
	#region //** OBJECT VARIABLES **//
	
	static name = "backpack_" + string(_name);
	static contents = ds_map_create();
	
	
	#endregion
	
	#region //** OBJECT METHODS **//
	
	/// @description	| Returns size of backpack.
	/// @return {Real}
	static getSize = function (){
		return ds_map_size(contents);
	}
	
	/// @description Get backpack name
	/// @return {String}
	static toString = function () {
		return string(name)
	}
	
	#region		ADDER METHODS
	
	/// @arg {Any} item		| Item to add to Backpack.
	/// @arg {Real} amount	| Amount of items to add.
	///
	/// @description				| Adds an Item of a specified amount to the Backpack.
	static addItem = function (item, amount) {
		var item_exists = ds_map_find_value(contents, item)
		
		if(item_exists != undefined) contents[? item] += amount;
		else ds_map_add(contents, item, amount);
	}
	
	/// @arg {array} arr		| Array to add items from.
	///
	/// @description				| Add multiple items to backpack,
	///						| from an array.
	///						
	///						| If array is 1D, 1 of each item will be added.
	///
	///						| If array is 2D, adds items from 1st column of amount in 2nd column
	///
	///						| If array has more than 3 columns, returns -1, cannot determine what to add.
	static addItemsFromArray = function (arr) {
		
		var arr_size = array_length(arr);
		var arr_w = array_length(arr[0]);	// Returns undefined if no subarray is found (array would be 1D then)
		
		if(arr_w > 2) return -1; // Array has more than 2 columns.
		else if(is_undefined(arr_w)) { // Array has 1 column exactly.
			show_debug_message("Adding Items from 1D Array");
			var r = 0;
			repeat(arr_size - 1){
				addItem(arr[r], 1);
				r++;
			}
		}
		else { // Array has 2 columns exactly.
			show_debug_message("Adding Items from 2D Array");
			show_debug_message("Array is " + string(arr_size) + " in size.")
			var r = 0;
			repeat(arr_size){
				addItem(arr[r][0], arr[r][1]);
				r++;
			}
		}
	}
	
	/// @arg {Id.DsList} dslist		| DS List to add items from.
	///
	/// @description						| Add 1 item each from a ds_list.
	static addItemsFromList = function (dslist) {
		
		var list_size = ds_list_size(dslist);
		r = 0;
		repeat(list_size - 1) {
			addItem(dslist[| r], 1);
			r++;
		}
	}
	
	#endregion
	
	#region		REMOVER METHODS
	
	/// @arg {Any} item			| Item to remove from Backpack
	/// @arg {Real} amount		| Amount of the item to remove
	///
	/// @description				| Removes an item from the backpack contents,
	///							| returns reference to item that was removed.
	///
	///							| If all of the item is removed, deletes the entry from the backpack.
	///
	///							| Returns -1 if item doesn't exist.
	/// @returns {Any}
	static removeItem = function (item, amount) {
		var item_count = ds_map_find_value(contents, item);
		if(is_undefined(item_count) || amount > item_count) return -1;
		else {
			contents[? item] -= amount;
			if(contents[? item] == 0) ds_map_delete(contents, item);
			return item;
		}
	}
	
	#endregion
	
	#region		GETTER METHODS
	
	/// @description	| Get a 2D Array of all Items and Counts from Backpack.
	///
	///			| Returns -1 if Backpack is empty.
	/// @returns {Array<Array<Any>>}
	static getItems = function () {
		var key_array = [], value_array = [], kv_array = [], map_length = 0;
		ds_map_keys_to_array(contents, key_array);
		ds_map_values_to_array(contents, value_array);
		map_length = array_length(key_array);
		
		if(map_length == 0) return -1; // Backpack is Empty.
		else { // Create 2D Array of items and return it.
			r = 0;
			repeat(map_length) {
				kv_array[r][0] = key_array[r];
				kv_array[r][1] = value_array[r];
				r++;
			}
			return kv_array;
		}
	}
	
	/// @arg {Any}
	/// @description Get item count, returns -1 if none found.
	/// @return {Real}
	static getItemCount = function (item) {
		var item_count = ds_map_find_value(contents, item);
		if(is_undefined(item_count)) return -1;
		return item_count
	}
	
	#endregion
	
	#region		SORTING METHODS
	// DS MAPS CANNOT BE SORTED
	#endregion
	
	#endregion
	
}