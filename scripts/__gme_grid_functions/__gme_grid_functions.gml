/// @function				ds_grid_delete_column(grid, col)
/// @arg {grid} grid		| grid data structure
/// @arg {real} col		| column index
///
/// @description			| Deletes from a grid the column at a given
///						| column index. The grid is reduced in width
///						| by one.
///
///						| Warning: Attempting to delete a column from a grid
///						| with only one column will generate an error.
function ds_grid_delete_column(grid, col) {
    var gridw = ds_grid_width(grid);
    var gridh = ds_grid_height(grid);
 
    ds_grid_set_grid_region(grid, grid, col + 1, 0, gridw - 1, gridh - 1, col, 0);
    ds_grid_resize(grid, gridw - 1, gridh);
}

/// @function				ds_grid_delete_row(grid, row)
///
/// @arg {grid} grid		| grid data structure
/// @arg {real} row		| row index 
///
/// @description			| Deletes from a grid the row at a given row
///						| index. The grid is reduced in height by one.
///
///						| Warning: Attempting to delete a row from a grid
///						| with only one row will generate an error.
function ds_grid_delete_row(grid, row) {
    var gridw = ds_grid_width(grid);
    var gridh = ds_grid_height(grid);
 
    ds_grid_set_grid_region(grid, grid, 0, row + 1, gridw - 1, gridh - 1, 0, row);
    ds_grid_resize(grid, gridw, gridh - 1);
}

/// @function				ds_grid_swap_columns(grid, col1, col2)
/// @arg {grid} grid		| grid data structure
/// @arg {real} col1		| 1st column of the exchange
/// @arg {real} col2		| 2nd column of the exchange
///
/// @description			| Exchanges the contents of two entire grid columns. 
function ds_grid_swap_columns(grid, col1, col2) {
    for (var i = 0; i < ds_grid_height(grid); i++) {
        var temp_grid = ds_grid_get(grid, col1, i);
        ds_grid_set(grid, col1, i, ds_grid_get(grid, col2, i));
        ds_grid_set(grid, col2, i, temp_grid);
    }
}

/// @function ds_grid_swap_rows(grid, row1, row2)
/// @arg {grid} grid | grid data structure
/// @arg {real} row1 | 1st row of the exchange
/// @arg {real} row2 | 2nd row of the exchange
///
/// @description | Exchanges the contents of two entire grid rows. 
function ds_grid_swap_rows(grid, row1, row2) {
    for (var i = 0; i < ds_grid_width(grid); i++) {
        var temp_grid = ds_grid_get(grid, i, row1);
        ds_grid_set(grid, i, row1, ds_grid_get(grid, i, row2));
        ds_grid_set(grid, i, row2, temp_grid);
    }
}

/// @function ds_grid_create_from_array(array);
/// @arg {Array<Any>} array The array to create the DS Grid from.
/// @description Generates a DS Grid from a passed array.
function ds_grid_create_from_array(arr){
	var ds_grid;
	var array_l = array_length(arr);
	var array_w = array_length(arr[0]);
	
	ds_grid = ds_grid_create(array_w, array_l);
	
	var yy = 0;
	repeat(array_l){
		var quest_array = arr[yy];
		var xx = 0;
		repeat(array_w){
			ds_grid[# xx, yy] = quest_array[xx];
			xx++;
		}
		yy++
	}
	return ds_grid;
};