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

	drop_sound = 'sound/items/drop/soda.ogg'

	size = SIZE_1

/obj/item/container/simple/can/click_self(var/mob/activator,location,control,params)

	if(open) return ..()

	INTERACT_CHECK
	INTERACT_DELAY(1)

	activator.visible_message(span("notice","\The [activator.name] opens \the [src.name]."),span("notice","You open \the [src.name]."))
	//TODO: Pop sounds for certain objects.
	open = TRUE
	allow_reagent_transfer_to = TRUE
	allow_reagent_transfer_from = TRUE

	return TRUE

/obj/item/container/simple/can/cola/
	name = "\improper Space Cola"
	icon_state = "cola"
	value = 1

/obj/item/container/simple/can/cola/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/cola,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/grape_soda/
	name = "\improper Starkist Grape Soda"
	icon_state = "grape_soda"
	value = 1

/obj/item/container/simple/can/grape_soda/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/grape,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/orange_soda/
	name = "\improper Starkist Orange Soda"
	icon_state = "orange_soda"
	value = 1

/obj/item/container/simple/can/orange_soda/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/orange,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/iced_tea/
	name = "\improper Disk! Iced Tea"
	icon_state = "iced_tea"
	value = 1

/obj/item/container/simple/can/iced_tea/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/iced_tea,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/grey_bull/
	name = "\improper Grey Bull"
	icon_state = "grey_bull"
	reagents = /reagent_container/beaker/

	rarity = RARITY_RARE

	value = 1

/obj/item/container/simple/can/grey_bull/Generate()
	reagents.add_reagent(/reagent/nutrition/energy/grey_bull,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/mountain_wind/
	name = "\improper Space Mountain Wind"
	icon_state = "mountain_wind"
	value = 1

/obj/item/container/simple/can/mountain_wind/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/mountain_wind,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/dr_gibb
	name = "\improper Dr. Gibb"
	icon_state = "dr_gibb"
	value = 1

/obj/item/container/simple/can/dr_gibb/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/dr_gibb,reagents.volume_max)
	open = FALSE
	return ..()

/obj/item/container/simple/can/dr_gibb/explosive
	name = "Dr. Gibbs"
	var/explosive = TRUE
	value = 300

	rarity = RARITY_RARE

/obj/item/container/simple/can/dr_gibb/explosive/get_examine_list(var/mob/examiner)

	. = ..()

	if(explosive)
		. += div("danger","Wait, what the fuck? There is an explosive charge connected to the tab!")


/obj/item/container/simple/can/dr_gibb/explosive/click_self(var/mob/activator,location,control,params)

	. = ..()

	if(. && explosive && open && is_living(activator))
		var/turf/T = get_turf(src)
		if(T)
			T.visible_message(span("danger","You hear a mechanical click when you open the tab... oh fu-"))
			var/mob/living/L = activator
			explode(T,3,activator,src,L.loyalty_tag)
			explosive = FALSE


/obj/item/container/simple/can/dr_gibb/explosive/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("explosive")

/obj/item/container/simple/can/dr_gibb/explosive/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("explosive")

/obj/item/container/simple/can/space_up/
	name = "\improper Space Up!"
	icon_state = "space_up"
	value = 1

/obj/item/container/simple/can/space_up/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/space_up,reagents.volume_max)
	open = FALSE
	return ..()