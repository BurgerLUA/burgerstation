/atom/proc/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)

	if(health)
		var/area/A = get_area(src)
		if(!(A.flags_area & (FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION)))
			var/list/params = list()
			params[PARAM_ICON_X] = rand(0,32)
			params[PARAM_ICON_Y] = rand(0,32)
			var/atom/object_to_damage = src.get_object_to_damage(owner,source,params,FALSE,TRUE)
			var/damagetype/D = all_damage_types[/damagetype/explosion/]
			D.process_damage(source,src,source,object_to_damage,owner,magnitude)

	return TRUE


/atom/proc/act_emp(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)
	if(health) health.act_emp(owner,source,epicenter,magnitude,desired_loyalty)
	return TRUE