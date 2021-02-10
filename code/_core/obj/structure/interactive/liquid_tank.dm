/obj/structure/interactive/reagent_tank
	name = "liquid tank"
	desc = "Versitile!"
	desc_extended = "A large portable liquid tank that stores all types of fluids."
	icon = 'icons/obj/structure/rolly_tanks.dmi'
	icon_state = "tank"

	reagents = /reagent_container/water_tank

	allow_reagent_transfer_from = TRUE
	allow_reagent_transfer_to = FALSE

	anchored = FALSE

/obj/structure/interactive/reagent_tank/update_icon()
	. = ..()
	icon_state = "tank_liquid"
	return .

/obj/structure/interactive/reagent_tank/update_underlays()
	. = ..()
	var/image/I = new/image(initial(icon),"tank")
	I.appearance_flags = RESET_COLOR | PIXEL_SCALE
	add_underlay(I)
	return .

/obj/structure/interactive/reagent_tank/update_overlays()

	. = ..()

	var/image/I2 = new/image(initial(icon),"tank_color")
	I2.appearance_flags = RESET_COLOR | PIXEL_SCALE
	I2.color = initial(color)
	add_overlay(I2)

	return .

/obj/structure/interactive/reagent_tank/Finalize()
	update_sprite()
	return ..()


/obj/structure/interactive/reagent_tank/water
	name = "water tank"
	color = "#44AAE2"

/obj/structure/interactive/reagent_tank/water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)
	return ..()

/obj/structure/interactive/reagent_tank/ethanol
	name = "ethanol tank"
	color = "#FFD800"

/obj/structure/interactive/reagent_tank/ethanol/Generate()
	reagents.add_reagent(/reagent/nutrition/ethanol,reagents.volume_max)
	return ..()

/obj/structure/interactive/reagent_tank/lube
	name = "lube tank"
	color = "#FF00DC"

/obj/structure/interactive/reagent_tank/lube/Generate()
	reagents.add_reagent(/reagent/lube,reagents.volume_max)
	return ..()

/obj/structure/interactive/reagent_tank/cheese_powder
	name = "cheese powder tank"
	color = "#FFD800"

/obj/structure/interactive/reagent_tank/cheese_powder/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/cheese_powder,reagents.volume_max)
	return ..()

/obj/structure/interactive/reagent_tank/cream_filling
	name = "cream filling tank"
	color = "#FFFFFF"

/obj/structure/interactive/reagent_tank/cream_filling/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/cream_filling,reagents.volume_max)
	return ..()


/obj/structure/interactive/reagent_tank/butter
	name = "butter tank"
	color = "#FFFF00"

/obj/structure/interactive/reagent_tank/butter/Generate()
	reagents.add_reagent(/reagent/nutrition/butter,reagents.volume_max)
	return ..()