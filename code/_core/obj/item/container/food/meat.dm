/obj/item/container/food/dynamic/meat
	name = "meat"
	desc = "IT'S RAW!"
	desc_extended = "You need plenty of proteins for soldiering, soldier."

	icon = 'icons/obj/item/consumable/food/meat.dmi'
	icon_state = "meat_1"

	health = /health/obj/item/misc/

	var/last_cooked = FALSE //Read only.

	scale_sprite = FALSE

/obj/item/container/food/dynamic/meat/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return TRUE

/obj/item/container/food/dynamic/meat/click_self(var/mob/caller,location,control,params)

	if(icon_state == "ground")
		icon_state = "meatball"
		caller.to_chat("You reshape \the [src.name] into a meatball.")
		pixel_height = 1
		update_sprite()
	else if(icon_state == "meatball")
		icon_state = "patty"
		caller.to_chat("You reshape \the [src.name] into a patty.")
		pixel_height = 1
		update_sprite()
	else
		pixel_height = 1

	update_sprite()

	return TRUE

/obj/item/container/food/dynamic/meat/update_icon()

	if(last_cooked)
		return FALSE

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

	for(var/reagent_type in reagents.stored_reagents)
		var/amount = reagents.stored_reagents[reagent_type]
		var/reagent/R = REAGENT(reagent_type)
		if(R.flags_reagent & FLAG_REAGENT_COOKED)
			total_cooked += amount
			if(!best_meat || amount > best_meat_volume)
				best_meat = reagent_type
				best_meat_volume = amount
		else if(R.flags_reagent & FLAG_REAGENT_RAW)
			total_raw += amount
			if(!best_meat || amount > best_meat_volume)
				best_meat = reagent_type
				best_meat_volume = amount
		else if(R.flags_reagent & FLAG_REAGENT_FAT)
			total_fat += amount
			if(!best_fat || amount > best_fat_volume)
				best_fat = reagent_type
				best_fat_volume = amount

	if(!best_meat)
		return ..()

	icon = initial(icon)

	var/icon/I = new/icon(icon,icon_state)
	var/reagent/RM = REAGENT(best_meat)
	I.Blend(RM.color,ICON_MULTIPLY)

	if(best_fat)
		var/reagent/RF = REAGENT(best_fat)
		var/icon/I2 = new/icon(icon,"[icon_state]_fat")
		I2.Blend(RF.color,ICON_MULTIPLY)
		I.Blend(I2,ICON_OVERLAY)

	if(RM.flags_reagent & FLAG_REAGENT_COOKED)
		last_cooked = TRUE
		if(reagents.volume_current > 10 || icon_state == "patty")
			var/icon/I3 = new/icon(icon,"grill_marks")
			var/icon/I4 = new/icon(I)
			I4.Blend(rgb(0,0,0,200),ICON_MULTIPLY)
			I3.Blend(I4,ICON_ADD)
			I.Blend(I3,ICON_OVERLAY)

	icon = I

	return ..()


