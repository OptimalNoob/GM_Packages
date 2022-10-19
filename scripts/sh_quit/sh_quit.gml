// The shell object locates all scripts that start with "sh_"
// The command name to type will be any text after "sh_"
// Adds a command to the 
function sh_quit(){
	game_end();
}

// Check the "meta_quit" for info on creating hints,
// suggestions and autocomplete for commands

// NOTE: I recommend setting your "Game is Paused" variable or 
// some other kind of variable to true, and stop the control of your
// player's movement while the console is open
// Then when the console is deleted, set that "paused" variable you make
// to false so the player can move again.