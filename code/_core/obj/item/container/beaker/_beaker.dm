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

//for the chemistry vendor, decided on 50u beakers.

/obj/item/container/simple/beaker/potassium/vendor/Generate()
	name = "Potassium 50u"
	reagents.add_reagent(/reagent/potassium,50)
	return ..()

/obj/item/container/simple/beaker/nitrogen/vendor/Generate()
	name = "Nitrogen 50u"
	reagents.add_reagent(/reagent/nitrogen,50)                    //can also be obtained from nitrogen flowers
	return ..()

/obj/item/container/simple/beaker/silicon/vendor/Generate()
	name = "Silicon 50u"
	reagents.add_reagent(/reagent/silicon,50)
	return ..()

/obj/item/container/simple/beaker/salt/vendor/Generate()
	name = "Salt 50u"
	reagents.add_reagent(/reagent/salt,50)
	return ..()

/obj/item/container/simple/beaker/sodium_chloride/vendor/Generate()
	name = "Sodium Chloride 50u"
	reagents.add_reagent(/reagent/salt/sodium_chloride,50)
	return ..()

/obj/item/container/simple/beaker/ash/vendor/Generate()
	name = "Ash 50u"
	reagents.add_reagent(/reagent/ash,50)
	return ..()

/obj/item/container/simple/beaker/ammonia/vendor/Generate()
	name = "Ammonia 50u"
	reagents.add_reagent(/reagent/ammonia,50)
	return ..()

/obj/item/container/simple/beaker/sulfur/vendor/Generate()
	name = "Sulphur 50u"
	reagents.add_reagent(/reagent/sulfur,50)
	return ..()

/obj/item/container/simple/beaker/chlorine/vendor/Generate()
	name = "Chlorine 50u"
	reagents.add_reagent(/reagent/chlorine,50)
	return ..()

/obj/item/container/simple/beaker/phosphorous/vendor/Generate()
	name = "Phosphorous 50u"
	reagents.add_reagent(/reagent/phosphorous,50)
	return ..()

/obj/item/container/simple/beaker/oxygen/vendor/Generate()
	name = "Oxygen 50u"
	reagents.add_reagent(/reagent/fuel/oxygen,50)                //can also be obtained from oxygen flowers
	return ..()

/obj/item/container/simple/beaker/hydrogen/vendor/Generate()
	name = "Hydrogen 50u"
	reagents.add_reagent(/reagent/fuel/hydrogen,50)
	return ..()

/obj/item/container/simple/beaker/ethanol/vendor/Generate()
	name = "Ethanol 50u"
	reagents.add_reagent(/reagent/nutrition/ethanol,50)
	return ..()
//End of chem vendor reagents. All other chemicals should be obtainable from grinding ores.
