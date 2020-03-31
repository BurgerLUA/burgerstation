/mob/living/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude)

	if(magnitude > 1)

		var/x_mod = src.x - epicenter.x
		var/y_mod = src.y - epicenter.y

		var/max = max(abs(x_mod),abs(y_mod))

		if(!max)
			x_mod = pick(-1,1)
			y_mod = pick(-1,1)
		else
			x_mod *= 1/max
			y_mod *= 1/max

		throw_self(owner,null,null,null,x_mod*magnitude,y_mod*magnitude)

	for(var/i=1,i<=clamp(1+(magnitude*2),1,4),i++)
		var/list/params = list()
		params[PARAM_ICON_X] = rand(0,32)
		params[PARAM_ICON_Y] = rand(0,32)
		var/atom/object_to_damage = src.get_object_to_damage(owner,params,FALSE,TRUE)
		var/damagetype/D = all_damage_types["explosion"]
		D.do_damage(source,src,source,object_to_damage,owner,magnitude*0.5)

	return ..()


obj/item/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude)

	if(magnitude > 1)

		var/x_mod = src.x - epicenter.x
		var/y_mod = src.y - epicenter.y

		var/max = max(abs(x_mod),abs(y_mod))

		if(!max)
			x_mod = pick(-1,1)
			y_mod = pick(-1,1)
		else
			x_mod *= 1/max
			y_mod *= 1/max

		throw_self(owner,null,null,null,x_mod*magnitude*2,y_mod*magnitude*2)

	return ..()