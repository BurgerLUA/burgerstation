/loot/reward
	use_value = TRUE

/loot/reward/standard
	loot_table = list(
		/loot/random/scroll = 1,
		/loot/random/tempering = 1,
		/obj/item/portal_scroll = 1,
		/loot/potion = 1,
		/loot/soulgem/assorted = 1,
		/loot/rings/minor = 1,
	)
	chance_none = 50

//Things that survivors have when you loot them.
/loot/reward/bandit
	loot_table_guaranteed = list(
		/loot/currency/dosh/survivor,
		/loot/random/low,
		/loot/random/medium,
		/loot/reward/standard
	)
	loot_table = list(
		/loot/random/trash,
		/loot/random/medium,
	)
	chance_none = 80
	loot_count = 8