/// @function				string_left(str, num)
/// @arg {string} str	| string of text.
/// @arg {real} num		| number of characters.
///
/// @description			| Returns a number of characters from the
///						| start of a string. If the number of
///						| characters given is negative, the string
///						| will be shortened by that amount.
///
/// @return {string}
function string_left(str, num) {
	if (num < 0) return string_copy(str, 1, string_length(str) + num);
	else return string_copy(str, 1, num);
}

/// @function				string_right(str, num)
/// @arg {string} str	| string of text.
/// @arg {real} num		| number of characters.
///
/// @description			| Returns a number of characters from the
///						| end of a string. If the number of
///						| characters given is negative, the string
///						| will be shortened by that amount.
///
/// @return {string}
function string_right(str, num) {
	if (num < 0) return string_copy(str, 1 - num, string_length(str) + num);
	else return string_copy(str, 1 + string_length(str) - num, num);
}

/// @function				string_reverse(str)
/// @arg {string} str	| string to be reversed.
///
/// @description			| Returns a given string with the characters
///						| in reverse order.
///
/// @return {string}
function string_reverse(str) {
    var str_out = "";
    for(var i = string_length(str); i > 0; i--) str_out += string_char_at(str, i);
    return str_out;
}

/// @function				string_trim(str, trim)
/// @arg {string} str	| string of text
/// @arg {string} trim	| characters to trim, optional
///
/// @description			| Returns given string with whitespace stripped
///						| from its start and end. Whitespace is defined
///						| as SPACE, LF, CR, HT, VT, FF. A string of characters
///						| to be trimmed may be optionally supplied.
///
/// @return {string} 
function string_trim(str, trim=" \n\r\t\v\f") {
    var l = 1;
    while (string_pos(string_char_at(str, l), trim)) {
        l++;
    }
    var r = string_length(str);
    while (string_pos(string_char_at(str, r), trim)) {
        r--;
    }
    return string_copy(str, l, r - l + 1);
}

/// @function				string_proper(str)
/// @arg {string} str	| string of text
///
/// @description			| Returns a string with proper casing.
///
/// @return {string}
function string_proper(str) {
    var str_out = string_upper(string_char_at(str, 1));
    str_out += string_copy(str, 2, string_length(str) - 1);
    return str_out;
}