/loot/revolutionary/bag
	loot_table = list(
		/obj/item/deployable/barbed_wire = 1,
		/obj/item/deployable/barricade = 1,
		/obj/item/doctor_bag = 1,
		/obj/item/supply_crate/slavic = 1,
		/obj/item/tempering/luck = 1,
		/obj/item/tempering/quality/general = 1,
		/obj/item/container/healing/bandage = 1,
		/obj/item/container/healing/ointment = 1,
		/obj/item/container/simple/alcohol/vodka/premium = 1,
		/obj/item/container/simple/alcohol/vodka = 1,
		/obj/item/container/simple/beaker/flask/russian = 1,
		/obj/item/container/syringe/medipen/epinephrine = 1,
		/obj/item/storage/cigarettes/slavic = 1,
		/obj/item/storage/kit/ai3/filled = 1,
		/obj/item/storage/pillbottle/space_prussian_blue_small = 1
	)
	loot_table_guaranteed = list(
		/obj/item/lighter,
		/obj/item/container/simple/alcohol/vodka,
		/loot/random/low
	)
	loot_count = 4
	chance_none = 20
	allow_duplicates = FALSE

/loot/revolutionary/back_storage
	loot_table = list(
		/obj/item/clothing/back/storage/backpack/rucksack,
		/obj/item/clothing/back/storage/backpack/explorer/black,
	)

/loot/revolutionary/back_storage/pre_spawn(var/atom/movable/M)
	. = ..()
	if(is_item(M))
		var/obj/item/I = M
		I.loot_to_generate = /loot/revolutionary/bag