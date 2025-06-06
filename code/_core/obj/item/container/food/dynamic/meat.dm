/obj/item/container/edible/dynamic/meat
	name = "meat"
	desc = "IT'S RAW!"
	desc_extended = "You need plenty of proteins for soldiering, soldier."
	crafting_id = /obj/item/container/edible/dynamic/meat

	icon = 'icons/obj/item/consumable/food/meat.dmi'
	icon_state = "meat_1"

	health = /health/obj/item/misc/

	cooked_icon_state = "cake"
	raw_icon_state = "dough_ball"

	scale_sprite = FALSE

	value = 0

/obj/item/container/edible/dynamic/meat/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return TRUE

/obj/item/container/edible/dynamic/meat/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(5)

	if(icon_state == "ground")
		icon_state = "meatball"
		activator.to_chat(span("notice","You reshape \the [src.name] into a meatball."))
		pixel_height = 1
		update_sprite()
	else if(icon_state == "meatball")
		icon_state = "patty"
		activator.to_chat(span("notice","You reshape \the [src.name] into a patty."))
		pixel_height = 1
		update_sprite()
	else
		pixel_height = 1

	update_sprite()

	return TRUE

/obj/item/container/edible/dynamic/meat/update_sprite()

	if(!reagents.volume_current)
		return FALSE

	overlays.Cut()

	if(has_prefix(icon_state,"meat_"))
		if(reagents.volume_current <= 5)
			icon_state = "bacon"
		else if(reagents.volume_current <= 10)
			icon_state = "cutlet"

	var/total_fat = 0
	var/best_fat
	var/best_fat_volume

	var/total_meat = 0
	var/meat_r
	var/meat_g
	var/meat_b

	var/carbon_amount = 0

	for(var/reagent_type in reagents.stored_reagents)
		var/reagent/R = REAGENT(reagent_type)
		var/amount = reagents.stored_reagents[reagent_type]
		if(reagent_type == /reagent/carbon)
			carbon_amount += amount
			continue
		if(R.flags_reagent & FLAG_REAGENT_FAT)
			total_fat += amount
			if(!best_fat || amount > best_fat_volume)
				best_fat = reagent_type
				best_fat_volume = amount
			continue
		if(R.flags_reagent & (FLAG_REAGENT_RAW | FLAG_REAGENT_COOKED))
			total_meat += amount
			meat_r += GetRedPart(R.color) * amount
			meat_g += GetGreenPart(R.color) * amount
			meat_b += GetBluePart(R.color) * amount

	if(total_meat)
		meat_r *= (1/total_meat)
		meat_g *= (1/total_meat)
		meat_b *= (1/total_meat)

	if(best_fat)
		var/reagent/RF = REAGENT(best_fat)
		var/image/fat_image = new/image(initial(icon),"[icon_state]_fat")
		fat_image.appearance_flags = src.appearance_flags | RESET_COLOR
		fat_image.color = RF ? RF.color : "#FFFFFF"
		add_overlay(fat_image)

	if(carbon_amount)
		var/image/carbon_image = new/image(initial(icon),"[icon_state]_marks")
		carbon_image.appearance_flags = src.appearance_flags | RESET_COLOR
		carbon_image.alpha = clamp(carbon_amount*55,0,255)
		add_overlay(carbon_image)

	color = blend_colors(rgb(meat_r,meat_g,meat_b),"#000000",carbon_amount/(reagents.volume_current*0.5))

	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		I.overlays.Cut()
		I.update_overlays()

	return TRUE


