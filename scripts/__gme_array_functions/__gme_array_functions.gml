/// @function concatenate_arrays(array1, array2)
/// @arg {Array<Any>} array1	| First Array
/// @arg {Array<Any>} array2	| Second Array
///
/// @description	| Combines 2 1D Arrays into a single 2D Array
///
///			| Both Input Arrays MUST be the same length,
///			| Returns -1 if they are not.
/// @returns {Array<Array<Any>}
function concatenate_arrays(array1, array2) {
	var array_out = [];
	var arrl1 = array_length(array1)
	var arrl2 = array_length(array2)
	if(arrl1 != arrl2) return -1;
	r = 0;
	repeat (arrl1) {
		array_out[r][0] = array1[r];
		array_out[r][1] = array2[r];
		r++;
	}
	return array_out;
}