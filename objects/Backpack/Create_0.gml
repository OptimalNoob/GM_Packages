name = "cornovich"
//dialog = new dialogTree();
var t = get_timer();
dialog = new dialogTree("cornovich");
show_debug_message("Loading Dialog: '" + string(name) + "' took " + string((get_timer() - t) / 1000) + " milliseconds");

sdm("Dialog: " + string(dialog.getDialog()));
sdm("Flags: " + string(dialog.getFlags()));

game_end();