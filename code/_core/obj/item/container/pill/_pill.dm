/obj/item/container/pill
	name = "pill"
	desc = "FLOORPILL"

	icon = 'icons/obj/item/container/pills.dmi'
	icon_state = "rectangle"

	desc_extended = "Hope you remember what the pill is."

	var/double = FALSE

	size = SIZE_0

	var/reagent_container/reagents_2

	value = 1

/obj/item/container/pill/get_consume_verb()
	return "swallow"

/obj/item/container/pill/get_consume_sound()
	return null

/obj/item/container/pill/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())


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


/obj/item/container/pill/get_reagents_to_consume()
	var/reagent_container/temp/T = new(src,1000)
	reagents?.transfer_reagents_to(T,reagents.volume_current)
	reagents_2?.transfer_reagents_to(T,reagents_2.volume_current)
	return T.qdeleting ? null : T

/obj/item/container/pill/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!is_living(object))
		return ..()

	INTERACT_CHECK

	var/reagent_container/R = get_reagents_to_consume()
	R.consume(caller,object)

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
