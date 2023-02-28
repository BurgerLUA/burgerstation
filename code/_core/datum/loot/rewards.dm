/loot/reward
	use_value = TRUE

/loot/reward/standard
	loot_table = list(
		/loot/scroll/lesser = 1,
		/loot/tempering_items = 1,
		/obj/item/portal_scroll = 1,
		/loot/potion = 1,
		/loot/soulgem/assorted = 1,
		/loot/rings/minor = 1,
	)
	chance_none = 50

//Things that survivors have when you loot them.
/loot/reward/survivor
	loot_table_guaranteed = list(
		/loot/currency/dosh/survivor,
		/loot/random/trash,
		/loot/random/low
	)
	loot_table = list(
		/obj/item/supply_crate/solarian = 1,
		/obj/item/supply_crate/medicine = 1,
		/loot/random/medium = 1

	)
	chance_none = 80


//Thiongs that revs have when you loot them
/loot/reward/slavic
	loot_table_guaranteed = list(
		/loot/random/trash,
		/loot/random/low,
		/loot/random/low,
	)
	loot_table = list(
		/obj/item/supply_crate/slavic = 1,
		/loot/random/medium = 1

	)
	chance_none = 80


/loot/slavic/back_storage
	loot_table = list(
		/obj/item/clothing/back/storage/backpack/rucksack,
		/obj/item/clothing/back/storage/backpack/explorer/black,
	)

/loot/slavic/back_storage/pre_spawn(var/atom/movable/M)
	. = ..()
	if(is_item(M))
		var/obj/item/I = M
		I.loot_to_generate = /loot/reward/slavic