function input_handler() constructor { 
	static key = {
		up :	function () { return keyboard_check(KeyboardInputs[KI.UP]) },
		down :	function () { return keyboard_check(KeyboardInputs[KI.DOWN]) },
		left :	function () { return keyboard_check(KeyboardInputs[KI.LEFT]) },
		right :	function () { return keyboard_check(KeyboardInputs[KI.RIGHT]) }
	}
	
	static keyPress = {
		up :	function () { return keyboard_check_pressed(KeyboardInputs[KI.UP]) },
		down :	function () { return keyboard_check_pressed(KeyboardInputs[KI.DOWN]) },
		left :	function () { return keyboard_check_pressed(KeyboardInputs[KI.LEFT]) },
		right :	function () { return keyboard_check_pressed(KeyboardInputs[KI.RIGHT]) }
	}
	
	static keyRelease = {
		up :	function () { return keyboard_check_released(KeyboardInputs[KI.UP]) },
		down :	function () { return keyboard_check_released(KeyboardInputs[KI.DOWN]) },
		left :	function () { return keyboard_check_released(KeyboardInputs[KI.LEFT]) },
		right :	function () { return keyboard_check_released(KeyboardInputs[KI.RIGHT]) }
	}
}

//globalvar PlayerInput;
//PlayerInput = new input_handler();

//if(PlayerInput.keyHold.up()) {
//	// This will actually detect if the W key is pressed
//}