///@func					collision_line_first(x1,y1,x2,y2,object,prec,notme)
///@arg {real}		x1		| X pos of first point on collision line
///@arg {real}		y2		| Y pos of first point on collision line
///@arg {real}		x2		| X pos of second point on collision line
///@arg {real}		y2		| Y pos of second point on collision line
///@arg {id}	object	| which objects to look for (or all)
///@arg {bool}		prec	| if true, use precise collision checking
///@arg {bool}		notme	| if true, ignore the calling instance
///
///@description				| Returns the instance id of an object colliding with
///							| a given line and closest to the first point, or noone
///							| if no instance found. The solution is found in
///							| log2(range) collision checks.
///
///@return {id}
function collision_line_first(x1, y1, x2, y2, object, prec, notme) {
    var sx, sy, inst, i;
    sx = x2 - x1;
    sy = y2 - y1;
    inst = collision_line(x1, y1, x2, y2, object, prec, notme);
    if (inst != noone) {
        while ((abs(sx) >= 1) || (abs(sy) >= 1)) {
            sx /= 2;
            sy /= 2;
            i = collision_line(x1, y1, x2, y2, object, prec, notme);
            if (i) {
                x2 -= sx;
                y2 -= sy;
                inst = i;
            } else {
                x2 += sx;
                y2 += sy;
            }
        }
    }
    return inst;
}

///@func			collide_with_object(obj)
///@arg {id} obj	| Object to collide with
///
///@description		| Collide with Object, acts like a wall in return.
///
///					| NOTE: Uses hsp and vsp variables from calling instance.
function collide_with_object(obj){
	// Horizontal Collision
	if(place_meeting(x + hsp, y, obj)){
		while(!place_meeting(x + sign(hsp), y, obj)){
			x += sign(hsp);
		}
		hsp = 0;
	}
	
	// Horizontal Collision
	if(place_meeting(x, y + vsp, obj)){
		while(!place_meeting(x, y + sign(vsp), obj)){
			y += sign(vsp);
		}
		vsp = 0;
	}
} 