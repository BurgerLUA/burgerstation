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
		/loot/random/gun/slavic
	)

/loot/supply_crate/nanotrasen
	loot_table_guaranteed = list(
		/loot/random/gun/nanotrasen
	)

/loot/supply_crate/solarian
	loot_table_guaranteed = list(
		/loot/random/gun/solarian
	)

/loot/supply_crate/syndicate
	loot_table_guaranteed = list(
		/loot/random/gun/syndicate
	)

/loot/supply_crate/magic
	loot_table = list(
		/loot/currency/magic_token,
		/loot/random/gun/spellgem,
		/loot/random/support_gem,
		/obj/item/tempering/quality/ranged/magic,
		/obj/item/tempering/luck,
		/loot/random/scroll,
		/loot/potion,
		/obj/item/portal_scroll,
		/loot/soulgem/assorted
	)
	loot_count = 3
