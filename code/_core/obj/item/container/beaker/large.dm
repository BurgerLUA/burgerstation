#define BEAKER(x) \
/obj/item/container/beaker/large##x/Generate() { \
	reagents.add_reagent(##x,reagents.volume_max); \
	return ..();}

/obj/item/container/beaker/large
	name = "large beaker"
	icon = 'icons/obj/item/container/cup/beaker_large.dmi'
	icon_state = "beaker"
	icon_count = 9

	reagents = /reagent_container/beaker/large

	value = 10

/obj/item/container/beaker/large/bicaridine/Generate()
	reagents.add_reagent(/reagent/medicine/bicaridine,reagents.volume_max)
	return ..()

/obj/item/container/beaker/large/kelotane/Generate()
	reagents.add_reagent(/reagent/medicine/kelotane,reagents.volume_max)
	return ..()

/obj/item/container/beaker/large/dylovene/Generate()
	reagents.add_reagent(/reagent/medicine/dylovene,reagents.volume_max)
	return ..()

/obj/item/container/beaker/large/water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)
	return ..()

/obj/item/container/beaker/large/potassium/Generate()
	reagents.add_reagent(/reagent/potassium,reagents.volume_max)
	return ..()

/obj/item/container/beaker/large/grenade_water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max*0.5)
	reagents.add_reagent(/reagent/iron,reagents.volume_max*0.5)
	return ..()

/obj/item/container/beaker/large/grenade_potassium/Generate()
	reagents.add_reagent(/reagent/potassium,reagents.volume_max*0.5)
	reagents.add_reagent(/reagent/iron,reagents.volume_max*0.5)
	return ..()

/obj/item/container/beaker/large/ice/
	name = "beaker of ice"

/obj/item/container/beaker/large/ice/Generate()
	reagents.add_reagent(/reagent/nutrition/ice,reagents.volume_max,T0C - 10)
	return ..()
