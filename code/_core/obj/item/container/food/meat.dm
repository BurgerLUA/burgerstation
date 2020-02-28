/obj/item/container/food/dynamic/meat
	name = "meat"
	desc = "IT'S RAW!"

	icon = 'icons/obj/items/consumable/food/meat.dmi'
	icon_state = "meat_1"

	health = /health/obj/item/misc/

	var/last_cooked = FALSE //Read only.

	scale_sprite = FALSE

/obj/item/container/food/dynamic/meat/can_be_attacked(var/atom/attacker)
	return TRUE

/obj/item/container/food/dynamic/meat/click_self(var/mob/caller,location,control,params)

	if(icon_state == "ground")
		icon_state = "meatball"
		caller.to_chat("You reshape \the [src.name] into a meatball.")
		update_icon()
	else if(icon_state == "meatball")
		icon_state = "patty"
		caller.to_chat("You reshape \the [src.name] into a patty.")
		pixel_height = 2
		update_icon()

	update_icon()

	return TRUE

/obj/item/container/food/dynamic/meat/update_icon()

	if(has_prefix(icon_state,"meat_"))
		if(reagents.volume_current <= 5)
			icon_state = "bacon"
		else if(reagents.volume_current <= 10)
			icon_state = "cutlet"

	var/total_raw = 0
	var/total_cooked = 0
	var/total_fat = 0

	var/best_meat
	var/best_meat_volume

	var/best_fat
	var/best_fat_volume

	for(var/reagent_id in reagents.stored_reagents)
		var/amount = reagents.stored_reagents[reagent_id]
		if(has_prefix(reagent_id,"cooked_meat_"))
			total_cooked += amount
			if(!best_meat || amount > best_meat_volume)
				best_meat = reagent_id
				best_meat_volume = amount
		else if(has_prefix(reagent_id,"raw_meat_"))
			total_raw += amount
			if(!best_meat || amount > best_meat_volume)
				best_meat = reagent_id
				best_meat_volume = amount
		else if(has_prefix(reagent_id,"fat_"))
			total_fat += amount
			if(!best_fat || amount > best_fat_volume)
				best_fat = reagent_id
				best_fat_volume = amount

	if(!best_meat)
		return ..()

	icon = initial(icon)

	var/icon/I = new/icon(icon,icon_state)
	I.Blend(all_reagents[best_meat].color,ICON_MULTIPLY)

	if(best_fat)
		var/icon/I2 = new/icon(icon,"[icon_state]_fat")
		I2.Blend(all_reagents[best_fat].color,ICON_MULTIPLY)
		I.Blend(I2,ICON_OVERLAY)

	if(has_prefix(best_meat,"cooked_meat_"))
		last_cooked = TRUE
		if(reagents.volume_current > 10 || icon_state == "patty")
			var/icon/I3 = new/icon(icon,"grill_marks")
			var/icon/I4 = new/icon(I)
			I4.Blend(rgb(0,0,0,200),ICON_MULTIPLY)
			I3.Blend(I4,ICON_ADD)
			I.Blend(I3,ICON_OVERLAY)

	icon = I

	return ..()


/obj/item/container/food/dynamic/meat/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/list/damage_table,var/damage_amount)

	if(last_cooked)
		return TRUE

	if( (damage_table[BLADE] && !damage_table[BLUNT]) || damage_table[BLADE] > damage_table[BLUNT]) //Cut

		var/original_volume = reagents.volume_current

		if(has_prefix(icon_state,"meat_"))
			//Make cutlets.
			var/pieces = FLOOR(original_volume/10, 1)
			if(pieces <= 1 || original_volume < pieces)
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat("There isn't enough meat to cut!")
				return FALSE

			for(var/i=1,i<=pieces,i++)
				var/obj/item/container/food/dynamic/meat/M = new(get_turf(src))
				reagents.transfer_reagents_to(M.reagents,original_volume/pieces)
				animate(M,pixel_x = rand(-16,16),pixel_y=rand(-16,16),time=SECONDS_TO_DECISECONDS(1))

			if(is_living(attacker))
				var/mob/living/L = attacker
				L.to_chat("You cut \the [src.name] into [pieces] cutlets.")

			qdel(src)

		else if(has_prefix(icon_state,"cutlet"))
			//Make bacon.
			var/pieces = FLOOR(original_volume/5, 1)
			if(pieces <= 1 || original_volume < pieces)
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat("There isn't enough meat to cut!")
				return FALSE

			for(var/i=1,i<=pieces,i++)
				var/obj/item/container/food/dynamic/meat/M = new(get_turf(src))
				reagents.transfer_reagents_to(M.reagents,original_volume/pieces)
				animate(M,pixel_x = rand(-16,16),pixel_y=rand(-16,16),time=SECONDS_TO_DECISECONDS(1))

			if(is_living(attacker))
				var/mob/living/L = attacker
				L.to_chat("You cut \the [src.name] into [pieces] bacon slices.")

			qdel(src)


	else if( (!damage_table[BLADE] && damage_table[BLUNT]) || damage_table[BLADE] < damage_table[BLUNT]) //Flatten

		var/original_volume = reagents.volume_current

		if(has_prefix(icon_state,"meat"))
			//Make ground beef.
			var/pieces = FLOOR(original_volume/10, 1)
			if(pieces <= 1 || original_volume < pieces)
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat("There isn't enough meat to pound!")
				return FALSE

			for(var/i=1,i<=pieces,i++)
				var/obj/item/container/food/dynamic/meat/M = new(get_turf(src))
				M.icon_state = "ground"
				reagents.transfer_reagents_to(M.reagents,original_volume/pieces)
				animate(M,pixel_x = rand(-16,16),pixel_y=rand(-16,16),time=SECONDS_TO_DECISECONDS(1))

			if(is_living(attacker))
				var/mob/living/L = attacker
				L.to_chat("You pound \the [src.name] into [pieces] portion\s of ground beef.")

			qdel(src)

	return TRUE


/obj/item/container/food/dynamic/meat/raw/on_spawn()
	reagents.add_reagent("raw_meat_cow",15)
	reagents.add_reagent("fat_cow",5)
	return ..()

/obj/item/container/food/dynamic/meat/cooked/on_spawn()
	reagents.add_reagent("cooked_meat_cow",15)
	reagents.add_reagent("fat_cow",5)
	return ..()

/obj/item/container/food/dynamic/meat/cooked/cutlet/on_spawn()
	reagents.add_reagent("cooked_meat_cow",7)
	reagents.add_reagent("fat_cow",3)
	return ..()

/obj/item/container/food/dynamic/meat/cooked/bacon/on_spawn()
	reagents.add_reagent("cooked_meat_cow",3)
	reagents.add_reagent("fat_cow",2)
	return ..()