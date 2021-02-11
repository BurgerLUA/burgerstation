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

/obj/item/container/cheese_mold/proc/make_cheese()

	var/turf/T = get_turf(src)

	var/original_temperature = reagents.average_temperature

	var/total_non_enzyme_volume = 0

	for(var/reagent_path in reagents.stored_reagents)
		if(ispath(reagent_path,/reagent/enzymes/))
			continue
		var/reagent_volume = reagents.stored_reagents[reagent_path]
		total_non_enzyme_volume += reagent_volume

	var/obj/item/container/food/dynamic/cheese/C = new(T)
	C.icon_state = icon_state
	INITIALIZE(C)
	for(var/reagent_path in cheese_mix)
		var/reagent_volume = (cheese_mix[reagent_path]/CHEESE_PROCESS_TIME)*total_non_enzyme_volume
		C.reagents.add_reagent(reagent_path,reagent_volume,original_temperature,FALSE,FALSE)
	FINALIZE(C)

	T.visible_message(span("notice","The cheese finishes curdling!"))

	C.reagents.update_container()

	reagents.remove_all_reagents()

	process_count = 0
	allow_reagent_transfer_to = TRUE
	allow_reagent_transfer_from = TRUE
	cheese_mix.Cut()
	stop_thinking(src)

	return TRUE

/obj/item/container/cheese_mold/think()

	if(isturf(loc))
		process_count++
		var/area/A = get_area(src)
		if(cheese_mix[A.cheese_type])
			cheese_mix[A.cheese_type] += 1
		else
			cheese_mix[A.cheese_type] = 1

	if(process_count >= CHEESE_PROCESS_TIME)
		make_cheese()

	return TRUE

/obj/item/container/cheese_mold/click_self(var/mob/caller)

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
			start_thinking(src)

	return ..()


/obj/item/container/cheese_mold/update_overlays()

	. = ..()

	if(reagents.volume_current)
		var/image/I = new/image(icon,"[icon_state]_fill")
		I.color = reagents.color
		add_overlay(I)

	return .