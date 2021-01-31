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

/obj/item/fishing/bait/sea
	name = "sea fishing bait"
	desc = "hrngrnh fisheing"
	desc_extended = "Bait for sea fishing. Will get you some salty stuff."
	wished_fishingzone = 1
	effrewards = /loot/fishing/bait/trash
	polymorphs = list(
		"base" = "#3269A8",
		"logo" = "#FFFFFF"
	)

/obj/item/fishing/bait/sea/fish
	name = "sea fish bait"
	desc = "i will end the funny fish"
	desc_extended = "Bait for sea fish. Will get you some salty fishies."
	effrewards = /loot/fishing/bait/sea/fish

/obj/item/fishing/bait/sea/fish/endless
	name = "endless sea fishing bait"
	desc = "hrngrnh ENDLESS fisheing"
	desc_extended = "Bait for sea fish. Will get you some salty fishies. Comes at a cost, less chance to catch rare fish."
	effrewards = /loot/fishing/bait/sea/fish/endless
	value = 1000
	nice_bait = 1

/obj/item/fishing/bait/river
	name = "river fishing bait"
	desc = "phishin"
	desc_extended = "Bait for river fishing. Will get you some neat stuff."
	wished_fishingzone = 2
	effrewards = /loot/fishing/bait/trash
	polymorphs = list(
		"base" = "#36A2B5",
		"logo" = "#FFFFFF"
	)

/obj/item/fishing/bait/river/fish
	name = "river fishing bait"
	desc = "phishe"
	desc_extended = "Bait for river fish. Will get you some neat fishies."
	effrewards = /loot/fishing/bait/river/fish

/obj/item/fishing/bait/river/fish/endless
	name = "endless river fishing bait"
	desc = "hrngrnh ENDLESS fisheing"
	desc_extended = "Bait for river fish. Will get you some neat fishies. Comes at a cost, less chance to catch rare fish."
	value = 1000
	nice_bait = 1
	effrewards = /loot/fishing/bait/river/fish/endless

/obj/item/fishing/bait/lava
	name = "lava fishing bait"
	desc = "revenge of the sunfish"
	wished_fishingzone = 10
	effrewards = /loot/fishing/bait/trash
	polymorphs = list(
		"base" = "#DE6A21",
		"logo" = "#FFFFFF"
	)

/obj/item/fishing/bait/lava/loot
	name = "lava loot fishing bait"
	desc = "how does this even WORK"
	value = 1500
	desc_extended = "Bait for lava treasure fishing. Will get you some heat. Requires a lavaproof line. One use only."
	effrewards = /loot/supply_crate/all

/*
/obj/item/fishing/bait/lava/fish		no fish ready for that yet sadly
	name = "lava fish bait"
	desc = "revenge of the sunfish"
	desc_extended = "Bait for lava fishing. Will get you some warm fishies."
	wished_fishingzone = 10
	effrewards = /loot/fishing/bait/trash */

/obj/item/fishing/bait/loot
	name = "loot fishing bait"
	desc = "how do you FISH valuables??"
	desc_extended = "Bait that catches really cool stuff. It just works."
	wished_fishingzone = 69
	wekrewards = /loot/fishing/bait/trash
	polymorphs = list(
		"base" = "#FCF7A9",
		"logo" = "#FFFFFF"
	)

/obj/item/fishing/bait/loot/fishinggear
	name = "fishing gear bait"
	desc = "what do you mean i can just fish more fishing equipment"
	desc_extended = "Bait that catches fishing stuff. It just works. One use only."
	value = 1000
	wekrewards = /loot/fishing/bait/treasure/fishing

/obj/item/fishing/bait/loot/crates
	name = "fishing crate bait"
	desc = "WHAT DO CRATES EVEN EAT"
	desc_extended = "Bait that catches stuff from crates. Yeah. Yup. It just works."
	value = 500
	wekrewards = /loot/supply_crate/all


/*
/obj/item/fishing/bait/lava/ore
	name = "lava blast-fishing bait"
	desc = "finally lava is USEFUL, kinda"
	desc_extended = "Bait for lava fishing. Will get you multiple ores and possibly gems."
	wished_fishingzone = 10
	effrewards = /loot/fishing/bait/lava/blast	this is is disabled for ore reasons hush hush
*/