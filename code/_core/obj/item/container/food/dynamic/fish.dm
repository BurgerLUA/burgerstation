/obj/item/container/edible/dynamic/fish
	name = "fish"
	desc = "Something smells fishy here..."
	desc_extended = "Fish. It's good for you. Except the mercury."
	icon = 'icons/obj/item/consumable/food/meat.dmi'
	icon_state = "fish"
	crafting_id = "fish"

	health = /health/obj/item/misc/

	scale_sprite = FALSE

/obj/item/container/edible/dynamic/fish/update_sprite()

	if(!reagents.volume_current)
		return FALSE

	overlays.Cut()

	/*
	if(has_prefix(icon_state,"meat_"))
		if(reagents.volume_current <= 5)
			icon_state = "bacon"
		else if(reagents.volume_current <= 10)
			icon_state = "cutlet"
	*/

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




/obj/item/container/edible/dynamic/fish/raw_crab/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/crab,15)
	reagents.add_reagent(/reagent/nutrition/fat/crab,5)
	return ..()

/obj/item/container/edible/dynamic/fish/raw_lobster/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/lobster,10)
	reagents.add_reagent(/reagent/nutrition/fat/lobster,10)
	return ..()

/obj/item/container/edible/dynamic/fish/raw_carp/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/fish,15)
	reagents.add_reagent(/reagent/nutrition/fat/fish,5)
	return ..()