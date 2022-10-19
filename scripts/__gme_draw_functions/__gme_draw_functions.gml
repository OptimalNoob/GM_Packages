/// @function draw_reset()
///
/// @description		| resets drawing properties
function draw_reset() {
	draw_set_alpha(1.0);
	draw_set_color(c_white);
	draw_set_align(fa_left, fa_top)
}


/// @function					draw_set_align(ha, va)
/// @arg {Constant.HAlign} ha	| Horizontal alignment
/// @arg {Constant.VAlign} va	| Vertical alignment
///
/// @description					| abstracted draw_set_[h/v]align functions.
function draw_set_align(ha, va) {
	draw_set_halign(ha);
	draw_set_valign(va);
}

/// @function			draw_set_text(ha, va, fnt, col, alp)
/// @arg {Constant.font}		fnt	| Font to draw text.
/// @arg {Constant.HAlign}	ha	| Horizontal Alignment of text.
/// @arg {Constant.VAlign}	va	| Vertical Alignment of text.
/// @arg {Constant.Color}	col	| Color of text. [default: c_white]
/// @arg {real}				alp	| Alpha of text. [default: 1.0]
///
/// @description			| Abstracted draw properties function.
function draw_set_text(fnt, ha = fa_left, va = fa_top, col = c_white, alp = 1.0){
	draw_set_alpha(alp);
	draw_set_halign(ha);
	draw_set_valign(va);
	draw_set_color(col);
	draw_set_font(fnt);
}

/// @function			draw_text_label(xx, yy, txt, fnt)
/// @arg {real} xx		| X pos of text
/// @arg {real} yy		| Y pos of text
/// @arg {string} txt	| Y pos of text
/// @arg {Constant.Font} fnt		| Font used to draw
///
/// @description		| Draw label/name above 3D object
function draw_text_label(xx, yy, txt, fnt){
	draw_set_text(fnt, fa_center, fa_center, c_white, 1.0);
	draw_text_transformed(xx, yy, txt, 0.05, 0.05, 0);
	draw_set_align(fa_left, fa_top);	// reset alignment
}

/// @function draw_crosshair(xx,yy)
/// @arg {real} x	| X pos of crosshair
/// @arg {real} y	| Y pos of crosshair
///
/// @description		| Draws a pair of horizontal and vertical lines,
///					| spanning the room and intersecting a given point.
function draw_crosshair(xx, yy) {
    draw_line(0, yy, room_width, yy);
    draw_line(xx, 0, xx, room_height);
}