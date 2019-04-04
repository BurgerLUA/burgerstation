

//-- Map Placeholders ----------------------------------------------------------

dmm_suite
	var
		version = DMM_SUITE_VERSION

	//-- Used to store meta data in dmm files --------
	comment
		parent_type = /obj
		icon = 'icons/debug/dmm_suite.dmi'
		icon_state = "comment"
		layer = FLY_LAYER+1
		var
			version
			coordinates
			dimensions
		New()
			. = ..()
			// Must assign at runtime so innitial() != runtime when saving
			version = DMM_SUITE_VERSION
			icon = null
			spawn(1)
				del src

	//-- Used in generating turf underlay stacks -----
	underlay
		parent_type = /turf
		New()
			del src
	//-- Fills maps when writing with IGNORE_TURFS ---
	clear_turf
		parent_type = /turf
		icon = 'icons/debug/dmm_suite.dmi'
		icon_state = "clear_turf"
		layer = FLY_LAYER
		//New()
			//del src
	//-- Fills maps when writing with IGNORE_AREAS ---
	clear_area
		parent_type = /area
		icon = 'icons/debug/dmm_suite.dmi'
		icon_state = "clear_area"
		layer = FLY_LAYER
		//New()
			//del src
