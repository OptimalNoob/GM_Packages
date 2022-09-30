///@func				backpack_list(_name)
///@arg {Any} _name		| Main ID of the Backpack.
///
///@description			| Backpack Class Init
function backpack_list(_name) constructor {
	
	#region //** OBJECT VARIABLES **//
	
	static name = _name
	static contents = ds_list_create();
	
	
	#endregion
	
	#region //** OBJECT METHODS **//
	
	///@desc			| Returns size of backpack.
	///@return {Real}
	static getSize = function (){
		return ds_list_size(contents);
	}
	
	///@desc Get backpack name
	///@return {String}
	static toString = function () {
		return "backpack_" + string(name)
	}
	
	#region		ADDER METHODS
	
	///@arg {Any} _item		| Item to add to Backpack.
	///
	///@desc				| Add a single item to backpack.
	static addItem = function (_item) {
		
		ds_list_add(contents, _item);
	}
	
	///@arg {array} _array	| Array to add items from.
	///
	///@desc				| Add multiple items to backpack,
	///						| from an array.
	static addItemsFromArray = function (_array) {
		
		var size = array_length(_array);
		for (i = 0; i < size; i++) ds_list_add(contents, _array[i]);
	}
	
	///@arg {Id.DsList} _dslist	| DS List to add items from.
	///
	///@desc						| Add multiple items to backpack, 
	///								| from a ds_list.
	static addItemsFromList = function (_dslist) {
		
		var size = ds_list_size(_dslist);
		for(i = 0; i < size; i++) ds_list_add(contents, _dslist[| i]);
	}
	
	#endregion
	
	#region		REMOVER METHODS
	
	///@arg {Real} slot			| Slot in backpack to remove item from.
	///
	///@description				| Removes an item from the backpack contents,
	///							| returns reference to item that was removed.
	///							| Returns -1 if slot doesn't exist.
	///#retuen {Any}
	static removeItemBySlot = function (slot) {
		
		var valid_slot = ds_list_find_value(contents, slot);
		if (valid_slot != undefined) {
			var item = ds_list_find_value(contents, slot);
			ds_list_delete(contents, _slot);
			return item;
		} else return -1;
	}
	
	///@arg {Any} item	| Item to remove
	///@desc			| Removes item and returns item slot for reference.
	///					| Returns -1 if item isn't found.
	///@return {Any}
	///@return {Real}
	static removeItem = function (item) {
		var item_slot = ds_list_find_index(contents, item);
		if(item_slot != -1){
			ds_list_delete(contents, item_slot);
			return item_slot;
		} else return -1;
	}
	
	///@arg {Any} item		| item to remove
	///@arg {Real} amount	| count of items to remove
	///@desc Removes items from backpack by amount, returns -1
	///		 if no items are found or if amount exceeds count of
	///		 items in the backpack
	///@return {Real}
	static removeItems = function (item, amount) {
		
		var list_size = ds_list_size(contents);
		var item_count = 0, r = 0;
		
		item_count = getSlotByItem(item);
		
		// Return -1 if requested amount is higher than item count
		// or if no items were found.
		if(item_count == -1 || amount > item_count) return -1;
		
		item_count = 0;
		r = 0;
		repeat (amount) {
			
			var index = ds_list_find_index(contents, item);
			ds_list_delete(contents, index);
		}
		
		return item_count;
	}
	
	#endregion
	
	#region		GETTER METHODS
	
	///@desc	| Returns reference to list of items
	///@return {Id.DsList}
	static getItems = function () {
		return contents;
	}
	
	///@arg {Real} slot	| Slot number to get item from.
	///@desc Get item stored in slot #.
	static getItemBySlot = function (slot) {
		return ds_list_find_value(contents, slot);
	}
	
	///@arg {Real}
	///@desc Get first instance of item in backpack, returns -1 if not found.
	///@return {Real}
	static getSlotByItem = function (item) {
		return ds_list_find_index(contents, item);
	}
	
	///@arg {Any}
	///@desc Get item count, returns -1 if none found.
	///@return {Real}
	static getItemCount = function (item) {
		var list_size = ds_list_size(contents);
		var item_count = 0, r = 0;
		
		// Check if at least 1 item exists, if not then return -1
		// if at least one item is found, reset the counter and begin
		// an actual count of the items.
		item_count = ds_list_find_index(contents, item);
		if(item_count == -1) return item_count;
		else {
			item_count = 0;
			// Count items in list
			repeat (list_size - 1) {
				var i = contents[| r]
				if(i == item) item_count++;
				r++;
			}
			return item_count;
		}
	}
	
	#endregion
	
	#region		SORTING METHODS
	
	///@desc	| Sorts contents in ascending order
	static sortAsc = function () {
		ds_list_sort(contents, true);
	}
	
	///@desc	| Sorts contents in descending order
	static sortDes = function () {
		ds_list_sort(contents, false);
	}
	
	#endregion
	
	#endregion
	
}