/atom/proc/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)

	if(health)
		var/area/A = get_area(src)
		if(!(A.flags_area & FLAGS_AREA_NO_DAMAGE))
			var/list/params = list()
			params[PARAM_ICON_X] = rand(0,32)
			params[PARAM_ICON_Y] = rand(0,32)
			var/atom/object_to_damage = src.get_object_to_damage(owner,source,params,FALSE,TRUE)
			var/damagetype/D = all_damage_types[/damagetype/explosion/]
			D.hit(source,src,source,object_to_damage,owner,magnitude)

	return TRUE