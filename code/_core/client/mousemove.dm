/client/MouseMove(var/atom/object,location,control,params)

	if(mob && examine_mode)
		var/list/aug = params2list(params)
		mob.examine_overlay.maptext = object.name
		mob.examine_overlay.screen_loc = aug["screen-loc"]

	return ..()