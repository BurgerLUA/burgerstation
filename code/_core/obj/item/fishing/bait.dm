/obj/item/fishing/bait
	name = "fishing bait"
	icon = 'icons/obj/item/fishing/bait.dmi'
	drop_sound = 'sound/items/drop/scrap.ogg'
	size = SIZE_0
	weight = 0.5
	value = 30
	var/wished_fishingzone
	var/effrewards
	var/wekrewards
	var/nice_bait = 0

	polymorphs = list(
		"base" = "#FFFFFF",
		"logo" = "#FFFFFF"
	)

/obj/item/fishing/bait/proc/get_bait()
	return src

/obj/item/fishing/bait/sea
	name = "sea fishing bait"
	desc = "hrngrnh fisheing"
	desc_extended = "Bait for sea fishing. Will get you some salty stuff."
	wished_fishingzone = 1
	effrewards = /loot/fishing/bait/baittest
	wekrewards = /loot/supply_crate/american
	polymorphs = list(
		"base" = "#3269A8",
		"logo" = "#FFFFFF"
	)

/obj/item/fishing/bait/sea/endless
	name = "endless sea fishing bait"
	desc = "hrngrnh ENDLESS fisheing"
	value = 1000
	nice_bait = 1

/obj/item/fishing/bait/sea/fish
	name = "sea fish bait"
	desc = "i will end the funny fish"
	desc_extended = "Bait for sea fish. Will get you some salty fishies."

/obj/item/fishing/bait/river
	name = "river fishing bait"
	desc = "phishe"
	desc_extended = "Bait for river fish. Will get you some neat fishies."
	polymorphs = list(
		"base" = "#36A2B5",
		"logo" = "#FFFFFF"
	)

/obj/item/fishing/bait/lava
	name = "lava fishing bait"
	desc = "revenge of the sunfish"
	desc_extended = "Bait for lava fishing. Will get you some warm fishies."
	wished_fishingzone = 10
	effrewards = /loot/supply_crate/russian
	polymorphs = list(
		"base" = "#DE6A21",
		"logo" = "#FFFFFF"
	)

/obj/item/fishing/bait/lava/fish
	name = "lava fish bait"
	desc = "revenge of the sunfish"
	desc_extended = "Bait for lava fishing. Will get you some warm fishies."
	wished_fishingzone = 10
	effrewards = /loot/supply_crate/russian

/obj/item/fishing/bait/lava/ore
	name = "lava blast-fishing bait"
	desc = "finally lava is USEFUL, kinda"
	desc_extended = "Bait for lava fishing. Will get you multiple ores and possibly gems."
	wished_fishingzone = 10
	effrewards = /loot/fishing/bait/lava/blast