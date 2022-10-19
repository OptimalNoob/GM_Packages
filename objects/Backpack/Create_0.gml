var arr = [
	["Item 1", sDev01, oNPC01],
	["Item 2", sDev02, oNPC02],
	["Item 3", sDev01, oNPC03],
	["Item 4", sDev02, oNPC04],
	["Item 5", sDev01, oNPC05]
];

grid = ds_grid_create_from_array(arr);

show_debug_grid(grid, "string", asset_sprite, asset_object);
game_end();