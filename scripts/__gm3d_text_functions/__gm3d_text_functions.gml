#region		3D TEXT FUNCTIONS

/// @function draw_text_billboard
/// @arg {Real}				sxx		| X Position in World Space
/// @arg {Real}				yy		| Y Position in World Space
/// @arg {Real}				zz		| Z Position in World Space
/// @arg {Constant.Font}		fnt		| Font used for text
/// @arg {Constant.Color}	col		| Color of text
/// @arg {String}			txt		| Text to be drawn
///
/// @description						| Writes text to screen-space based on provided world-space coordinated.
///									| IMPORTANT: USED IN DRAW_GUI EVENT
function draw_text_billboard(xx, yy, zz, fnt, col, txt) {
	var name_pos = world_to_screen(xx, yy, zz, camera_get_view_mat(Camera3D), camera_get_proj_mat(Camera3D));
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_set_font(fnt);
	draw_set_color(col);
	draw_set_alpha(1.0);
	
	draw_text(name_pos[0], name_pos[1], txt);
}

#endregion

#region		UTILITY FUNCTIONS

/// @function					world_to_screen(xx, yy, zz, view_mat, proj_mat)
/// @arg {Real}	xx				| X Position
/// @arg {Real}	yy				| Y Position
/// @arg {Real}	zz				| Z Position
/// @arg {Array<Real>} view_mat	| View Matrix of Active Camera
/// @arg {Array<Real>} proj_mat	| Projection Matrix of Active Camera
///
/// @description					| Transforms a 3D world-space coordinate to a 2D window-space coordinate.
///								| Returns an array of [xx, yy]
///								| Returns [-1, -1] if the 3D point is not in view
/// @return {Array<Real>}
function world_to_screen(xx, yy, zz, view_mat, proj_mat){
	if (proj_mat[15] == 0) {	// If using perspective projection
	    var w = view_mat[2] * xx + view_mat[6] * yy + view_mat[10] * zz + view_mat[14];
	    if (w <= 0) return [-1, -1];
	    var cx = proj_mat[8] + proj_mat[0] * (view_mat[0] * xx + view_mat[4] * yy + view_mat[8] * zz + view_mat[12]) / w;
	    var cy = proj_mat[9] + proj_mat[5] * (view_mat[1] * xx + view_mat[5] * yy + view_mat[9] * zz + view_mat[13]) / w;
	} else {	// If using orthographic projection
	    var cx = proj_mat[12] + proj_mat[0] * (view_mat[0] * xx + view_mat[4] * yy + view_mat[8]  * zz + view_mat[12]);
	    var cy = proj_mat[13] + proj_mat[5] * (view_mat[1] * xx + view_mat[5] * yy + view_mat[9]  * zz + view_mat[13]);
	}

	return [(0.5 + 0.5 * cx) * display_get_gui_width(), (0.5 - 0.5 * cy) * display_get_gui_height()];
}

#endregion