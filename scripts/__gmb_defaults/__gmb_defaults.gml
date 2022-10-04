///		MACROS
#macro ITEMTABLE_SPRITECOL 2;

///		ENUMS
enum ITEMTABLE {
	NAME,		// 0	Name		\	Defaults, can be changed but correlate to the columns in the item_table Class,
	DESC,		// 1	Description	 | 	Can be changed, but ensure the previous enum refernces are updated.
	SPR			// 2	Sprite		/   
}

/// ENUMS
enum BPCOL {
	NAME,		// 0	\	Default Column Names for accessing Backpack Grid Contents
	AMOUNT		// 1	/	Can be changed but ensure the previous enum references are updated.
}