gml_pragma("global", "init_3d()"); // Init 3D during compile.
#region		INIT 3D ENVIRONMENT

///@function		init_3d()
///
///@description		| Enables the 3D environment
///					| Creates global vertex format for submitting buffers
function init_3d(){
	
	// Enable Z-Writing
	gpu_set_ztestenable(true);
	gpu_set_zwriteenable(true);
	
	// Create Global Vertext Format (Name can be changed of course)
	globalvar VFormat;
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_texcoord();
	vertex_format_add_color();
	VFormat = vertex_format_end();
	
	show_debug_message("Initialized GM 3D Environment :)");
}

#endregion

#region		IMPORT 3D MODELS TO VERTEX BUFFERS & CREATE CACHED BUFFER FILES

///@function							import_obj(obj_name, mtl_filename, format)
///@arg {Constant.File}		obj_filename	| OBJ file to read.
///@arg {Constant.File}		mtl_filename	| MTL file to read. [optional, -1 if no MTL File]
///@arg {Id.VertexFormat}	format			| Vertex Format to submit vertices to.
///
///@description								| Import vertex information from .obj Filetype. Takes in a filepath
///											| to the obj file,an optional path to an MTL file (use -1 if no MTL
///											| file is provided Generates a vertex buffer, populates with vertex
///											| Position, UV, and Normal data, and returns the buffer
///@return {Id.VertexBuffer}
function import_obj(obj_name, mtl_filename, format){
	
	// Open the file(s)
	var obj_file = file_text_open_read(obj_get_path(obj_name));
	if(mtl_filename != -1) var mtl_file = file_text_open_read(mtl_filename);
	
	// Initial Material Variables
	var mtl_name = "None";
	var active_mtl = "None";	
	var mtl_alpha = ds_map_create();
	var mtl_color = ds_map_create();
	ds_map_add(mtl_alpha, "None", 1);
	ds_map_add(mtl_color, "None", c_white);
	
	// Parse MTL file
	if(mtl_filename != -1) {
		while(not file_text_eof(mtl_file)){
			var line = file_text_read_string(mtl_file);
			file_text_readln(mtl_file);
			// Split each line around the space character
			var terms, index;
			index = 0;
			terms[0] = "";
			terms[string_count(line, " ")] = "";
			for (var i = 1; i <= string_length(line); i++){
				if (string_char_at(line, i) == " "){
					index++;
					terms[index] = "";
				} else {
					terms[index] = terms[index]+string_char_at(line, i);
				}
			}
			switch(terms[0]){
				case "newmtl":
					// Set the material name
					mtl_name = terms[1];
					break;
				case "Kd":
					// Diffuse color (the color we're concerned with)
					var red = real(terms[1])*255;
					var green = real(terms[2])*255;
					var blue = real(terms[3])*255;
					var color = make_color_rgb(red, green, blue);
					ds_map_set(mtl_color, mtl_name, color);
					break;
				case "d":
					// "dissolved" (alpha)
					var alpha = real(terms[1]);
					ds_map_set(mtl_alpha, mtl_name, alpha);
					break;
				default:
					// There are way more available attributes in mtl files, but we're only concerned with these three (two)
					break;
			}
		}
	}
	
	// Create the main vertex buffer
	var model = vertex_create_buffer();
	vertex_begin(model, VFormat);
	
	// Create lists for position/normal/texture data (position, normal, and UV coords)
	var vertex_x = ds_list_create();
	var vertex_y = ds_list_create();
	var vertex_z = ds_list_create();
	
	var vertex_nx = ds_list_create();
	var vertex_ny = ds_list_create();
	var vertex_nz = ds_list_create();
	
	var vertex_xtex = ds_list_create();
	var vertex_ytex = ds_list_create();
	
	// Parse OBJ file
	while(not file_text_eof(obj_file)){
		var line = file_text_read_string(obj_file);
		file_text_readln(obj_file);
		// Split each line around the space character
		var terms, index;
		index = 0;
		terms = array_create(string_count(line, " ") + 1, "");
		for (var i = 1; i <= string_length(line); i++){
			if (string_char_at(line, i) == " "){
				index++;
				terms[index] = "";
			} else {
				terms[index] += string_char_at(line, i);
			}
		}
		switch(terms[0]){
			// Add the vertex x, y an z position to their respective lists
			case "v":
				ds_list_add(vertex_x, real(terms[1]));
				ds_list_add(vertex_y, real(terms[2]));
				ds_list_add(vertex_z, real(terms[3]));
				break;
			// Add the vertex x and y texture position (or "u" and "v") to their respective lists
			case "vt":
				ds_list_add(vertex_xtex, real(terms[1]));
				ds_list_add(vertex_ytex, real(terms[2]));
				break;
			// Add the vertex normal's x, y and z components to their respective lists
			case "vn":
				ds_list_add(vertex_nx, real(terms[1]));
				ds_list_add(vertex_ny, real(terms[2]));
				ds_list_add(vertex_nz, real(terms[3]));
				break;
			case "f":
				// Split each term around the slash character
				for (var n = 1; n <= 3; n++){
					var data, index;
					index = 0;
					data = array_create(string_count(terms[n], "/") + 1, "");
					for (var i = 1; i <= string_length(terms[n]); i++){
						if (string_char_at(terms[n], i) == "/"){
							index++;
							data[index] = "";
						} else {
							data[index] += string_char_at(terms[n], i);
						}
					}
					// Look up the x, y, z, normal x, y, z and texture x, y in the already-created lists
					var xx = ds_list_find_value(vertex_x, real(data[0]) - 1);
					var yy = ds_list_find_value(vertex_y, real(data[0]) - 1);
					var zz = ds_list_find_value(vertex_z, real(data[0]) - 1);
					var xtex = ds_list_find_value(vertex_xtex, real(data[1]) - 1);
					var ytex = ds_list_find_value(vertex_ytex, real(data[1]) - 1);
					var nx = ds_list_find_value(vertex_nx, real(data[2]) - 1);
					var ny = ds_list_find_value(vertex_ny, real(data[2]) - 1);
					var nz = ds_list_find_value(vertex_nz, real(data[2]) - 1);
					
					var color = c_white;
					var alpha = 1;
					if (ds_map_exists(mtl_color, active_mtl)){
						color = ds_map_find_value(mtl_color, active_mtl);
					}
					if (ds_map_exists(mtl_alpha, active_mtl)){
						alpha = ds_map_find_value(mtl_alpha, active_mtl);
					}
					
					// Flip Vertical UV coord
					ytex = (-ytex) + 1;
					
					// Add the data to the vertex buffers
					vertex_position_3d(model, xx, yy, zz);
					vertex_normal(model, nx, ny, nz);
					vertex_texcoord(model, xtex, ytex);
					vertex_color(model, color, alpha);
				}
				break;
			case "usemtl":
				active_mtl = terms[1];
				break;
			default:
				break;
		}
	}
	
	// End the vertex buffer, destroy the lists, close the text file
	
	vertex_end(model);
	
	ds_list_destroy(vertex_x);
	ds_list_destroy(vertex_y);
	ds_list_destroy(vertex_z);
	ds_list_destroy(vertex_nx);
	ds_list_destroy(vertex_ny);
	ds_list_destroy(vertex_nz);
	ds_list_destroy(vertex_xtex);
	ds_list_destroy(vertex_ytex);
	ds_map_destroy(mtl_alpha);
	ds_map_destroy(mtl_color);
	
	file_text_close(obj_file);
	if(mtl_filename != -1) file_text_close(mtl_file);
	
	// Convert the Vertex Buffer to a Binary Buffer to be saved to a file.
	// This makes importing the model faster via the Buffer file if it already exists.	
	
	var buffer_convert = buffer_create_from_vertex_buffer(model, buffer_fixed, 1);
	///OLD : buffer_save(buffer_convert, "%USERFOLDER%\\Documents\\GameMakerStudio2\\Framework3d\\datafiles\\objbins\\" + string(obj_name) + ".vbuff");
	//buffer_save(buffer_convert, string(environment_get_variable("USERPROFILE")) + "/Documents/GameMakerStudio2/Framework3d/datafiles/objbins/" + string(obj_name) + ".vbuff");
	var paths = string(PROJDIR) + string(PATHBIN);
	var obj_filename = string(obj_name) + ".vbuff";
	var final_path = paths + obj_filename;
	
	buffer_save(buffer_convert, final_path);
	buffer_delete(buffer_convert);
	
	return model;
}

#endregion