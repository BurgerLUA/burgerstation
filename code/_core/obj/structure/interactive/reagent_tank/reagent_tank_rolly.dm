/obj/structure/interactive/reagent_tank/rolly/
	icon = 'icons/obj/structure/rolly_tanks.dmi'
	icon_state = "tank"

	reagents = /reagent_container/big_tank/color

/obj/structure/interactive/reagent_tank/rolly/update_icon()
	. = ..()
	icon_state = "tank_liquid"

/obj/structure/interactive/reagent_tank/rolly/update_underlays()
	. = ..()
	var/image/I = new/image(initial(icon),"tank")
	I.appearance_flags = RESET_COLOR | PIXEL_SCALE
	add_underlay(I)

/obj/structure/interactive/reagent_tank/rolly/update_overlays()

	. = ..()
	var/image/I2 = new/image(initial(icon),"tank_color")
	I2.appearance_flags = RESET_COLOR | PIXEL_SCALE
	I2.color = initial(color)
	add_overlay(I2)


/obj/structure/interactive/reagent_tank/rolly/Finalize()
	update_sprite()
	return ..()


/obj/structure/interactive/reagent_tank/rolly/water
	name = "water tank"
	color = "#44AAE2"

/obj/structure/interactive/reagent_tank/rolly/water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)
	return ..()

/obj/structure/interactive/reagent_tank/rolly/ethanol
	name = "ethanol tank"
	color = "#FFD800"

/obj/structure/interactive/reagent_tank/rolly/ethanol/Generate()
	reagents.add_reagent(/reagent/nutrition/ethanol,reagents.volume_max)
	return ..()

/obj/structure/interactive/reagent_tank/rolly/lube
	name = "lube tank"
	color = "#FF00DC"

/obj/structure/interactive/reagent_tank/rolly/lube/Generate()
	reagents.add_reagent(/reagent/lube,reagents.volume_max)
	return ..()

/obj/structure/interactive/reagent_tank/rolly/cheese_powder
	name = "cheese powder tank"
	color = "#FFD800"

/obj/structure/interactive/reagent_tank/rolly/cheese_powder/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/cheese_powder,reagents.volume_max)
	return ..()

/obj/structure/interactive/reagent_tank/rolly/cream_filling
	name = "cream filling tank"
	color = "#FFFFFF"

/obj/structure/interactive/reagent_tank/rolly/cream_filling/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/cream_filling,reagents.volume_max)
	return ..()


/obj/structure/interactive/reagent_tank/rolly/butter
	name = "butter tank"
	color = "#FFFF00"

/obj/structure/interactive/reagent_tank/rolly/butter/Generate()
	reagents.add_reagent(/reagent/nutrition/butter,reagents.volume_max)
	return ..()