/obj/item/container/food/dynamic/meat/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/stealthy=FALSE)

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

			for(var/i=1,i<=pieces-1,i++)
				var/obj/item/container/food/dynamic/meat/M = new(get_turf(src))
				INITIALIZE(M)
				reagents.transfer_reagents_to(M.reagents,original_volume/pieces)
				animate(M,pixel_x = pixel_x + rand(-4,4),pixel_y= pixel_y + rand(-4,4),time=SECONDS_TO_DECISECONDS(1))
			animate(src,pixel_x = pixel_x + rand(-4,4),pixel_y= pixel_y + rand(-4,4),time=SECONDS_TO_DECISECONDS(1))

			if(is_living(attacker))
				var/mob/living/L = attacker
				L.to_chat("You cut \the [src.name] into [pieces] cutlets.")

		else if(has_prefix(icon_state,"cutlet"))
			//Make bacon.
			var/pieces = FLOOR(original_volume/5, 1)
			if(pieces <= 1 || original_volume < pieces)
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat("There isn't enough meat to cut!")
				return FALSE

			for(var/i=1,i<=pieces-1,i++)
				var/obj/item/container/food/dynamic/meat/M = new(get_turf(src))
				INITIALIZE(M)
				reagents.transfer_reagents_to(M.reagents,original_volume/pieces)
				animate(M,pixel_x = pixel_x + rand(-4,4),pixel_y= pixel_y + rand(-4,4),time=5)
			animate(src,pixel_x = pixel_x + rand(-4,4),pixel_y= pixel_y + rand(-4,4),time=5)
			update_sprite()

			if(is_living(attacker))
				var/mob/living/L = attacker
				L.to_chat("You cut \the [src.name] into [pieces] bacon slices.")


	else if( (!damage_table[BLADE] && damage_table[BLUNT]) || damage_table[BLADE] < damage_table[BLUNT]) //Flatten

		var/original_volume = reagents.volume_current

		if(has_prefix(icon_state,"meat") || has_prefix(icon_state,"cutlet"))
			//Make ground beef.
			var/pieces = FLOOR(original_volume/10, 1)
			if(pieces <= 1 || original_volume < pieces)
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat("There isn't enough meat to pound!")
				return FALSE

			src.icon_state = "ground"
			for(var/i=1,i<=pieces-1,i++)
				var/obj/item/container/food/dynamic/meat/M = new(get_turf(src))
				M.icon_state = "ground"
				INITIALIZE(M)
				reagents.transfer_reagents_to(M.reagents,original_volume/pieces)
				animate(M,pixel_x = pixel_x + rand(-4,4),pixel_y=pixel_y + rand(-4,4),time=5)
			animate(src,pixel_x = pixel_x + rand(-4,4),pixel_y=pixel_y + rand(-4,4),time=5)

			if(is_living(attacker))
				var/mob/living/L = attacker
				L.to_chat("You pound \the [src.name] into [pieces] portion\s of ground beef.")

	return TRUE


/obj/item/container/food/dynamic/meat/raw/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/cow,15)
	reagents.add_reagent(/reagent/nutrition/fat/cow,5)
	return ..()

/obj/item/container/food/dynamic/meat/cooked_steak/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/cow,15)
	reagents.add_reagent(/reagent/nutrition/fat/cow,5)
	return ..()

/obj/item/container/food/dynamic/meat/cooked_cutlet/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/cow/cooked,7)
	reagents.add_reagent(/reagent/nutrition/fat/cow,3)
	return ..()

/obj/item/container/food/dynamic/meat/cooked_bacon/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/cow/cooked,3)
	reagents.add_reagent(/reagent/nutrition/fat/cow,2)
	return ..()

/obj/item/container/food/dynamic/meat/raw_beefman/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/cow,15)
	reagents.add_reagent(/reagent/nutrition/fat/cow,5)
	return ..()

/obj/item/container/food/dynamic/meat/xeno/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/xeno,15)
	reagents.add_reagent(/reagent/toxin/xeno_acid,15)
	return ..()

/obj/item/container/food/dynamic/meat/spider/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/spider,15)
	reagents.add_reagent(/reagent/toxin/spider_toxin,5)
	return ..()

/obj/item/container/food/dynamic/meat/bear/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/bear,20)
	reagents.add_reagent(/reagent/nutrition/fat/bear,10)
	return ..()

/obj/item/container/food/dynamic/meat/penguin/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/penguin,15)
	reagents.add_reagent(/reagent/nutrition/fat/penguin,5)
	return ..()

/obj/item/container/food/dynamic/meat/fish/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/fish,15)
	reagents.add_reagent(/reagent/nutrition/fat/fish,5)
	return ..()

/obj/item/container/food/dynamic/meat/crab/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/crab,15)
	reagents.add_reagent(/reagent/nutrition/fat/crab,5)
	return ..()

