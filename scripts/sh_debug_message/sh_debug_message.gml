// You can pass arguments in the function too.
// Calling this command would look like:
//		debug_message "Hello World!"

// Any returns in the function will be output in the in-game Console
// So the below function will first show a debug message in the IDE Output
// It will also output "Message has been shown" to the in-game console
function sh_debug_message(args){
	show_debug_message(string(args[1]));
	return "Message has been shown"
}

// Check the "meta_debug_message" for info on creating hints,
// suggestions and autocomplete for commands