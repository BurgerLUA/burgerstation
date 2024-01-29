/atom/proc/act_explode(atom/owner,atom/source,atom/epicenter,magnitude,desired_loyalty_tag)

	var/damagetype/D = SSdamagetype.all_damage_types[/damagetype/explosion]

	if(!health || !src.can_be_attacked(owner,source,null,D))
		return FALSE

	var/list/params = list()
	params[PARAM_ICON_X] = rand(0,32)
	params[PARAM_ICON_Y] = rand(0,32)
	var/atom/object_to_damage = src.get_object_to_damage(owner,source,D,params,FALSE,TRUE)
	D.process_damage(source,src,source,object_to_damage,owner,magnitude)

	return TRUE


/atom/proc/act_emp(atom/owner,atom/source,atom/epicenter,magnitude,desired_loyalty_tag)

	var/damagetype/D = SSdamagetype.all_damage_types[/damagetype/explosion]

	if(!health || !src.can_be_attacked(source,source,null,D))
		return FALSE

	return health.act_emp(owner,source,epicenter,magnitude,desired_loyalty_tag)\

