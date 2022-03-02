#define BEAKER(x) \
/obj/item/container/simple/beaker/large##x/Generate() { \
	reagents.add_reagent(##x,reagents.volume_max); \
	return ..();}

/obj/item/container/simple/beaker/large
	name = "large beaker"
	icon = 'icons/obj/item/container/cup/beaker_large.dmi'
	icon_state = "beaker"
	icon_count = 12

	reagents = /reagent_container/beaker/large

	value = 10

/obj/item/container/simple/beaker/large/lube_smoke_01/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,20)
	reagents.add_reagent(/reagent/potassium,40)
	reagents.add_reagent(/reagent/lube,60)
	return ..()

/obj/item/container/simple/beaker/large/lube_smoke_02/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,20)
	reagents.add_reagent(/reagent/phosphorous,40)
	reagents.add_reagent(/reagent/lube,60)
	return ..()

/obj/item/container/simple/beaker/large/bicaridine/Generate()
	reagents.add_reagent(/reagent/medicine/bicaridine,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/large/kelotane/Generate()
	reagents.add_reagent(/reagent/medicine/kelotane,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/large/dylovene/Generate()
	reagents.add_reagent(/reagent/medicine/dylovene,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/large/water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/large/potassium/Generate()
	reagents.add_reagent(/reagent/potassium,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/large/grenade_water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max*0.5)
	reagents.add_reagent(/reagent/iron,reagents.volume_max*0.5)
	return ..()

/obj/item/container/simple/beaker/large/grenade_potassium/Generate()
	reagents.add_reagent(/reagent/potassium,reagents.volume_max*0.5)
	reagents.add_reagent(/reagent/iron,reagents.volume_max*0.5)
	return ..()

/obj/item/container/simple/beaker/large/ice/
	name = "beaker of ice"

/obj/item/container/simple/beaker/large/ice/Generate()
	reagents.add_reagent(/reagent/nutrition/ice,reagents.volume_max,T0C - 10)
	return ..()
