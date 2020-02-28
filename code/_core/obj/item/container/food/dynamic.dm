/obj/item/container/food/dynamic/bread
	name = "dough"
	icon = 'icons/obj/items/consumable/food/dynamic_bread.dmi'
	icon_state = "dough_ball"
	crafting_id = "dough"

	var/cooked_icon_state = "bread"
	var/raw_icon_state = "dough_ball"

	health = /health/obj/item/misc/

	scale_sprite = FALSE

/obj/item/container/food/dynamic/bread/click_self(var/mob/caller,location,control,params)

	if(icon_state == "dough_flat" || icon_state == "dough_slice")
		raw_icon_state = "dough_ball"
		cooked_icon_state = "bread"
		caller.to_chat("You reshape \the [src.name].")

	update_icon()

	return TRUE

/obj/item/container/food/dynamic/bread/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/list/damage_table,var/damage_amount)

	if( (damage_table[BLADE] && !damage_table[BLUNT]) || damage_table[BLADE] > damage_table[BLUNT]) //Cut

		var/original_volume = reagents.volume_current

		var/pieces = FLOOR(original_volume/10, 1)

		if(has_prefix(icon_state,"dough"))
			if(pieces <= 1 || original_volume < pieces)
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat("There isn't enough dough to cut!")
				return FALSE

			for(var/i=1,i<=pieces,i++)
				var/obj/item/container/food/dynamic/bread/B = new(get_turf(src))
				if(raw_icon_state == "dough_flat")
					B.raw_icon_state = "dough_slice"
				B.update_icon()
				reagents.transfer_reagents_to(B.reagents,original_volume/pieces)
				animate(B,pixel_x = rand(-16,16),pixel_y=rand(-16,16),time=SECONDS_TO_DECISECONDS(1))

			if(is_living(attacker))
				var/mob/living/L = attacker
				L.to_chat("You cut \the [src.name] into [pieces] pieces.")

			qdel(src)
		else if(icon_state == "bun_whole")
			var/obj/item/container/food/sandwich/burger/B = new(get_turf(src))
			reagents.transfer_reagents_to(B.reagents,reagents.volume_current/2)
			cooked_icon_state = "bun_top"
			if(is_living(attacker))
				var/mob/living/L = attacker
				L.to_chat("You cut \the [src.name] into two halves.")
			update_icon()
			B.update_icon()

	else if( (!damage_table[BLADE] && damage_table[BLUNT]) || damage_table[BLADE] < damage_table[BLUNT]) //Flatten

		if(has_prefix(icon_state,"dough") && raw_icon_state != "dough_flat")
			raw_icon_state = "dough_flat"
			cooked_icon_state = "bread_flat"
			if(is_living(attacker))
				var/mob/living/L = attacker
				L.to_chat("You flatten \the [src.name].")
			update_icon()

	return TRUE

/obj/item/container/food/dynamic/bread/can_be_attacked(var/atom/attacker)
	return TRUE

/obj/item/container/food/dynamic/bread/update_icon()

	if(!reagents || !reagents.stored_reagents || !length(reagents.stored_reagents))
		return ..()

	color = reagents.color

	var/total_dough = 0
	var/total_bread = 0

	var/best_dough_reagent_id
	var/best_dough_reagent_amount

	var/best_bread_reagent_id
	var/best_bread_reagent_amount

	var/wetness = 0
	var/wetness_prefix = "perfect"

	var/cooked_percent = 0

	for(var/reagent_id in reagents.stored_reagents)
		var/amount = reagents.stored_reagents[reagent_id]

		wetness += all_reagents[reagent_id].liquid*(amount/reagents.volume_current)

		if(has_prefix(reagent_id,"dough_"))

			total_dough += amount

			if(best_dough_reagent_id && best_dough_reagent_amount >= amount)
				continue

			best_dough_reagent_id = reagent_id
			best_dough_reagent_amount = amount

		if(has_prefix(reagent_id,"bread_"))

			total_bread += amount

			if(best_bread_reagent_id && best_bread_reagent_amount >= amount)
				continue

			best_bread_reagent_id = reagent_id
			best_bread_reagent_amount = amount

	if(total_dough + total_bread)
		cooked_percent = total_bread / (total_dough + total_bread)

	if(cooked_percent > 0.5) //It's bread

		switch(wetness)
			if(-INFINITY to -20)
				wetness_prefix = "dry"
			if(20 to INFINITY)
				wetness_prefix = "moist"

		if(best_bread_reagent_id)
			name = "[wetness_prefix] [all_reagents[best_bread_reagent_id].name]"
		else
			name = "[wetness_prefix] mystery bread"

	else //It's dough

		switch(wetness)
			if(-INFINITY to -10)
				wetness_prefix = "dry"
			if(10 to INFINITY)
				wetness_prefix = "wet"

		if(best_dough_reagent_id)
			name = "[wetness_prefix] [all_reagents[best_dough_reagent_id].name]"
		else
			name = "[wetness_prefix] mystery dough"

	if(reagents.volume_current <= 10 && cooked_icon_state == "bread")
		cooked_icon_state = "bun_whole"
		raw_icon_state = "dough_ball_small"

	icon_state = cooked_percent > 0.5 ? cooked_icon_state : raw_icon_state
	color = reagents.color

	return ..()