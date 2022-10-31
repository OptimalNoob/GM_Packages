/// @description		| resets drawing properties
function draw_reset() {
	draw_set_alpha(1.0);
	draw_set_color(c_white);
	draw_set_align(fa_left, fa_top)
}

/// @arg {Constant.HAlign} ha	| Horizontal alignment
/// @arg {Constant.VAlign} va	| Vertical alignment
///
/// @description					| abstracted draw_set_[h/v]align functions.
function draw_set_align(ha, va) {
	draw_set_halign(ha);
	draw_set_valign(va);
}

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

/// @param {real} x	| X pos of crosshair
/// @param {real} y	| Y pos of crosshair
///
/// @description	| Draws a pair of horizontal and vertical lines,
///					| spanning the room and intersecting a given point.
function draw_crosshair(xx, yy) {
    draw_line(0, yy, room_width, yy);
    draw_line(xx, 0, xx, room_height);
}

/// @param {Id.Sprite} sprite | Sprite to be drawn
/// @param {Real} sub_image | Sub Image of the Sprite to be drawn
/// @param {Real} origin_x | New X origin of the Sprite
/// @param {Real} origin_y | New Y origin of the Sprite
/// @param {Real} x | X position to draw the Sprite
/// @param {Real} y | Y position to draw the Sprite
/// @param {Real} [xscale] | X scale of the Sprite [default: 1]
/// @param {Real} [yscale] | Y scale of the Sprite [default: 1]
/// @param {Real} [rotation] | Rotation of the Sprite [default: 0]
/// @param {Constant.Color} [color]	| Color to draw the sprite with [default: white]
/// @param {Real} [alpha] | Alpha of the drawn sprite [default: 1]
/// @description | Draw a sprite with a modified origin.
function draw_sprite_origin_ext(spr, sub, ox, oy, xx, yy, xs=1, ys=1, rot=0, col=c_white, alpha=1){
	ox -= sprite_get_xoffset(spr);
	oy -= sprite_get_yoffset(spr);
	draw_sprite_ext(spr, sub,
	    xx - xs * lengthdir_x(ox, rot) - ys * lengthdir_x(oy, rot - 90),
	    yy - xs * lengthdir_y(ox, rot) - ys * lengthdir_y(oy, rot - 90),
	    xs, ys, rot, col, alpha);
}