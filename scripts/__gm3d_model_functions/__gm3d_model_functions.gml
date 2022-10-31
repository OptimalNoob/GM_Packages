/* 3D MODELS
======================================== */

/// @arg {string}	object_file		| Filename of .obj model
/// @arg {resource}	texture_source	| Sprite used as texture
/// @arg {bool}		use_mtl			| Choose to include .mtl file during .obj import
///
/// @description					| Attaches 3D model to object, importing from obj or cache file.
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

/// @arg {real} x			| X position
/// @arg {real} y			| Y position
/// @arg {real} z			| Z position
/// @arg {real} rot_x		| X rotation in degrees
/// @arg {real} rot_y		| Y rotation in degrees
/// @arg {real} rot_z		| Z rotation in degrees
/// @arg {real} scale_x		| X scale
/// @arg {real} scale_y		| Y scale
/// @arg {real} scale_z		| Z scale
/// @description			| Creates a transform matrix for manipulating 3D models.
function transform3d(xx, yy, zz, rx, ry, rz, sx, sy, sz) constructor {	
	pos = { x : xx, y : yy, z : zz }
	rot = { x : rx, y : ry, z : rz }
	scale = { x : sx, y : sy, z : sz }
}

/// @arg {Id.Mesh} mesh			| Mesh/Model to apply transformation to.
/// @arg {Id.Texture} texture	| Texture of model, optional.
/// @description				| Apply transformation and model data to vertex buffer.
function apply_transform(_mesh, _texture = -1){
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
}

/// @description		| Reset world matrix
function matrix_world_reset(){
	matrix_set(matrix_world, matrix_build_identity());
}

