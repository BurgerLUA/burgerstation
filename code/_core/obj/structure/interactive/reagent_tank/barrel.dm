/obj/structure/interactive/reagent_tank/barrel
	name = "barrel"
	desc = "Rolling, rolling, rolling."
	icon = 'icons/obj/structure/barrel.dmi'


/obj/structure/interactive/reagent_tank/barrel/oil
	name = "oil drum"
	icon_state = "fuel"

/obj/structure/interactive/reagent_tank/barrel/oil/Generate()
	reagents.add_reagent(/reagent/fuel/oil/crude,rand(reagents.volume_max*0.5,reagents.volume_max))
	return ..()

/obj/structure/interactive/reagent_tank/barrel/water
	name = "water barrel"
	icon_state = "water"

/obj/structure/interactive/reagent_tank/barrel/water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,rand(reagents.volume_max*0.5,reagents.volume_max))
	return ..()