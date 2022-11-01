/loot/supply_crate

/loot/supply_crate/medicine
	loot_table_guaranteed = list(
		/loot/medicine/pack

	)

/loot/supply_crate/all
	loot_table = list(
		/loot/supply_crate/slavic = 1,
		/loot/supply_crate/nanotrasen = 1,
		/loot/supply_crate/solarian = 1,
		/loot/supply_crate/syndicate = 1,
		/loot/supply_crate/magic = 1,
		/loot/supply_crate/medicine = 1
	)

/loot/supply_crate/slavic
	loot_table_guaranteed = list(
		/loot/gun/slavic
	)

/loot/supply_crate/nanotrasen
	loot_table_guaranteed = list(
		/loot/gun/nanotrasen
	)

/loot/supply_crate/solarian
	loot_table_guaranteed = list(
		/loot/gun/solarian
	)

/loot/supply_crate/syndicate
	loot_table_guaranteed = list(
		/loot/gun/syndicate
	)

/loot/supply_crate/magic
	loot_table = list(
		/loot/magic/soulgem = 9,
		/loot/magic/potion = 6,
		/obj/item/powergem = 3,
		/obj/item/weapon/ranged/spellgem/self_regenerate = 1,
	)
	loot_count = 3