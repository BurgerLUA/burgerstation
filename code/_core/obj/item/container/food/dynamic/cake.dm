/obj/item/container/food/dynamic/cake
	name = "pastry dough"
	icon = 'icons/obj/item/consumable/food/cake.dmi'
	icon_state = "dough_ball"
	crafting_id = "pastry_dough"

	cooked_icon_state = "cake"
	raw_icon_state = "dough_ball"

	health = /health/obj/item/misc/

	scale_sprite = FALSE

	reagents = /reagent_container/food/bread

	allow_reagent_transfer_to = TRUE

	var/last_cooked = FALSE

/obj/item/container/food/dynamic/cake/click_self(var/mob/caller,location,control,params)

	if(icon_state == raw_icon_state && (icon_state == "dough_flat" || icon_state == "dough_slice"))
		raw_icon_state = "dough_ball"
		cooked_icon_state = "cake"
		caller.to_chat("You reshape \the [src.name].")

	update_sprite()

	return TRUE

/obj/item/container/food/dynamic/cake/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(icon_state == raw_icon_state && istype(object,/obj/item/container/food/dynamic/cake)) //IT'S RAW.
		var/obj/item/container/food/dynamic/bread/B = object
		if(B.icon_state == B.raw_icon_state) //IT'S FUCKING RAW.
			var/amount_to_transfer = min(reagents.volume_current,B.reagents.volume_max - B.reagents.volume_current)
			if(amount_to_transfer <= 0)
				if(is_living(caller))
					var/mob/living/L = caller
					L.to_chat("You can't add any more dough!")
				return TRUE
			if(is_living(caller))
				var/mob/living/L = caller
				L.to_chat("You add \the [name] to \the [B.name].")
			reagents.transfer_reagents_to(B.reagents,amount_to_transfer)
			return TRUE

	return ..()


/obj/item/container/food/dynamic/cake/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	var/original_volume = reagents.volume_current

	if( (damage_table[BLADE] && !damage_table[BLUNT]) || damage_table[BLADE] > damage_table[BLUNT]) //Cut
		if(icon_state == raw_icon_state) //It's RAW!!!

			if(raw_icon_state == "dough_flat")
				var/pieces = FLOOR(original_volume/10, 1)
				if(pieces <= 1 || original_volume < pieces)
					if(is_living(attacker))
						var/mob/living/L = attacker
						L.to_chat("There isn't enough dough to cut!")
					return FALSE
				raw_icon_state = "dough_slice"
				for(var/i=1,i<=pieces-1,i++)
					var/obj/item/container/food/dynamic/bread/B = new(get_turf(src))
					B.pixel_x = pixel_x
					B.pixel_y = pixel_y
					B.raw_icon_state = raw_icon_state
					B.cooked_icon_state = cooked_icon_state
					INITIALIZE(B)
					reagents.transfer_reagents_to(B.reagents,original_volume/pieces)
					FINALIZE(B)
					animate(B, pixel_x = pixel_x + rand(-4,4), pixel_y= pixel_y + rand(-4,4), time=5)
				animate(src, pixel_x = pixel_x + rand(-4,4), pixel_y= pixel_y + rand(-4,4), time=5)
				update_sprite()
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat("You cut \the [src.name] into [pieces] pieces.")

			else if(raw_icon_state == "dough_ball")
				if(original_volume > 10)
					var/obj/item/container/food/dynamic/bread/B = new(get_turf(src))
					B.pixel_x = pixel_x
					B.pixel_y = pixel_y
					INITIALIZE(B)
					reagents.transfer_reagents_to(B.reagents,10)
					FINALIZE(B)
					animate(B, pixel_x = pixel_x + rand(-4,4), pixel_y= pixel_y + rand(-4,4), time=5)
				update_sprite()
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat("You cut some small dough from the dough pile.")

		//else if(icon_state == "cake") //It's cooked, and a cake.
			//Make cake slices.

	else if( (!damage_table[BLADE] && damage_table[BLUNT]) || damage_table[BLADE] < damage_table[BLUNT]) //Flatten
		if(has_prefix(icon_state,"dough") && raw_icon_state != "dough_flat")
			raw_icon_state = "dough_flat"
			cooked_icon_state = "pie"
			if(is_living(attacker))
				var/mob/living/L = attacker
				L.to_chat("You flatten \the [src.name].")
			update_sprite()

	return TRUE

