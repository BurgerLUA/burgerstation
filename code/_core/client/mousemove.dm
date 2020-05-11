/client/MouseMove(var/atom/object,location,control,params)

	if(examine_mode)
		var/list/aug = params2list(params)
		examine_overlay.maptext = object.name
		examine_overlay.screen_loc = aug["screen-loc"]

	return ..()