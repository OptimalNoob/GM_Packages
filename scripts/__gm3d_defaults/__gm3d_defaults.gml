/// --- ENVIRONMENT VARIABLES --- ///
// NOTE: MAKE SURE THERE ARE NO TRAILING EMPTY SPACES IN THE FOLDER NAMES
#macro USRFOLD environment_get_variable("USERPROFILE")									// Windows Enviornment Variable for User Folder
#macro PROJDIR string(USRFOLD) + "/Documents/GameMakerStudio2/Framework3d/datafiles/"	// Windows Path to Project Directory
#macro PATHOBJ "objfiles" + "/"															// Folder name for OBJ Files inside DataFiles
#macro PATHMTL "objfiles" + "/"															// Folder name for MTL Files inside DataFiles
#macro PATHBIN "objbins" + "/"															// Folder name for Exported Buffer Files inside DataFiles

/// --- DEBUG MACROS --- ///
#macro DEBUGMODELIMPORT false