/obj/item/container/food/dynamic/cake/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return TRUE

/obj/item/container/food/dynamic/cake/update_sprite()
	if(reagents)
		color = reagents.color
	return ..()


/obj/item/container/food/dynamic/cake/update_overlays()

	. = ..()

	if(last_cooked)
		var/icing = FALSE
		var/icing_color = null
		var/icing_amount = 0
		for(var/reagent_type in reagents.stored_reagents)
			var/amount = reagents.stored_reagents[reagent_type]
			var/reagent/R = REAGENT(reagent_type)
			if(istype(R,/reagent/nutrition/icing))
				icing = TRUE
				icing_color = icing_amount ? blend_colors(icing_color,R.color,amount/icing_amount) : R.color
				icing_amount += amount
		if(icing)
			var/image/I = new/image(initial(icon),"[cooked_icon_state]_icing")
			I.appearance_flags = RESET_COLOR
			I.color = icing_color
			I.alpha = clamp((icing_amount/10)*225,100,255)
			add_overlay(I)

	return .


/obj/item/container/food/dynamic/cake/update_icon()

	if(last_cooked)
		return FALSE

	if(!reagents)
		return ..()

	var/total_dough = 0
	var/total_bread = 0

	var/best_dough_reagent_type
	var/best_dough_reagent_amount

	var/best_bread_reagent_type
	var/best_bread_reagent_amount

	var/wetness = 0
	var/wetness_prefix = "perfect"

	var/cooked_percent = 0

	for(var/reagent_type in reagents.stored_reagents)
		var/amount = reagents.stored_reagents[reagent_type]
		var/reagent/R = REAGENT(reagent_type)
		wetness += R.liquid*(amount/reagents.volume_current)
		if(R.flags_reagent & FLAG_REAGENT_RAW)
			total_dough += amount
			if(best_dough_reagent_type && best_dough_reagent_amount >= amount)
				continue
			best_dough_reagent_type = reagent_type
			best_dough_reagent_amount = amount
		if(R.flags_reagent & FLAG_REAGENT_COOKED)
			total_bread += amount
			if(best_bread_reagent_type && best_bread_reagent_amount >= amount)
				continue
			best_bread_reagent_type = reagent_type
			best_bread_reagent_amount = amount

	if(total_dough + total_bread)
		cooked_percent = total_bread / (total_dough + total_bread)

	if(cooked_percent > 0.5) //It's cake

		switch(wetness)
			if(-INFINITY to -20)
				wetness_prefix = "dry"
			if(20 to INFINITY)
				wetness_prefix = "moist"

		if(best_bread_reagent_type)
			var/reagent/R = REAGENT(best_bread_reagent_type)
			name = "[wetness_prefix] [R.name]"
		else
			name = "[wetness_prefix] mystery cake"

	else //It's dough

		switch(wetness)
			if(-INFINITY to -10)
				wetness_prefix = "dry"
			if(10 to INFINITY)
				wetness_prefix = "wet"

		if(best_dough_reagent_type)
			var/reagent/R = REAGENT(best_dough_reagent_type)
			name = "[wetness_prefix] [R.name]"
		else
			name = "[wetness_prefix] mystery pastry"

	if(reagents.volume_current <= 20 && cooked_icon_state == "cake")
		cooked_icon_state = "cup_cake"
		raw_icon_state = "dough_ball_small"

	else if(reagents.volume_current > 20 && cooked_icon_state == "cup_cake")
		cooked_icon_state = "cake"
		raw_icon_state = "dough_ball"

	icon_state = cooked_percent > 0.5 ? cooked_icon_state : raw_icon_state

	if(cooked_percent > 0.5)
		last_cooked = TRUE

	return TRUE