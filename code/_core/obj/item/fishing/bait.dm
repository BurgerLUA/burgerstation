/obj/item/fishing/bait
	name = "fishing bait"
	icon = 'icons/obj/item/fishing/bait.dmi'
	drop_sound = 'sound/items/drop/scrap.ogg'
	size = SIZE_0
	weight = 0.5

	item_count_current = 5
	item_count_max = 25

	polymorphs = list(
		"base" = "#FFFFFF",
		"logo" = "#FFFFFF"
	)

	var/valid_turf
	var/nice_bait = FALSE

//Sea
/obj/item/fishing/bait/sea
	name = "saltwater fishing bait"
	desc = "For salty waters."
	desc_extended = "Bait for sea fishing. Will get you some salty fish."
	polymorphs = list(
		"base" = "#3269A8",
		"logo" = "#FFFFFF"
	)
	valid_turf = /turf/simulated/hazard/water/sea
	value = 50

/obj/item/fishing/bait/sea/infinite
	name = "endless saltwater fishing bait"
	desc = "For endless salt."
	desc_extended = "Bait for sea fishing. Will get you some salty fish, and will never be consumed on successful catches."
	value = 700
	nice_bait = TRUE
	item_count_current = 1
	item_count_max = 1


//River
/obj/item/fishing/bait/river
	name = "freshwater fishing bait"
	desc = "For fresh waters."
	desc_extended = "Bait for river fishing. Will get you fresh fish."
	polymorphs = list(
		"base" = "#36A2B5",
		"logo" = "#FFFFFF"
	)
	valid_turf = /turf/simulated/hazard/water
	value = 50

/obj/item/fishing/bait/river/infinite
	name = "endless freshwater fishing bait"
	desc = "For endless fish."
	desc_extended = "Bait for river fishing. Will get you fresh fish, and will never be consumed on successful catches."
	value = 700
	nice_bait = TRUE
	item_count_current = 1
	item_count_max = 1

//Lava
/obj/item/fishing/bait/lava
	name = "lava fishing bait"
	desc = "Get it while it's hot!"
	desc_extended = "Bait for lava fishing. Most of the time you don't actually catch fish with this as they'd all be dead."
	polymorphs = list(
		"base" = "#DE6A21",
		"logo" = "#FFFFFF"
	)
	valid_turf = /turf/simulated/hazard/lava/

	value = 250