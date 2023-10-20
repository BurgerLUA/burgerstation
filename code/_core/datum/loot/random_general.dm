/loot/random/trash
	value_min = 1
	value_max = 100
	rarity_min = RARITY_BROKEN
	rarity_max = RARITY_UNCOMMON

	use_random_quality_amounts = TRUE
	quality_min = 0
	quality_max = 50
	quality_mod_min = 0.75

/loot/random/trash/get_base_types()
	return subtypesof(base_type) - subtypesof(/obj/item/bullet_cartridge/)

/loot/random/trash/lots
	loot_count = 20
	chance_none = 75

/loot/random/low
	value_min = 100
	value_max = 500
	rarity_min = RARITY_BROKEN
	rarity_max = RARITY_COMMON

	use_random_quality_amounts = TRUE
	quality_min = 25
	quality_max = 75
	quality_mod_min = 0.75

/loot/random/low/lots
	loot_count = 10
	chance_none = 50

/loot/random/medium
	value_min = 500
	value_max = 1000
	rarity_min = RARITY_COMMON
	rarity_max = RARITY_UNCOMMON

	use_random_quality_amounts = TRUE
	quality_min = 50
	quality_max = 100
	quality_mod_min = 0.75

/loot/random/medium/lots
	loot_count = 5
	chance_none = 25

/loot/random/high
	value_min = 1000
	value_max = 2500
	loot_count = 2
	chance_none = 0
	rarity_min = RARITY_UNCOMMON
	rarity_max = RARITY_RARE

	use_random_quality_amounts = TRUE
	quality_min = 75
	quality_max = 100
	quality_mod_min = 0.75

/loot/random/extreme
	value_min = 2500
	value_max = 5000
	loot_count = 1
	chance_none = 0
	rarity_min = RARITY_UNCOMMON
	rarity_max = RARITY_RARE

	use_random_quality_amounts = TRUE
	quality_min = 100
	quality_max = 125
	quality_mod_min = 1