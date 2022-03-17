/obj/item/container/simple/
	var/initial_reagent = /reagent/nutrition/ethanol

/obj/item/container/simple/Generate()
	. = ..()
	if(initial_reagent)
		reagents.add_reagent(initial_reagent,reagents.volume_max)

/obj/item/container/simple/can
	name = "generic soda can"
	desc = "ERROR."
	desc_extended = "Holds reagents."
	crafting_id = "soda_can"

	icon = 'icons/obj/item/container/cup/cans_new.dmi'
	icon_state = ""

	reagents = /reagent_container/beaker/bottle/

	allow_reagent_transfer_to = FALSE //Needs to be open, first.
	allow_reagent_transfer_from = FALSE

	var/open = TRUE

	value = 1

	drop_sound = 'sound/items/drop/soda.ogg'

/obj/item/container/simple/can/click_self(var/mob/caller,location,control,params)

	if(open) return ..()

	INTERACT_CHECK
	INTERACT_DELAY(1)

	caller.visible_message(span("notice","\The [caller.name] opens \the [src.name]."),span("notice","You open \the [src.name]."))
	//TODO: Pop sounds for certain objects.
	open = TRUE
	allow_reagent_transfer_to = TRUE
	allow_reagent_transfer_from = TRUE

	return TRUE

/obj/item/container/simple/can/cola/
	name = "\improper Space Cola"
	icon_state = "cola"

/obj/item/container/simple/can/cola/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/cola,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/grape_soda/
	name = "\improper Starkist Grape Soda"
	icon_state = "grape_soda"

/obj/item/container/simple/can/grape_soda/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/grape,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/orange_soda/
	name = "\improper Starkist Orange Soda"
	icon_state = "orange_soda"

/obj/item/container/simple/can/orange_soda/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/orange,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/iced_tea/
	name = "\improper Disk! Iced Tea"
	icon_state = "iced_tea"

/obj/item/container/simple/can/iced_tea/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/iced_tea,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/grey_bull/
	name = "\improper Grey Bull"
	icon_state = "grey_bull"
	reagents = /reagent_container/beaker/

/obj/item/container/simple/can/grey_bull/Generate()
	reagents.add_reagent(/reagent/nutrition/energy/grey_bull,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/mountain_wind/
	name = "\improper Space Mountain Wind"
	icon_state = "mountain_wind"

/obj/item/container/simple/can/mountain_wind/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/mountain_wind,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/dr_gibb
	name = "\improper Dr. Gibb"
	icon_state = "dr_gibb"

/obj/item/container/simple/can/dr_gibb/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/dr_gibb,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/dr_gibb/explosive
	name = "Dr. Gibbs"
	var/explosive = TRUE
	value = 300

/obj/item/container/simple/can/dr_gibb/explosive/get_examine_list(var/mob/examiner)

	. = ..()

	if(explosive)
		. += div("danger","Wait, what the fuck? There is an explosive charge connected to the tab!")


/obj/item/container/simple/can/dr_gibb/explosive/click_self(var/mob/caller)

	. = ..()

	if(. && explosive && open && is_living(caller))
		var/turf/T = get_turf(src)
		if(T)
			T.visible_message(span("danger","You hear a mechanical click when you open the tab... oh fu-"))
			var/mob/living/L = caller
			explode(T,15,caller,src,L.loyalty_tag)
			explosive = FALSE


/obj/item/container/simple/can/dr_gibb/explosive/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE)
	. = ..()
	SAVEVAR("explosive")

/obj/item/container/simple/can/dr_gibb/explosive/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("explosive")

/obj/item/container/simple/can/space_up/
	name = "\improper Space Up!"
	icon_state = "space_up"

/obj/item/container/simple/can/space_up/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/space_up,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/get_consume_verb()
	return "drink"
/obj/item/container/simple/can/get_consume_sound()
	return 'sound/items/consumables/drink.ogg'
