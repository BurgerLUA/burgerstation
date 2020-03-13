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

	if(!is_advanced(src) && health)
		health.adjust_loss_smart(brute=magnitude*10,burn=magnitude*5)

	return ..()


/mob/living/advanced/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude)

	if(health)
		world.log << "The magnitude is: [magnitude]."
		for(var/obj/item/organ/O in organs)
			if(istype(O,/obj/item/organ/internal) || !O.health)
				continue
			O.health.adjust_loss_smart(brute=rand(1,6)*magnitude,burn=rand(1,3)*magnitude)

	. = ..()


	return .



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