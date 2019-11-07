/obj/item/container/food/dynamic/chicken
	name = "chicken"
	icon = 'icons/obj/items/consumable/food/meat.dmi'
	icon_state = "chicken"
	crafting_id = "chicken"

	health = /health/obj/item/misc/

	scale_sprite = FALSE

/obj/item/container/food/dynamic/chicken/update_icon()

	var/total_raw = 0
	var/total_cooked = 0

	var/best_meat
	var/best_meat_volume

	for(var/reagent_id in reagents.stored_reagents)
		var/amount = reagents.stored_reagents[reagent_id]

		if(has_prefix(reagent_id,"cooked_"))
			total_cooked += amount
			if(!best_meat || amount > best_meat_volume)
				best_meat = reagent_id
				best_meat_volume = amount

		else if(has_prefix(reagent_id,"raw_"))
			total_raw += amount
			if(!best_meat || amount > best_meat_volume)
				best_meat = reagent_id
				best_meat_volume = amount

	if(!best_meat)
		return ..()

	icon = initial(icon)

	var/icon/I = new/icon(icon,icon_state)
	I.Blend(all_reagents[best_meat].color,ICON_MULTIPLY)

	if(has_prefix(best_meat,"cooked_chicken_"))
		var/icon/I3 = new/icon(icon,"grill_marks")
		var/icon/I4 = new/icon(I)
		I4.Blend(rgb(0,0,0,200),ICON_MULTIPLY)
		I3.Blend(I4,ICON_ADD)
		I.Blend(I3,ICON_OVERLAY)

	icon = I

	return ..()

/obj/item/container/food/dynamic/chicken/raw/on_spawn()
	reagents.add_reagent("raw_chicken",10)
	return ..()

/obj/item/container/food/dynamic/chicken/cooked/on_spawn()
	reagents.add_reagent("cooked_chicken",10)
	return ..()