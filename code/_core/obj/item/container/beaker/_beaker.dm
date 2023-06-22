/obj/item/container/simple/beaker
	name = "glass beaker"
	desc = "For the mad scientist in all of us."
	desc_extended = "Holds reagents."
	crafting_id = "beaker"

	icon = 'icons/obj/item/container/cup/beaker.dmi'
	icon_state = "beaker"

	reagents = /reagent_container/beaker/

	var/icon_count = 10

	allow_reagent_transfer_to = TRUE
	allow_reagent_transfer_from = TRUE

	var/overide_icon = FALSE

	value = 1

	drop_sound = 'sound/items/drop/bottle.ogg'

	has_quick_function = TRUE

	size = SIZE_1

	rarity = RARITY_UNCOMMON

/obj/item/container/simple/beaker/get_base_value()
	. = ..()
	. *= 2

/obj/item/container/simple/beaker/can_feed(var/mob/caller,var/mob/living/target)
	if(!allow_reagent_transfer_from)
		return FALSE
	. = ..()

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

/obj/item/container/simple/beaker/get_examine_list(var/mob/examiner)
	. = ..()
	if(reagents)
		. += div("notice","This can hold up to [reagents.volume_max]u of reagents.")

/obj/item/container/simple/beaker/water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/potassium
	name = "beaker of potassium"

/obj/item/container/simple/beaker/potassium/Generate()
	reagents.add_reagent(/reagent/potassium,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/phosphorous
	name = "beaker of phosphorous"

/obj/item/container/simple/beaker/phosphorous/Generate()
	reagents.add_reagent(/reagent/phosphorous,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/tnt/Generate()
	reagents.add_reagent(/reagent/fuel/tnt,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/iron/Generate()
	reagents.add_reagent(/reagent/iron,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/uranium/Generate()
	reagents.add_reagent(/reagent/radioactive/uranium,reagents.volume_max)
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

/obj/item/container/simple/beaker/oxygen/Generate()
	reagents.add_reagent(/reagent/fuel/oxygen,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/phoron/Generate()
	reagents.add_reagent(/reagent/fuel/phoron,reagents.volume_max)
	return ..()




//Vendor beakers.
/obj/item/container/simple/beaker/vendor
	var/reagent/reagent
	var/reagent_amount = 50
	value_burgerbux = 1 //So it doesn't show up in loot.
	value = 10

/obj/item/container/simple/beaker/vendor/Generate()
	. = ..()
	if(reagent && reagent_amount > 0)
		var/reagent/R = REAGENT(src.reagent)
		name = "[initial(name)] ([R.name] [reagent_amount]u)"
		reagents.add_reagent(src.reagent,reagent_amount)
