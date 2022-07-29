/obj/item/container/simple/beaker
	name = "glass beaker"
	desc = "For the mad scientist in all of us."
	desc_extended = "Holds reagents."
	crafting_id = "beaker"

	icon = 'icons/obj/item/container/cup/beaker.dmi'
	icon_state = "beaker"

	reagents = /reagent_container/beaker/

	var/icon_count = 8

	allow_reagent_transfer_to = TRUE
	allow_reagent_transfer_from = TRUE

	var/overide_icon = FALSE

	value = 10

	drop_sound = 'sound/items/drop/bottle.ogg'

	has_quick_function = TRUE

	value = 0

	size = SIZE_2

/obj/item/container/simple/beaker/Finalize()
	. = ..()
	update_sprite()

/obj/item/container/simple/beaker/update_underlays()
	. = ..()
	if(!overide_icon)
		var/image/I = new/image(initial(icon),"liquid_[CEILING(clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)]")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.color = reagents.color
		add_underlay(I)











/obj/item/container/simple/beaker/water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/potassium/Generate()
	reagents.add_reagent(/reagent/potassium,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/tnt/Generate()
	reagents.add_reagent(/reagent/fuel/tnt,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/tnt_fragments/Generate()
	reagents.add_reagent(/reagent/fuel/tnt,20)
	reagents.add_reagent(/reagent/iron,40)
	return ..()

/obj/item/container/simple/beaker/smoke_01/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,20)
	reagents.add_reagent(/reagent/potassium,40)
	return ..()

/obj/item/container/simple/beaker/smoke_02/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,20)
	reagents.add_reagent(/reagent/phosphorous,40)
	return ..()

/obj/item/container/simple/beaker/flashbang/Generate()
	reagents.add_reagent(/reagent/fuel/flash_powder,reagents.volume_max)
	return ..()