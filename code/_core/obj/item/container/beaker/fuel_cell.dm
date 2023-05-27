/obj/item/container/simple/beaker/fuel_cell
	name = "fuel cell"
	desc = "Do not drink."
	desc_extended = "A special supercooled liquid fuel cell used by less advanced civilizations to power machines. Can be unwrenched to extract its contents."
	icon = 'icons/obj/item/container/fuel_cell.dmi'
	icon_state = "cell"

	icon_count = 6

	allow_reagent_transfer_to = FALSE
	allow_reagent_transfer_from = FALSE

	value = 20

	var/stripe_color = "#FFFFFF"

	reagents = /reagent_container/fuel_cell

	size = SIZE_1

/obj/item/container/simple/beaker/fuel_cell/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("allow_reagent_transfer_to")

/obj/item/container/simple/beaker/fuel_cell/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("allow_reagent_transfer_to")

/obj/item/container/simple/beaker/fuel_cell/Finalize()
	. = ..()
	if(allow_reagent_transfer_to || allow_reagent_transfer_from)
		allow_reagent_transfer_to = TRUE
		allow_reagent_transfer_from = TRUE
		reagents.temperature_change_mul = 1
		SSreagent.all_temperature_reagent_containers += reagents

/obj/item/container/simple/beaker/fuel_cell/click_self(var/mob/caller)

	if(!(allow_reagent_transfer_to || allow_reagent_transfer_from))
		caller.to_chat(span("notice","You'll need a wrench in order to open \the [src.name]!"))
		return TRUE

	. = ..()

/obj/item/container/simple/beaker/fuel_cell/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_WRENCH)
			if(!(allow_reagent_transfer_to || allow_reagent_transfer_from))
				caller.visible_message(span("notice","\The [caller.name] opens \the [src.name] with \the [I.name]."),span("notice","You open \the [src.name] with \the [I.name]."))
				allow_reagent_transfer_to = TRUE
				allow_reagent_transfer_from = TRUE
				reagents.temperature_change_mul = 1
				SSreagent.all_temperature_reagent_containers += reagents
			else
				caller.to_chat(span("warning","\The [src.name] is already open!"))
			return TRUE

	. = ..()

/obj/item/container/simple/beaker/fuel_cell/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"markings")
	I.appearance_flags = src.appearance_flags
	I.color = stripe_color
	add_overlay(I)

/obj/item/container/simple/beaker/fuel_cell/oxygen
	name = "liquid oxygen fuel cell"
	stripe_color = COLOR_CYAN

/obj/item/container/simple/beaker/fuel_cell/oxygen/Generate()
	. = ..()
	reagents.add_reagent(/reagent/fuel/oxygen,reagents.volume_max,T0C - 200)

/obj/item/container/simple/beaker/fuel_cell/hydrogen
	name = "liquid hydrogen fuel cell"
	stripe_color = COLOR_RED

/obj/item/container/simple/beaker/fuel_cell/hydrogen/Generate()
	. = ..()
	reagents.add_reagent(/reagent/fuel/hydrogen,reagents.volume_max,T0C - 200)

/obj/item/container/simple/beaker/fuel_cell/phoron
	name = "liquid phoron fuel cell"
	stripe_color = COLOR_PURPLE

/obj/item/container/simple/beaker/fuel_cell/phoron/Generate()
	. = ..()
	reagents.add_reagent(/reagent/fuel/phoron,reagents.volume_max,T0C - 200)

/obj/item/container/simple/beaker/fuel_cell/nitrogen
	name = "liquid nitrogen fuel cell"
	stripe_color = COLOR_WHITE

/obj/item/container/simple/beaker/fuel_cell/nitrogen/Generate()
	. = ..()
	reagents.add_reagent(/reagent/nitrogen,reagents.volume_max,T0C - 200)