/obj/item/container/edible/dynamic/meat/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if( (damage_table[BLADE] && !damage_table[BLUNT]) || damage_table[BLADE] > damage_table[BLUNT]) //Cut

		var/original_volume = reagents.volume_current

		if(has_prefix(icon_state,"meat_"))
			//Make cutlets.
			var/pieces = FLOOR(original_volume/10, 1)
			if(pieces <= 1 || original_volume < pieces)
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat(span("warning","There isn't enough meat in \the [src.name] to cut!"))
				return FALSE

			for(var/i=1,i<=pieces-1,i++)
				var/obj/item/container/edible/dynamic/meat/M = new(get_turf(src))
				INITIALIZE(M)
				reagents.transfer_reagents_to(M.reagents,original_volume/pieces)
				FINALIZE(M)
				animate(M,pixel_x = pixel_x + rand(-4,4),pixel_y= pixel_y + rand(-4,4),time=SECONDS_TO_DECISECONDS(1))
			animate(src,pixel_x = pixel_x + rand(-4,4),pixel_y= pixel_y + rand(-4,4),time=SECONDS_TO_DECISECONDS(1))

			if(is_living(attacker))
				var/mob/living/L = attacker
				L.visible_message(span("notice","\The [L.name] cuts \the [src.name] into cutlets."),span("notice","You cut \the [src.name] into [pieces] cutlets."))

		else if(has_prefix(icon_state,"cutlet"))
			//Make bacon.
			var/pieces = FLOOR(original_volume/5, 1)
			if(pieces <= 1 || original_volume < pieces)
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat(span("warning","There isn't enough meat in \the [src.name] to cut!"))
				return FALSE

			for(var/i=1,i<=pieces-1,i++)
				var/obj/item/container/edible/dynamic/meat/M = new(get_turf(src))
				INITIALIZE(M)
				reagents.transfer_reagents_to(M.reagents,original_volume/pieces)
				FINALIZE(M)
				animate(M,pixel_x = pixel_x + rand(-4,4),pixel_y= pixel_y + rand(-4,4),time=5)
			animate(src,pixel_x = pixel_x + rand(-4,4),pixel_y= pixel_y + rand(-4,4),time=5)
			update_sprite()

			if(is_living(attacker))
				var/mob/living/L = attacker
				L.visible_message(span("notice","\The [L.name] cuts \the [src.name] into bacon slices."),span("notice","You cut \the [src.name] into [pieces] bacon slices."))


	else if( (!damage_table[BLADE] && damage_table[BLUNT]) || damage_table[BLADE] < damage_table[BLUNT]) //Flatten

		var/original_volume = reagents.volume_current

		if(has_prefix(icon_state,"meat") || has_prefix(icon_state,"cutlet"))
			//Make ground beef.
			var/pieces = FLOOR(original_volume/10, 1)
			if(pieces <= 1 || original_volume < pieces)
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat(span("warning","There isn't enough meat in \the [src.name] to pound!"))
				return FALSE

			src.icon_state = "ground"
			for(var/i=1,i<=pieces-1,i++)
				var/obj/item/container/edible/dynamic/meat/M = new(get_turf(src))
				M.icon_state = "ground"
				INITIALIZE(M)
				reagents.transfer_reagents_to(M.reagents,original_volume/pieces)
				FINALIZE(M)
				animate(M,pixel_x = pixel_x + rand(-4,4),pixel_y=pixel_y + rand(-4,4),time=5)
			animate(src,pixel_x = pixel_x + rand(-4,4),pixel_y=pixel_y + rand(-4,4),time=5)

			if(is_living(attacker))
				var/mob/living/L = attacker
				L.visible_message(span("notice","\The [L.name] pounds \the [src.name] into ground beef."),span("notice","You pound \the [src.name] into [pieces] portion\s of ground beef."))

	return TRUE

/obj/item/container/edible/dynamic/meat/raw_arachnid
	value = 1

/obj/item/container/edible/dynamic/meat/raw_arachnid/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/arachnid,15)
	reagents.add_reagent(/reagent/nutrition/bad_meat/chicken,5)
	reagents.add_reagent(/reagent/nutrition/fat/arachnid,5)
	return ..()

/obj/item/container/edible/dynamic/meat/raw_ash_drake
	value = 1

/obj/item/container/edible/dynamic/meat/raw_ash_drake/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/ash_drake,15)
	reagents.add_reagent(/reagent/nutrition/bad_meat/ancient,5)
	reagents.add_reagent(/reagent/blood/ancient,5)
	reagents.add_reagent(/reagent/ash,5)
	reagents.add_reagent(/reagent/nutrition/fat/ancient,5)
	return ..()

