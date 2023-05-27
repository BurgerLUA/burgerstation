#define BEAKER(x) \
/obj/item/container/simple/beaker/large##x/Generate() { \
	reagents.add_reagent(##x,reagents.volume_max); \
	return ..();}

/obj/item/container/simple/beaker/large
	name = "large beaker"
	icon = 'icons/obj/item/container/cup/beaker_large.dmi'
	icon_state = "beaker"
	icon_count = 10

	reagents = /reagent_container/beaker/large

	value = 10

	size = SIZE_2
	rarity = RARITY_UNCOMMON

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

/obj/item/container/simple/beaker/large/cleaing_smoke_01/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,20)
	reagents.add_reagent(/reagent/potassium,40)
	reagents.add_reagent(/reagent/space_cleaner,60)
	return ..()

/obj/item/container/simple/beaker/large/cleaing_smoke_02/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,20)
	reagents.add_reagent(/reagent/phosphorous,40)
	reagents.add_reagent(/reagent/space_cleaner,60)
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

/obj/item/container/simple/beaker/large/water_holy/Generate()
	reagents.add_reagent(/reagent/nutrition/water/holy,reagents.volume_max)
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
