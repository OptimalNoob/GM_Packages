/// @desc description

gridh = ds_grid_height(test_grid);
gridw = ds_grid_width(test_grid);



xx = 0; yy = 0;
repeat(gridh) {
	show_debug_message(string(test_grid[# 0, yy]) + ", " + string(test_grid[# 1, yy]));
	yy++;
}



game_end();