/obj/item/container/edible/dynamic/meat/raw_bubblegum
	value = 1

/obj/item/container/edible/dynamic/meat/raw_bubblegum/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/bubblegum,15)
	reagents.add_reagent(/reagent/nutrition/bad_meat/ancient,5)
	reagents.add_reagent(/reagent/blood/ancient,10)
	reagents.add_reagent(/reagent/nutrition/fat/ancient,5)
	return ..()

/obj/item/container/edible/dynamic/meat/raw_colossus
	value = 1

/obj/item/container/edible/dynamic/meat/raw_colossus/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/colossus,15)
	reagents.add_reagent(/reagent/nutrition/bad_meat/ancient,5)
	reagents.add_reagent(/reagent/blood/ancient,5)
	reagents.add_reagent(/reagent/nutrition/fat/ancient,5)
	return ..()

/obj/item/container/edible/dynamic/meat/raw_monkey
	value = 1

/obj/item/container/edible/dynamic/meat/raw_monkey/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/monkey,10)
	reagents.add_reagent(/reagent/nutrition/bad_meat,5)
	reagents.add_reagent(/reagent/nutrition/fat/monkey,5)
	return ..()

/obj/item/container/edible/dynamic/meat/raw
	value = 1

/obj/item/container/edible/dynamic/meat/raw/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/cow,10)
	reagents.add_reagent(/reagent/nutrition/bad_meat,5)
	reagents.add_reagent(/reagent/nutrition/fat/cow,5)
	return ..()

/obj/item/container/edible/dynamic/meat/cooked_steak
	value = 1

/obj/item/container/edible/dynamic/meat/cooked_steak/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/cow,15)
	reagents.add_reagent(/reagent/nutrition/fat/cow,5)
	return ..()

/obj/item/container/edible/dynamic/meat/cooked_cutlet
	value = 1

/obj/item/container/edible/dynamic/meat/cooked_cutlet/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/cow/cooked,7)
	reagents.add_reagent(/reagent/nutrition/fat/cow,3)
	return ..()

/obj/item/container/edible/dynamic/meat/cooked_bacon
	value = 1

/obj/item/container/edible/dynamic/meat/cooked_bacon/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/cow/cooked,3)
	reagents.add_reagent(/reagent/nutrition/fat/cow,2)
	return ..()

/obj/item/container/edible/dynamic/meat/raw_beefman
	value = 1

/obj/item/container/edible/dynamic/meat/raw_beefman/Generate()
	reagents.add_reagent(/reagent/nutrition/meat,10)
	reagents.add_reagent(/reagent/nutrition/bad_meat,5)
	reagents.add_reagent(/reagent/nutrition/fat/cow,5)
	return ..()

/obj/item/container/edible/dynamic/meat/raw_xeno
	value = 1

/obj/item/container/edible/dynamic/meat/raw_xeno/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/xeno,10)
	reagents.add_reagent(/reagent/nutrition/bad_meat/chicken,5)
	reagents.add_reagent(/reagent/nutrition/fat/xeno,5)
	reagents.add_reagent(/reagent/toxin/xeno_acid,15)
	return ..()

/obj/item/container/edible/dynamic/meat/raw_spider
	value = 1

/obj/item/container/edible/dynamic/meat/raw_spider/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/spider,10)
	reagents.add_reagent(/reagent/nutrition/bad_meat/insect,5)
	reagents.add_reagent(/reagent/toxin/spider_toxin,5)
	return ..()

/obj/item/container/edible/dynamic/meat/raw_bear
	value = 1

/obj/item/container/edible/dynamic/meat/raw_bear/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/bear,15)
	reagents.add_reagent(/reagent/nutrition/bad_meat,5)
	reagents.add_reagent(/reagent/nutrition/fat/bear,10)
	return ..()

/obj/item/container/edible/dynamic/meat/raw_goliath
	value = 1

/obj/item/container/edible/dynamic/meat/raw_goliath/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/goliath,10)
	reagents.add_reagent(/reagent/nutrition/bad_meat/chicken,5)
	reagents.add_reagent(/reagent/nutrition/fat/goliath,5)
	return ..()


