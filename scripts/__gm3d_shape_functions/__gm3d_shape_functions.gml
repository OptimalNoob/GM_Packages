#region		3D PRIMITIVE DRAWING FUNCTIONS

/// @function			vertex_add_point(buffer, xx, yy, zz, nx, ny, nz, utex, vtex, col, alph)
/// @arg {ref} buffer	| Vertex Buffer to add point to
/// @arg {real} xx		| X value of Position
/// @arg {real} yy		| Y value of Position
/// @arg {real} zz		| Z value of Position
/// @arg {real} nx		| X direction of Normal
/// @arg {real} ny		| Y direction of Normal
/// @arg {real} nz		| Z direction of Normal
/// @arg {real} utex		| U value of Texcoord (Between 0 and 1)
/// @arg {real} vtex		| V value of Texcoord (Between 0 and 1)
///
/// @description Adds a single Vertex in 3D Space
function vertex_add_point(buffer, xx, yy, zz, nx, ny, nz, utex, vtex, col, alph) {
	vertex_position_3d(buffer, xx, yy, zz);
	vertex_normal(buffer, nx, ny, nz);
	vertex_texcoord(buffer, utex, vtex);
	vertex_color(buffer, col, alph);
}

/// @function			draw_3d_cube(vbuf, xx, yy, zz, ww, ll, hh)
/// @param {ref} vbuf	| Vertex Buffer to add shape to
/// @param {real} xx		| X POS
/// @param {real} yy		| Y POS
/// @param {real} zz		| Z POS
/// @param {real} ww		| Width (X)
/// @param {real} ll		| Length (Z)
/// @param {real} hh		| Height (Y)
///
/// @description Adds Cube Primitive in 3D space
function draw_3d_cube(vbuf, xx, yy, zz, ww, ll, hh){
	var x1, x2, y1, y2, z1, z2, rw, rl, rh;
	var c1 = make_color_rgb(255, 255, 255); //		\
	var c2 = make_color_rgb(191, 191, 191);	//		| Colors to create fake shading (set to c_white if implementing lighting/shading)
	var c3 = make_color_rgb(127, 127, 127);	//		/
	
	// Calculate Midpoints
	rw = ww / 2; rl = ll / 2; rh = hh / 2;
	
	// Apply midpoints to xyz coords
	x1 = xx - rw; x2 = xx + rw;
	y1 = yy - rh; y2 = yy + rh;
	z1 = zz - rl; z2 = zz + rl;
	
	///			   [vbuff]  [xyz pos]    [norm]     [UV]    [Colors]
	
	// FRONT
	vertex_add_point(vbuf, x1, y1, z1,	1, 0, 0,	0, 0,	c1, 1);
	vertex_add_point(vbuf, x1, y2, z1,	1, 0, 0,	0, 0,	c1, 1);
	vertex_add_point(vbuf, x2, y2, z1,	1, 0, 0,	0, 0,	c1, 1);
	vertex_add_point(vbuf, x2, y2, z1,	1, 0, 0,	0, 0,	c1, 1);
	vertex_add_point(vbuf, x2, y1, z1,	1, 0, 0,	0, 0,	c1, 1);
	vertex_add_point(vbuf, x1, y1, z1,	1, 0, 0,	0, 0,	c1, 1);
	
	// LEFT
	vertex_add_point(vbuf, x1, y1, z2,	0, 0, -1,	0, 0,	c2, 1);
	vertex_add_point(vbuf, x1, y2, z2,	0, 0, -1,	0, 0,	c2, 1);
	vertex_add_point(vbuf, x1, y2, z1,	0, 0, -1,	0, 0,	c2, 1);
	vertex_add_point(vbuf, x1, y2, z1,	0, 0, -1,	0, 0,	c2, 1);
	vertex_add_point(vbuf, x1, y1, z1,	0, 0, -1,	0, 0,	c2, 1);
	vertex_add_point(vbuf, x1, y1, z2,	0, 0, -1,	0, 0,	c2, 1);
															
	// BACK													
	vertex_add_point(vbuf, x2, y1, z2,	-1, 0, 0,	0, 0,	c1, 1);
	vertex_add_point(vbuf, x2, y2, z2,	-1, 0, 0,	0, 0,	c1, 1);
	vertex_add_point(vbuf, x1, y2, z2,	-1, 0, 0,	0, 0,	c1, 1);
	vertex_add_point(vbuf, x1, y2, z2,	-1, 0, 0,	0, 0,	c1, 1);
	vertex_add_point(vbuf, x1, y1, z2,	-1, 0, 0,	0, 0,	c1, 1);
	vertex_add_point(vbuf, x2, y1, z2,	-1, 0, 0,	0, 0,	c1, 1);
															
	// RIGHT												
	vertex_add_point(vbuf, x2, y1, z1,	0, 0, 1,	0, 0,	c2, 1);
	vertex_add_point(vbuf, x2, y2, z1,	0, 0, 1,	0, 0,	c2, 1);
	vertex_add_point(vbuf, x2, y2, z2,	0, 0, 1,	0, 0,	c2, 1);
	vertex_add_point(vbuf, x2, y2, z2,	0, 0, 1,	0, 0,	c2, 1);
	vertex_add_point(vbuf, x2, y1, z2,	0, 0, 1,	0, 0,	c2, 1);
	vertex_add_point(vbuf, x2, y1, z1,	0, 0, 1,	0, 0,	c2, 1);
										
	// TOP								
	vertex_add_point(vbuf, x1, y2, z1,	0, 1, 0,	0, 0,	c3, 1);
	vertex_add_point(vbuf, x1, y2, z2,	0, 1, 0,	0, 0,	c3, 1);
	vertex_add_point(vbuf, x2, y2, z2,	0, 1, 0,	0, 0,	c3, 1);
	vertex_add_point(vbuf, x2, y2, z2,	0, 1, 0,	0, 0,	c3, 1);
	vertex_add_point(vbuf, x2, y2, z1,	0, 1, 0,	0, 0,	c3, 1);
	vertex_add_point(vbuf, x1, y2, z1,	0, 1, 0,	0, 0,	c3, 1);
	
	// BOTTOM
	vertex_add_point(vbuf, x1, y1, z2,	0, -1, 0,	0, 0,	c3, 1);
	vertex_add_point(vbuf, x1, y1, z1,	0, -1, 0,	0, 0,	c3, 1);
	vertex_add_point(vbuf, x2, y1, z1,	0, -1, 0,	0, 0,	c3, 1);
	vertex_add_point(vbuf, x2, y1, z1,	0, -1, 0,	0, 0,	c3, 1);
	vertex_add_point(vbuf, x2, y1, z2,	0, -1, 0,	0, 0,	c3, 1);
	vertex_add_point(vbuf, x1, y1, z2,	0, -1, 0,	0, 0,	c3, 1);
}

#endregion