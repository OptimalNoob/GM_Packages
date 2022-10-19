// Each command needs a "meta_<commandname>" script alongside it.
// in the function "meta_..." below, you need to return a struct of properties.
//

/// Property Name	| Property Description

// description	| Command description in the console.

// arguments	| Needs to be an array, stores the datatype expected of the argument
//		(this isn't a strict datatype, it's only to help the console user know what to put)
//		(if a command needs a certain data type and you provide something else, it'll output
//			an error to the IDE Output, but won't break the game)

// suggestions	| While typing the command in the console, argument suggestions will appear that you
//		can simply hit "Tab" to autocomplete. Put the typical argument values you'd use here if you want.

// argumentDescription	| Descriptions of each argument in "arguments" property.
//		(Also needs to be an array like "arguments:" and the array size must be the same
//			each argument needs a description, or you can leave the entire property blank)

// hidden	| Defaults to FALSE if not provided. boolean value that determines if the command shows up in the "help" command built
//		into the console. (this is optional and you don't need to provide it in the struct)

// deferred	| Defaults to FALSE if not provided. Determines if the comamnd will be executes as
//		soon as you hit enter (False) OR if it will "queue" up the command to be executed when the
//		console is closed. So if you call multiple deferred commands being called, they will wait
//		until the console is closed then they will execute all at once in order from when they
//		were called. (this is optional and you don't need to provide it in the struct)
function meta_debug_message(){
	return {
		description: "Shows a debug message",
		arguments: ["<string>"], // <string>, <bool>, <real>, <array>, etc.
		suggestions: [["poop", "or not to poop"]], // needs to be a nested array, inner array holds list of suggestions as strings.
		argumentDescriptions: ["message to show"],
		hidden: false, // Because it's false, it will show up if you use the "help" command
		deferred: false // Because it's false, it will run immediately when you call it, rather than wait for the console to be closed.
	}
}