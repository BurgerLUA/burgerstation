/obj/item/container/pill
	name = "pill"
	desc = "FLOORPILL"

	icon = 'icons/obj/item/container/pills.dmi'
	icon_state = "rectangle"

	desc_extended = "Hope you remember what the pill is."

	var/double = FALSE

	size = SIZE_0
	weight = WEIGHT_0

	var/reagent_container/reagents_2

	value = 1

/obj/item/container/pill/save_item_data(var/save_inventory = TRUE)
	. = ..()
	.["double"] = double
	if(reagents_2) .["reagents_2"] = reagents_2.stored_reagents
	return .


/obj/item/container/pill/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)

	. = ..()

	if(object_data["double"]) double = object_data["double"]

	return .

/obj/item/container/pill/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)

	. = ..()

	if(object_data["reagents_2"] && length(object_data["reagents_2"]))
		for(var/r_id in object_data["reagents_2"])
			var/volume = object_data["reagents_2"][r_id]
			reagents_2.add_reagent(r_id,volume,TNULL,FALSE)
		reagents_2.update_container()

	return .


/obj/item/container/pill/calculate_value()

	. = ..()

	if(reagents_2 && length(reagents_2.stored_reagents))
		for(var/reagent_type in reagents_2.stored_reagents)
			var/reagent_volume = reagents_2.stored_reagents[reagent_type]
			var/reagent/R = REAGENT(reagent_type)
			. += R.value*reagent_volume

	return .


/obj/item/container/pill/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!is_advanced(object))
		return ..()

	INTERACT_CHECK

	var/mob/living/advanced/A2 = object

	if(!A2.labeled_organs[BODY_STOMACH])
		A2.to_chat(span("warning","You don't know how you can swallow \the [src]!"))
		return FALSE

	var/obj/item/organ/internal/stomach/S = A2.labeled_organs[BODY_STOMACH]

	if(reagents)
		reagents.transfer_reagents_to(S.reagents,reagents.volume_current)

	if(reagents_2)
		reagents_2.transfer_reagents_to(S.reagents,reagents_2.volume_current)

	A2.to_chat(span("notice","You swallow \the [src]."))

	qdel(src)

	return TRUE

/obj/item/container/pill/Generate()
	. = ..()
	update_sprite()
	return .

/obj/item/container/pill/update_sprite()

	if(double)
		color = null
	else
		color = reagents.color

	return ..()

/obj/item/container/pill/update_overlays()

	. = ..()

	if(double)
		var/image/I1 = new/image(icon,"[icon_state]_double_left")
		I1.color = reagents.color
		add_overlay(I1)

		var/image/I2 = new/image(icon,"[icon_state]_double_right")
		I2.color = reagents_2.color
		add_overlay(I2)

	return .

/obj/item/container/pill/New(var/desired_loc)

	. = ..()

	if(double)
		reagents_2 = /reagent_container/pill/half
		reagents = /reagent_container/pill/half
	else
		reagents = /reagent_container/pill

	return .

/obj/item/container/pill/Initialize()

	if(reagents_2)
		reagents_2 = new reagents(src)

	return ..()


/obj/item/container/pill/double/ //Yes, this is shitcode.
	icon_state = "circle"
	double = TRUE
