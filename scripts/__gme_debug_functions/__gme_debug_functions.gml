/// @arg {string} _message	| string to write to output
/// @description				| Abbreviated show_debug_message() function.
function sdm(_message) {
	show_debug_message(_message);
}

/// @arg {Id.DsGrid} grid	| Grid to output contents of.
/// @arg {...*} [var_args]		| Asset types of Columns
/// @desc	Writes contents of DS Grid to output console.
function show_debug_grid(_grid) {
	var gridw = ds_grid_width(_grid);
	var gridh = ds_grid_height(_grid);
	var yy = 0;
	repeat (gridh) {
		var xx = 0;
		var row_out = "";
		repeat (gridw) {
			if(argument_count != 1){
				switch(argument[xx + 1]) {
					case "string":
					case "String":
						row_out += string(_grid[# xx, yy]);
					break;
					case asset_object: row_out += object_get_name(_grid[# xx, yy]); break;
					case asset_sprite: row_out += sprite_get_name(_grid[# xx, yy]); break;
					case asset_sound: row_out += audio_get_name(_grid[# xx, yy]); break;
					case asset_room: row_out += room_get_name(_grid[# xx, yy]); break;
					case asset_tiles: row_out += tileset_get_name(_grid[# xx, yy]); break;
					case asset_path: row_out += path_get_name(_grid[# xx, yy]); break;
					case asset_script: row_out += script_get_name(_grid[# xx, yy]); break;
					case asset_font: row_out += font_get_name(_grid[# xx, yy]); break;
					case asset_timeline: row_out += timeline_get_name(_grid[# xx, yy]); break;
					case asset_shader: row_out += shader_get_name(_grid[# xx, yy]); break;
					case asset_animationcurve:
						var anim = animcurve_get(_grid[# xx, yy]);
						row_out += string(anim.name);
					break;
					case asset_sequence:
						var seq = sequence_get(_grid[# xx, yy]);
						row_out += string(seq.name);
					break;
					case asset_unknown: row_out += string(_grid[# xx, yy]); break;
					default: row_out += string(_grid[# xx, yy]); break;
				}
			} else {
				row_out += string(_grid[# xx, yy]);
			}
			if(xx < gridw - 1) row_out += " | ";
			xx++;
		}
		show_debug_message(row_out);
		yy++;
	}
	game_end();
}