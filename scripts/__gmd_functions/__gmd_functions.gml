///@func draw_text_f(string)
///@arg {String} string	| String of text to be drawn.
///
///@description			| Draws text with inline formatting codes
///						| and inline command calls.
function draw_text_f(_string) {
	 
}

///@func read_dialog_from_file(npc)
///@arg {String} npc		| NPC name in the filename.
///
///@desc					| Imports dialog from text file
///							| based on the current Room Name.
///@return {Array<String>}
function read_dialog_from_file(npc) {
	/// Example Dialog Section:
	///
	/// {2:1} All this text is considered a comment.
	/// {3=4} All this text is considered a comment.
	/// 1> Line Text
	/// 2> Line Text
	
	
	// Open File
	var filename = "dialog_" + npc + "_" + room_get_name(room) + ".txt";
	var dialog_file = file_text_open_read(filename);
	
	// Create return arrays for dialog text and flag markers
	var lines_out = array_create(0), flag_markers = array_create(0);
	var i = 0, f = 0;
	
	while(not file_text_eof(dialog_file)) {
		var get_line = file_text_read_string(dialog_file)
		if(string_char_at(get_line, 1) != "{"){ // If line isn't a Flag Marker.
			var len = string_length(get_line);
			var r = 0, endof_lnumber = 0;
			repeat(len) { // Dynamically remove line numbers in text file.
				if(string_char_at(get_line, r) == ">") endof_lnumber = r;
				r++;
			}
			lines_out[i++] = string_delete(get_line, 1, endof_lnumber + 1); // ToDo, dynamically remove line numbers.
			file_text_readln(dialog_file);
		} else { // Line is a Flag Marker.
			var len = string_length(get_line);
			var r = 0, endof_marker = 0;
			repeat(len) { // Delete all text on line after flag marker.
				if(string_char_at(get_line, r) == "}") endof_marker = r;
				r++;
			}
			flag_markers[f++] = string_delete(string_delete(get_line, endof_marker, len), 1, 1);
			file_text_readln(dialog_file);
		}		
	}
	
	// Close out file and return an array of dialog and flag markers for later use.
	file_text_close(dialog_file);
	return [lines_out, flag_markers];
}

