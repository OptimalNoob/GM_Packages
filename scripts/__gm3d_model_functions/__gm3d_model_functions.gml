#region		CONSTRUCTORS

/// @function						attach_model3d(object_file, texture_source, use_mtl)
/// @arg {string}	object_file		| Filename of .obj model
/// @arg {resource}	texture_source	| Sprite used as texture
/// @arg {bool}		use_mtl			| Choose to include .mtl file during .obj import
///
/// @description						| Used for creating 3D Models to be used in Objects.
///									| Will first check that a Cached Buffer file already exists (faster import),
///									| if not then it will import the OBJ file provided (slower import).
function attach_model3d(object_file, texture_source, use_mtl) constructor {
	// Used for debugging import time.
	if(DEBUGMODELIMPORT) var t = get_timer();
	
	// Grab MTL Filepath if use_mtl is True
	if(use_mtl) var _mtl = mtl_get_path(object_file);
	else var _mtl = -1;
	
	// Check if the cached buffer file exists (Faster),
	// otherwise import the OBJ file from scratch (slower)
	if(file_exists(string(PATHBIN) + object_file + ".vbuff")){
		var vbuff_data = buffer_load(PATHBIN + object_file + ".vbuff");
		mesh = vertex_create_buffer_from_buffer(vbuff_data, VFormat);
		buffer_delete(vbuff_data)
	} else mesh = import_obj(object_file, _mtl, VFormat);
	
	objname = object_file;
	texture = texture_source;
	
	// Used for debugging import time.
	if (DEBUGMODELIMPORT) show_debug_message("Loading Object: '" + string(object_file) + "' took " + string((get_timer() - t) / 1000) + " milliseconds");
}

/// @function				transform3d(xx, yy, zz, rx, ry, rz, sx, sy, sz)
/// @arg {real} xx			| X Position
/// @arg {real} yy			| Y Position
/// @arg {real} zz			| Z Position
/// @arg {real} rotation_x	| X Rotation (Degrees)
/// @arg {real} rotation_y	| Y Rotation (Degrees)
/// @arg {real} rotation_z	| Z Rotation (Degrees)
/// @arg {real} scale_x		| X Scale
/// @arg {real} scale_y		| Y Scale
/// @arg {real} scale_z		| Z Scale
///
/// @description				| Used to create a Transform Matrix for handling Position, Rotationa and Scaling (for 3D Models/Objects)
function transform3d(xx, yy, zz, rx, ry, rz, sx, sy, sz) constructor {	
	pos = { x : xx, y : yy, z : zz }
	rot = { x : rx, y : ry, z : rz }
	scale = { x : sx, y : sy, z : sz }
}

#endregion

#region		MODEL MOVEMENT

/// @function		apply_transform(_mesh, _texture)
///
/// @description		| Submit Vertex Buffer for Model.
///					| Apply transformation matrix for Position, Rotation and Scale.
function apply_transform(_mesh, _texture){
	//if(FogEnabled) shader_set(sh_MainShader);
	if(_texture != -1) var tex = sprite_get_texture(_texture, 0);
	else var tex = -1;
	
	var mat = matrix_build(
		transform.pos.x, transform.pos.y, transform.pos.z,
		transform.rot.x, transform.rot.y, transform.rot.z,
		transform.scale.x, transform.scale.y, transform.scale.z
		);
	matrix_set(matrix_world, mat);
	vertex_submit(_mesh, pr_trianglelist, tex);
	matrix_world_reset();
	//shader_reset();
}

/// @function		matrix_world_reset()
///
/// @description		| Reset world matrix
function matrix_world_reset(){
	matrix_set(matrix_world, matrix_build_identity());
}

#endregion

#region		PATH FUNCTIONS

/// @function				obj_get_path(objname)
/// @arg {string} objname	| Name of .obj model name
///
/// @description				| Returns filepath for obj file based on PATHOBJ Macro
///							| and string in objname
/// @return {string}
function obj_get_path(objname){
	var str_out = string(PATHOBJ) + string(objname) + ".obj"
	return str_out;
}

/// @function				mtl_get_path(objname)
/// @arg {string} objname	| Name of .obj model name
///
/// @description				| Returns filepath for mtl file based on PATHOBJ Macro
///							| and string in objname
/// @return {string}
function mtl_get_path(objname){
	var str_out = string(PATHMTL) + string(objname) + ".mtl"
	return str_out;
}

#endregion