/obj/item/container/cheese_mold
	name = "cheese mold"
	desc = "Make cheese with this."
	desc_extended = "Cheesemaking is a delicate process. In order to make the best cheese, it needs to be mixed in open air and left undisturbed until it is fully formed. This can take up to a minute."

	icon = 'icons/obj/item/container/cheese_mold.dmi'
	icon_state = "wheel"

	reagents = /reagent_container/cheese_mold

	allow_reagent_transfer_to = TRUE
	allow_reagent_transfer_from = TRUE

	var/list/cheese_mix = list()
	var/process_count = 0

	value = 30

/obj/item/container/cheese_mold/block
	icon_state = "block"

/obj/item/container/cheese_mold/think()

	if(process_count < CHEESE_PROCESS_TIME)
		var/area/A = get_area(src)
		if(A)
			process_count++
			if(cheese_mix[A.cheese_type])
				cheese_mix[A.cheese_type] += 1
			else
				cheese_mix[A.cheese_type] = 1
			if(process_count >= CHEESE_PROCESS_TIME)
				src.visible_message(span("notice","The cheese in \the [src.name] finishes curdling!"))
		. = TRUE

	return ..() || .

/obj/item/container/cheese_mold/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(process_count < CHEESE_PROCESS_TIME || !is_inventory(object))
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/turf/T = get_turf(src)
	if(!T)
		T = get_turf(caller)

	if(!T)
		return FALSE //Something terrible went wrong.

	var/obj/item/container/edible/dynamic/cheese/C = new(T)
	C.icon_state = src.icon_state //Shape the cheese.
	INITIALIZE(C)

	var/original_temperature = reagents.average_temperature

	var/total_milk_volume = 0

	for(var/r_id in src.reagents.stored_reagents)
		var/reagent_volume = reagents.stored_reagents[r_id]
		var/reagent_temperature = reagents.stored_reagents_temperature[r_id]
		if(ispath(r_id,/reagent/nutrition/milk/))
			total_milk_volume += reagent_volume
			continue
		if(ispath(r_id,/reagent/enzymes))
			continue
		C.reagents.add_reagent(r_id,reagent_volume,reagent_temperature,FALSE,FALSE)

	src.reagents.remove_reagents() //Safe to update.

	var/best_cheese = null
	var/best_cheese_value = 0

	for(var/k in cheese_mix)
		var/v = cheese_mix[k]
		if(!best_cheese || v > best_cheese_value)
			best_cheese = k
			best_cheese_value = v

	C.reagents.add_reagent(best_cheese,total_milk_volume,original_temperature)

	FINALIZE(C)

	C.reagents.process_recipes() //Update container is called in FINALIZE(C)

	caller.to_chat(span("notice","You take \the [C.name] out of \the [src.name]."))

	return TRUE


/obj/item/container/cheese_mold/click_self(var/mob/caller,location,control,params)

	var/answer = input("Are you sure you want to empty the contents of \the [src.name]?","Empty Contents","Cancel") in list("Yes","No","Cancel")
	if(answer == "Yes")
		INTERACT_CHECK
		INTERACT_DELAY(1)
		reagents.remove_all_reagents(reagents.volume_current)
		caller.visible_message(span("notice","\The [caller.name] empties \the [src.name] of its contents."),span("notice","You empty \the [src.name] of its contents."))

	return TRUE


/obj/item/container/cheese_mold/update_icon()

	if(allow_reagent_transfer_to && allow_reagent_transfer_from)

		var/milk_count = 0
		var/enzyme_count = 0

		for(var/reagent_type in reagents.stored_reagents)
			var/reagent_volume = reagents.stored_reagents[reagent_type]
			var/reagent/R = REAGENT(reagent_type)
			if(istype(R,/reagent/nutrition/milk/))
				milk_count += reagent_volume
			else if(istype(R,/reagent/enzymes/))
				enzyme_count += reagent_volume

		if(milk_count >= 40 && enzyme_count >= 10)
			allow_reagent_transfer_to = FALSE
			allow_reagent_transfer_from = FALSE
			var/turf/T = get_turf(src)
			T.visible_message(span("notice","The milk starts to curdle!"))
			START_THINKING(src)

	return ..()


/obj/item/container/cheese_mold/update_overlays()

	. = ..()

	if(reagents.volume_current)
		var/image/I = new/image(icon,"[icon_state]_fill")
		I.color = reagents.color
		add_overlay(I)

