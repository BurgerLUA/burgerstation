/obj/item/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude)

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